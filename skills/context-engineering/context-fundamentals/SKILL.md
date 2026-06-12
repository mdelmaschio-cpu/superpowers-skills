---
name: Context Engineering Fundamentals
description: Foundational concepts of context engineering — what context is, anatomy of a context window, attention mechanics, U-shaped attention curve, and the mental models underlying every other context-engineering decision.
when_to_use: when explaining or reasoning about foundational context engineering concepts, onboarding contributors who need mental models before diving into operational skills, or reasoning about a context-related design decision from first principles before picking a specific tactic
version: 2.2.0
languages: all
---

# Context Engineering Fundamentals

Context is the complete state available to a language model at inference time: system instructions, tool definitions, retrieved documents, message history, and tool outputs. Context engineering is the discipline of curating the smallest high-signal token set that maximizes the likelihood of desired outcomes.

This skill is the conceptual foundation that every other skill in the collection builds on. It explains what context is, how attention mechanics work, why context quality matters more than quantity, and the mental models needed to interpret every other context-engineering decision. It does not own operational work: debugging attention failures belongs to `context-degradation`, token-efficiency tactics belong to `context-optimization`, conversation summarization belongs to `context-compression`, file-based offloading belongs to `filesystem-context`, and project-shape decisions belong to `project-development`.

## When to Activate

Activate this skill when the work is conceptual:

- Explaining what context is and how attention mechanics constrain agent behavior.
- Onboarding new contributors who need the mental models before diving into operational skills.
- Reasoning about a context-related design decision from first principles (what does this constraint mean, why does this trade-off exist) before picking a specific tactic.
- Writing or reviewing documentation that needs to ground operational guidance in the underlying mechanics.

Do not activate this skill for operational work. The specialized skills handle the doing:

- Diagnosing lost-in-middle, context poisoning, or attention failures: `context-degradation`.
- Reducing token cost via masking, partitioning, prefix caching, budgets: `context-optimization`.
- Compressing a long session into a handoff summary: `context-compression`.
- Offloading large tool outputs or maintaining a durable scratchpad: `filesystem-context`.
- Deciding the shape of an LLM project or pipeline: `project-development`.

## Core Concepts

Treat context as a finite attention budget, not a storage bin. Every token added competes for the model's attention and depletes a budget that cannot be refilled mid-inference. The engineering problem is maximizing utility per token against three constraints: the hard token limit, the softer effective-capacity ceiling, and the U-shaped attention curve that penalizes information placed in the middle of context.

Apply four principles when assembling context:

1. **Informativity over exhaustiveness** — include only what matters for the current decision; design systems that can retrieve additional information on demand.
2. **Position-aware placement** — place critical constraints at the beginning and end of context because long-context evaluations show middle-position information is less reliably recovered than edge-position information.
3. **Progressive disclosure** — load skill names and summaries at startup; load full content only when a skill activates for a specific task.
4. **Iterative curation** — context engineering is not a one-time prompt-writing exercise but an ongoing discipline applied every time content is passed to the model.

## Detailed Topics

### The Anatomy of Context

**System Prompts**
Organize system prompts into distinct sections using XML tags or Markdown headers (background, instructions, tool guidance, output format). System prompts persist throughout the conversation, so place the most critical constraints at the beginning and end where attention is strongest.

Calibrate instruction altitude to balance two failure modes. Too-low altitude hardcodes brittle logic that breaks when conditions shift. Too-high altitude provides vague guidance that fails to give concrete signals for desired behavior. Aim for heuristic-driven instructions: specific enough to guide behavior, flexible enough to generalize.

Start minimal, then add instructions reactively based on observed failure modes rather than preemptively stuffing edge cases. Curate diverse, canonical few-shot examples that portray expected behavior instead of listing every possible scenario.

**Tool Definitions**
Write tool descriptions that answer three questions: what the tool does, when to use it, and what it returns. Include usage context, parameter defaults, and error cases — agents cannot disambiguate tools that a human engineer cannot disambiguate either.

Keep the tool set minimal. Consolidate overlapping tools because bloated tool sets create ambiguous decision points and consume disproportionate context after JSON serialization (tool schemas typically inflate 2-3x compared to equivalent plain-text descriptions).

**Retrieved Documents**
Maintain lightweight identifiers (file paths, stored queries, web links) and load data into context dynamically using just-in-time retrieval. Strong identifiers let agents locate relevant files even without search tools; weak identifiers force unnecessary loads.

When chunking large documents, split at natural semantic boundaries (section headers, paragraph breaks) rather than arbitrary character limits that sever mid-concept.

**Message History**
Message history serves as the agent's scratchpad memory. For long-running tasks, it can grow to dominate context usage — monitor and apply compaction before it crowds out active instructions.

**Tool Outputs**
Tool outputs often dominate context in agent trajectories. Apply observation masking: replace verbose outputs with compact references once the agent has processed the result.

### Context Windows and Attention Mechanics

**The Attention Budget**
For n tokens, the attention mechanism computes n-squared pairwise relationships. As context grows, the model's ability to maintain these relationships degrades — not as a hard cliff but as a performance gradient. Design for this gradient: assume effective capacity is materially below the advertised window until measured on the target workload.

**Progressive Disclosure in Practice**
1. **Skill selection** — load only names and descriptions at startup; activate full skill content on demand.
2. **Document loading** — load summaries first; fetch detail sections only when the task requires them.
3. **Tool result retention** — keep recent results in full; compress or evict older results.

### Context Quality Versus Quantity

Reject the assumption that larger context windows solve memory problems. Processing cost grows disproportionately with context length. Apply the signal-density test: for each piece of context, ask whether removing it would change the model's output. If not, remove it.

## Guidelines

1. Treat context as a finite resource with diminishing returns
2. Place critical information at attention-favored positions (beginning and end)
3. Use progressive disclosure to defer loading until needed
4. Organize system prompts with clear section boundaries
5. Monitor context usage during development
6. Implement compaction triggers at 70-80% utilization
7. Design for context degradation rather than hoping to avoid it
8. Prefer smaller high-signal context over larger low-signal context

## Gotchas

1. **Nominal window is not effective capacity**: A model advertising a large context window may degrade well before that limit on complex retrieval or reasoning tasks.
2. **Character-based token estimates silently drift**: The ~4 characters/token heuristic breaks down for code (2-3 chars/token), URLs/paths, and non-English text.
3. **Tool schemas inflate 2-3x after JSON serialization**: Ten tools with moderate schemas can consume 5,000-8,000 tokens before a single message is sent.
4. **Message history balloons silently in agentic loops**: After 20-30 iterations, history can consume 70-80% of the window. Set a hard token ceiling and trigger compaction proactively.
5. **Critical instructions in the middle get lost**: The U-shaped attention curve means the middle receives 10-40% less recall accuracy. Anchor safety constraints and output format requirements at the top or bottom.
6. **Progressive disclosure that loads too eagerly defeats its purpose**: Set strict activation thresholds — a skill should load only when the task explicitly matches its trigger conditions.

## Routing Map

- `context-degradation`: diagnosing attention failures, lost-in-middle, poisoning, distraction.
- `context-optimization`: token-efficiency tactics (masking, partitioning, caching, budgets).
- `context-compression`: compacting long sessions while preserving decisions, files, risks.
- `filesystem-context`: offloading large outputs and using files as a durable scratchpad.
- `memory-systems`: cross-session memory architectures with entity tracking.
- `multi-agent-patterns`: when to split work across agents for context isolation.
- `tool-design`: writing tool descriptions and schemas that route correctly.
- `project-development`: deciding LLM fit and shaping multi-stage pipelines.
