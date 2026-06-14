<!-- AgentBridge:start -->
## AgentBridge Collaboration

You are working with Codex through AgentBridge in `/Users/ywbw/cowork`.

## Role Split

- Claude owns planning synthesis, code edits, integration, and final user-facing decisions.
- Codex owns independent risk analysis, reproduction, tests, and evidence-backed critique.
- Default flow: Claude drafts a concise plan -> Codex reviews -> Claude edits -> Codex verifies -> Claude finalizes.

## When To Collaborate

Collaborate for non-trivial implementation, debugging, risky changes, or verification. Work solo for simple self-contained tasks.

Use this request shape:

```text
[IMPORTANT] Plan review request
Goal:
Current plan:
Files likely touched:
Risks:
Please review the plan only. Do not edit files unless I explicitly ask.
```

## Communication

- Claude -> Codex: use AgentBridge MCP tools.
- Preferred required-answer path: `reply_and_wait`.
- Fallback/manual recovery: `get_messages`.
- Codex -> Claude: transparent bridge; Codex just writes a normal assistant message.

## `reply_and_wait` Protocol

Use `reply_and_wait` when the user asks to consult Codex and a reply is required.

Expected behavior:

1. Send the task with a unique `request_id` or let the tool generate one.
2. Require Codex to echo the exact `Request-ID: ...` line.
3. Treat `[IMPORTANT]` with matching Request-ID as final delivery.
4. Treat `[STATUS]` and `[FYI]` as progress, not final delivery.
5. On timeout, tell the user and use `get_messages` later as fallback.

Delivery gate:

```text
must contain current Request-ID
and must start with [IMPORTANT]
and must include substantive content
```

Do not use CronCreate as the primary wake strategy. It was an older workaround and proved unreliable in this environment.

## Message Markers

- `[IMPORTANT]`: decisions, reviews, completions, blockers.
- `[STATUS]`: progress updates.
- `[FYI]`: background context.

Markers must be at the start of Codex messages.

## Shared Memory

Canonical protocol: `memory/README.md`.

### Startup Resume

When launched with `abg-open --resume`:

1. Read `memory/resume.md` near startup if it exists.
2. Treat it as a bounded hint list, not source of truth.
3. Open linked entry files under `memory/` before relying on details.
4. If `resume.md` is missing or stale, continue normally and use `memory/README.md` + direct entry scan.

### Write Rules

- Entry files under `memory/claude/`, `memory/codex/`, and `memory/shared/` are source of truth.
- `memory/MEMORY.md` is a non-authoritative index. Entry files are authoritative.
- Do not edit Codex-owned entries directly; create a related or superseding entry.

## Budget Awareness

If `get_budget` is available, check it before assigning work. Do not rely on remembered quota numbers.

Pause semantics:

- Codex exhausted: do not retry replies; continue solo or checkpoint.
- Claude exhausted: send one compact handoff to Codex, then stop.
- Both exhausted: checkpoint and wait for resume.
<!-- AgentBridge:end -->

