# Cowork Sandbox

Fixed AgentBridge collaboration workspace: `/Users/ywbw/cowork`.

## Layout

- `tasks/CURRENT.md`: current state and next actions.
- `tasks/archive/`: historical plans.
- `memory/`: shared memory protocol and entries.
- `scratch/`: disposable queues and experiments.
- `projects/`: linked/copied project workspaces.
- `logs/`: durable run notes.

## Start

```bash
abg-open --resume --logs
```

Useful variants:

```bash
abg-open --doctor
abg-open --kill-stale
abg-open --codex-workspace-write
abg-open --codex-full-access --codex-approval never --claude-permission-mode bypassPermissions
abg-open /path/to/project
```

## Roles

- Claude: plan synthesis, code edits, integration, final user response.
- Codex: independent review, reproduction, tests, evidence-backed verification.

Default flow:

```text
Claude drafts plan -> Codex reviews -> Claude edits -> Codex verifies -> Claude finalizes
```

## Message Protocol

- Claude should use `reply_and_wait` for required Codex answers when available.
- Codex final answers should start with `[IMPORTANT]`.
- Progress updates use `[STATUS]`.
- Background notes use `[FYI]`.
- If a message contains `Request-ID: ...`, Codex must echo that exact line in every related response.
- `get_messages` is fallback/manual recovery, not the primary wait path.

## Review Request

```text
[IMPORTANT] Plan review request
Goal:
Current plan:
Files likely touched:
Risks:
Please review the plan only. Do not edit files unless I explicitly ask.
```

