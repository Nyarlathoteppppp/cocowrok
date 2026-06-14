# Cowork Scripts

## Current Primary Path

Use AgentBridge MCP `reply_and_wait` for required Codex replies.

Flow:

```text
Claude reply_and_wait -> Codex normal assistant response -> AgentBridge resolves matching Request-ID
```

Codex should:

- Start final responses with `[IMPORTANT]`.
- Use `[STATUS]` for progress.
- Echo the exact `Request-ID: ...` line when present.

## `ask_codex.sh`

`ask_codex.sh` is a queue-only fallback. It does not send a bridge message by itself.

Use it only when you want to drop a request into:

```text
scratch/codex-queue.md
```

Then tell Claude:

```text
看看 codex 队列
```

Claude or an external scheduler must read the queue and send the actual AgentBridge message.

## Scratch Files

| File | Purpose |
|---|---|
| `scratch/codex-queue.md` | Pending manual requests |
| `scratch/codex-response.md` | Optional response cache |

