# PHASE_HANDOFF

## Completed
- Phase 0: repo scaffold, control files, scripts, stack lock
- Phase 1 Slice 1A: `docs/product/PRD-v1.md`, `docs/architecture/adr-001-product-scope.md`
- Phase 1 Slice 1B: `docs/architecture/adr-002-review-heuristics.md` — review heuristics locked
- Phase 1 Slice 1C: context files updated, Phase 1 closed out

## Phase 1 is complete

All product and architecture decisions are locked:
- Product identity and V1 scope (ADR-001)
- Review heuristics: due, upcoming, overdue, neglected, stale (ADR-002)
- Today view and Weekly review surface definitions (ADR-002)

## Current risks going into Phase 2
- `PHASE_STATE.json` must be manually advanced to phase 2 before any Phase 2 work begins
- `node.last_activity_at` must be added to the Prisma schema in Phase 2B
- The 7-day and 14-day review thresholds are locked constants — do not make them configurable

## Exact next action for Phase 2
1. User runs `./scripts/advance-phase.sh 2` to unlock Phase 2
2. Begin Phase 2 Slice 2A: scaffold Next.js 14 + TypeScript + Tailwind, add base app shell
3. Follow slice order: 2A → 2B → 2C → 2D
4. Do not skip verification between slices
