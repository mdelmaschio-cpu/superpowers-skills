---
name: Tool Design for Agents
description: Design the tool-interface layer for agent systems — tool descriptions, schemas, response formats, error recovery messages, MCP namespacing, and tool-set consolidation.
when_to_use: when writing new tool descriptions or schemas, debugging cases where the agent picks the wrong tool or generates malformed calls, consolidating an overlapping tool catalog, designing actionable error messages for agent self-recovery, or naming tools consistently across a catalog
version: 2.2.0
languages: all
---

# Tool Design for Agents

Design every tool as a contract between a deterministic system and a non-deterministic agent. Unlike human-facing APIs, agent-facing tools must make the contract unambiguous through the description alone: agents infer intent from descriptions and generate calls that must match expected formats. Every ambiguity becomes a potential failure mode that no amount of prompt engineering can fix.

## When to Activate

Activate this skill when the unit of work is a tool:
- Writing a new tool description, schema, or response format
- Debugging cases where the agent picked the wrong tool or generated malformed calls
- Consolidating an overlapping tool catalog ("we have 17 tools, the agent picks wrong half the time")
- Designing actionable error messages so the agent can self-correct
- Naming tools and parameters consistently across a catalog (MCP namespacing, verb-noun naming)
- Evaluating a third-party tool before adding it

Do not activate this skill for adjacent work:
- Deciding whether the project should use LLMs at all, or what the pipeline stages should be: `project-development`.
- Deciding whether to split work across sub-agents: `multi-agent-patterns`.
- Reducing the token weight of tool outputs at the trajectory level: `context-optimization`.

## The Consolidation Principle

If a human engineer cannot definitively say which tool should be used in a given situation, an agent cannot be expected to do better. **Reduce the tool set until each tool has one unambiguous purpose.**

Build single comprehensive tools instead of multiple narrow tools that overlap. Rather than implementing `list_users`, `list_events`, and `create_event` separately, implement `schedule_event` that finds availability and schedules in one call.

**When not to consolidate**: keep tools separate when they have fundamentally different behaviors, serve different contexts, or must be callable independently.

## Tool Description Engineering

Write every tool description to answer four questions:

1. **What does the tool do?** State exactly what the tool accomplishes.
2. **When should it be used?** Specify direct triggers and indirect signals.
3. **What inputs does it accept?** Describe each parameter with types, constraints, defaults, and format examples.
4. **What does it return?** Document output format, successful response examples, and error conditions.

**Good example:**
```python
def get_customer(customer_id: str, format: str = "concise"):
    """
    Retrieve customer information by ID.

    Use when:
    - User asks about specific customer details
    - Need customer context for decision-making

    Args:
        customer_id: Format "CUST-######" (e.g., "CUST-000001")
        format: "concise" for key fields, "detailed" for complete record

    Errors:
        NOT_FOUND: Customer ID not found
        INVALID_FORMAT: ID must match CUST-###### pattern
    """
```

**Bad example:**
```python
def search(query):
    """Search the database."""
    pass
```

## Error Message Design

Design error messages for two audiences: developers debugging issues and **agents recovering from failures**. For agents, every error message must be actionable — it must state what went wrong and how to correct it.

Include: retry guidance for retryable errors, corrected format examples for input errors, and specific missing fields for incomplete requests. An error that says only "failed" provides zero recovery signal.

## MCP Tool Naming Requirements

Always use fully qualified tool names with MCP to avoid "tool not found" errors.

Format: `ServerName:tool_name`

```python
# Correct: Fully qualified names
"Use the BigQuery:bigquery_schema tool to retrieve table schemas."
"Use the GitHub:create_issue tool to create issues."

# Incorrect: Unqualified names
"Use the bigquery_schema tool..."  # May fail with multiple servers
```

## Response Format Optimization

Offer response format options (concise vs. detailed) because tool response size significantly impacts context usage. Document when to use each format in the tool description so agents learn to select appropriately.

## Tool Audit Checklist

Before adding any tool to an agent:

1. **Name**: verb-noun, namespaced if the catalog has multiple domains.
2. **Description**: states what the tool does, when to use it, and what it returns.
3. **Schema**: every parameter has type, constraints, defaults, and example values.
4. **Return shape**: success and error payloads are documented and machine-readable.
5. **Recovery**: each error tells the agent what to change before retrying.
6. **Overlap**: no other tool has the same activation scenario.
7. **Consolidation decision**: adjacent narrow tools are merged unless independent calls are required.
8. **Token impact**: large responses support concise mode or file-reference mode.

## Gotchas

1. **Vague descriptions**: "Search the database for customer information" leaves too many questions unanswered.
2. **Cryptic parameter names**: Parameters named `x`, `val`, or `param1` force agents to guess meaning.
3. **Missing error recovery guidance**: Every error response must tell the agent what went wrong and what to try next.
4. **Inconsistent naming across tools**: Using `id` in one tool, `identifier` in another, and `customer_id` in a third creates confusion.
5. **MCP namespace collisions**: When multiple MCP servers register tools with similar names, agents cannot disambiguate. Always use `ServerName:tool_name`.
6. **Tool description rot**: Descriptions become inaccurate as underlying APIs evolve. Treat descriptions as code: version them, review them during API changes.
7. **Over-consolidation**: A single tool with too many parameters or workflows becomes hard for agents to parameterize correctly. Split if it requires more than 8-10 parameters.
8. **Parameter explosion**: Each parameter the agent must evaluate adds cognitive load. Provide sensible defaults and group related options into format presets.
