---
schema_version: 1
id: 20260614-022600-claude-decision-bad-missing-status
title: Bad entry missing lifecycle status
type: decision
priority: high
visibility: shared
scope: cowork
agent: claude
created: 2026-06-14T02:26:00+08:00
updated: 2026-06-14T02:26:00+08:00
tags: [bad-example]
supersedes: null
related: []
---

# Bad entry missing lifecycle status

## Summary

This entry is invalid because it has no `status` field.

Expected behavior: warn and treat as `stale` or skip from default recall.
