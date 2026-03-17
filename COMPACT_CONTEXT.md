# COMPACT_CONTEXT

## Current phase
Phase 1 — Architecture and product decisions

## Current objective
Lock all product and architecture decisions required before any runtime code is written.

## Completed slices
- 1A: `docs/product/PRD-v1.md` and `docs/architecture/adr-001-product-scope.md` created
- 1B: `docs/architecture/adr-002-review-heuristics.md` created — due, upcoming, overdue, neglected, stale locked
- 1C: context files updated, Phase 1 closed out

## Active constraints
- Do not begin Phase 2 without explicit user approval and PHASE_STATE.json advancement to phase 2
- Keep stack choice fixed
- Keep marketing copy out of required engineering reads

## Immediate work
- Phase 1 is complete. Phase 2 is not unlocked yet.
- To unlock Phase 2: user must explicitly run `./scripts/advance-phase.sh 2` and grant approval before any Phase 2 work begins

## Key decisions locked in Phase 1
- Product identity: manual-first operating graph
- Review heuristics: due (today), upcoming (next 7 days), overdue (past, incomplete), neglected (no activity 14+ days), stale (no content at all)
- Today view: overdue + due today + upcoming reminders
- Weekly review: overdue + neglected nodes + stale nodes
