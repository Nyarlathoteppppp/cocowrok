# Current Cowork State

## Active

- AgentBridge fork now has `reply_and_wait` on `master`.
- Next operational step: refresh the local Claude plugin cache and restart/reload AgentBridge sessions.
- Shared memory Phase 0 exists, but resume automation is not active.

## Daily Flow

1. Start with `abg-open --resume --logs`.
2. Claude asks Codex using `reply_and_wait` when it needs a required answer.
3. Codex replies normally, starting important final messages with `[IMPORTANT]`.
4. Codex echoes the exact `Request-ID: ...` line when present.
5. Use `get_messages` only as fallback/manual recovery.

## Archived Plans

Detailed historical plans were moved to:

- `tasks/archive/memory-phase0-plan.md`
- `tasks/archive/memory-phase1-plan.md`

