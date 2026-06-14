---
schema_version: 1
id: 20260614-022000-claude-decision-memory-index-is-cache
title: MEMORY.md is a cache, not source of truth
type: decision
status: active
priority: high
visibility: shared
scope: cowork
agent: claude
created: 2026-06-14T02:20:00+08:00
updated: 2026-06-14T02:20:00+08:00
tags: [agentbridge, memory, index]
supersedes: null
related: []
---

# MEMORY.md is a cache, not source of truth

## Summary

Memory entry files are authoritative. `MEMORY.md` is only a human-readable index and may be regenerated.

## Context

Both agents may write memory entries. Concurrent appends to a shared index can lose updates.

## Decision

Agents create unique entry files and do not treat `MEMORY.md` as canonical.

## Alternatives Rejected

- Directly append to `MEMORY.md`: rejected because append/merge conflicts can corrupt the index.

## Impact

When recall matters, scan entry files first. Use `MEMORY.md` only as a convenience view.
