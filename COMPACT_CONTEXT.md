# COMPACT_CONTEXT

## Current phase
Phase 2 — App foundation and data model

## Current objective
Scaffold Next.js app foundation with TypeScript, Tailwind, and base app shell. Slice 2A complete.

## Completed slices
- 1A: `docs/product/PRD-v1.md` and `docs/architecture/adr-001-product-scope.md` created
- 1B: `docs/architecture/adr-002-review-heuristics.md` created — due, upcoming, overdue, neglected, stale locked
- 1C: context files updated, Phase 1 closed out
- 2A: Next.js 14 + TypeScript + Tailwind scaffolded, base app shell created, lint/typecheck/build verified

## Active constraints
- Do not begin Slice 2B without explicit user approval
- Do not add Prisma yet (2B)
- Do not add Clerk yet (2C)
- Do not implement product features yet
- Keep stack fixed: Next.js 14, App Router, TypeScript, Tailwind, npm

## Immediate work
- Slice 2A is complete. Waiting for user permission to begin Slice 2B.
- Slice 2B: configure Prisma, create base schema (workspace, product, node, edge, note, checklist, reminder)

## Key decisions locked in Phase 1
- Product identity: manual-first operating graph
- Review heuristics: due (today), upcoming (next 7 days), overdue (past, incomplete), neglected (no activity 14+ days), stale (no content at all)
- Today view: overdue + due today + upcoming reminders
- Weekly review: overdue + neglected nodes + stale nodes

## Implementation notes (Phase 2A)
- Use `next.config.mjs` — Next.js 14 does not support `next.config.ts`
- Installed Next.js 14.2.35 via npm
