---
schema_version: 1
id: 20260614-022100-codex-gotcha-no-current-minute-cron
title: Do not schedule current-minute one-shot CronCreate
type: gotcha
status: active
priority: critical
visibility: shared
scope: cowork
agent: codex
created: 2026-06-14T02:21:00+08:00
updated: 2026-06-14T02:21:00+08:00
tags: [agentbridge, cron, polling]
supersedes: null
related: []
---

# Do not schedule current-minute one-shot CronCreate

## Summary

One-shot CronCreate uses minute-level cron. A target less than 120 seconds away can be missed or scheduled far in the future.

## Trigger

Claude tries to wake itself 20 seconds later after sending a Codex request.

## Failure Mode

The cron may not fire, and the user must manually ask Claude to call `get_messages`.

## Safe Procedure

Use quick polling for the first 20 seconds, then schedule a one-shot cron at least 120 seconds in the future and rounded to the next local minute.
