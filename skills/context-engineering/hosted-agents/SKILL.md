---
name: Hosted Agent Infrastructure
description: Design hosted or background agent infrastructure — sandboxed execution, remote coding environments, warm pools, session persistence, multiplayer collaboration, and self-spawning agents.
when_to_use: when building background coding agents that run independently of user devices, designing sandboxed execution environments, implementing multiplayer agent sessions, creating multi-client agent interfaces (Slack, web, Chrome extensions), or scaling agent infrastructure beyond local machine constraints
version: 1.2.0
languages: all
---

# Hosted Agent Infrastructure

Hosted agents run in remote sandboxed environments rather than on local machines. The critical insight is that **session speed should be limited only by model provider time-to-first-token**, with all infrastructure setup completed before the user starts their session.

## When to Activate

Activate this skill when:
- Building background coding agents that run independently of user devices
- Designing sandboxed execution environments for agent workloads
- Implementing multiplayer agent sessions with shared state
- Creating multi-client agent interfaces (Slack, Web, Chrome extensions)
- Scaling agent infrastructure beyond local machine constraints
- Building systems where agents spawn sub-agents for parallel work

Do not activate this skill for adjacent work:
- Designing the autonomous research loop, novelty gates, rollback policy: `harness-engineering`.
- Choosing supervisor, swarm, or handoff topology: `multi-agent-patterns`.
- Designing the tools used by a hosted agent: `tool-design`.
- Managing file-backed state inside a session: `filesystem-context`.

## Core Architecture (Three Layers)

Build sandbox infrastructure for isolated execution, an API layer for state management and client coordination, and client interfaces for user interaction across platforms. Keep these layers cleanly separated so sandbox changes do not ripple into clients.

## Sandbox Infrastructure

### Image Registry Pattern
Pre-build environment images on a regular cadence (every 30 minutes) because this makes synchronization with the latest code a fast delta rather than a full clone. Each image includes:
- Cloned repository at a known commit
- All runtime dependencies installed
- Initial setup and build commands completed
- Cached files from running app and test suite once

### Speed Optimizations

**Predictive Warm-Up**: Start warming the sandbox as soon as a user begins typing their prompt (not when they submit), because the typing interval (5-30 seconds) is enough to complete most setup.

**Parallel File Reading**: Allow the agent to start reading files immediately even if sync is not complete. Block file *edits* (not reads) until synchronization completes.

**Warm Pool Strategy**: Maintain a pool of pre-warmed sandboxes for high-volume repositories. Expire and recreate pool entries as new image builds complete.

### Snapshot and Restore

Take filesystem snapshots at key points to enable instant restoration for follow-up prompts:
- After initial image build (base snapshot)
- When agent finishes making changes (session snapshot)
- Before sandbox exit for potential follow-up

### Self-Spawning Agents

Expose three primitives: start a new session with specified parameters, read status of any session, and continue main work while sub-sessions run in parallel.

## Per-Session State Isolation

Isolate state per session (SQLite per session works well) — no session can impact another's performance. Architecture should handle hundreds of concurrent sessions.

## Authentication and Authorization

**User-Based Commits**: Use the prompting user's identity for commits (not the app identity) so PRs appear as authored by the human. This preserves the audit trail and prevents users from approving their own AI-generated changes.

**Sandbox-to-API Flow**:
1. Sandbox pushes changes (updating git user config)
2. Sandbox sends event to API with branch name and session ID
3. API uses user's GitHub token to create PR
4. GitHub webhooks notify API of PR events

## Multiplayer Support

Design for multiplayer from day one — it is nearly free to add with proper synchronization architecture. Unlocks:
- Teaching non-engineers to use AI effectively
- Live QA sessions with multiple team members
- Real-time PR review with immediate changes

## Client Implementations

**Slack Integration**: Prioritize as the first distribution channel for internal adoption — no syntax required, natural chat interface, creates a virality loop.

**Web Interface**: Real-time streaming on desktop and mobile, hosted VS Code inside sandbox, before/after screenshots for PRs.

**Chrome Extension**: Sidebar chat interface with DOM/React internals extraction (higher precision than raw screenshots at lower token cost).

## Metrics That Matter

- Sessions resulting in merged PRs (primary success metric)
- Time from session start to first model response
- PR approval rate and revision count

## Gotchas

1. **Cold start latency**: First sandbox spin-up takes 30-60s and users perceive this as broken. Use warm pools and predictive warm-up on keystroke.
2. **Image staleness**: Infrequent image rebuilds mean agents run with outdated dependencies. Set a 30-minute rebuild cadence.
3. **Sandbox cost runaway**: Set hard timeout limits (default 4 hours) and per-session cost ceilings.
4. **Auth token expiration mid-session**: Implement token refresh logic and check token validity before sensitive operations.
5. **Git config in sandboxes**: Missing `user.name` or `user.email` causes commit failures. Always set git identity explicitly during sandbox configuration.
6. **State loss on sandbox recycle**: Always snapshot before termination and extract artifacts (branches, PRs, files) before letting the sandbox die.
7. **Missing output extraction**: Build explicit extraction steps (push branch, create PR, return file contents) into the session teardown flow.
