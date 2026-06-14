---
schema_version: 1
id: 20260614-022200-shared-convention-request-id-echo
title: Echo Request-ID in AgentBridge replies
type: convention
status: active
priority: high
visibility: shared
scope: cowork
agent: shared
created: 2026-06-14T02:22:00+08:00
updated: 2026-06-14T02:22:00+08:00
tags: [agentbridge, protocol]
supersedes: null
related: [20260614-022100-codex-gotcha-no-current-minute-cron]
---

# Echo Request-ID in AgentBridge replies

## Summary

When Claude includes `Request-ID: ...`, Codex must echo that exact line in the final `[IMPORTANT]` reply.

## Rule

Final Codex replies should start with `[IMPORTANT]` and include the exact `Request-ID` line.

## Examples

Good:
```text
[IMPORTANT] Request-ID: ask-codex-20260614-021200
Result: ...
```

Bad:
```text
[IMPORTANT] Done.
```
