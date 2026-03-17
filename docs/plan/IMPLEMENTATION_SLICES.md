# DevFlow Atlas — Execution Slices

## Standard rules for every slice
- run `./scripts/phase-preflight.sh` before implementation work
- work only inside the current phase and current slice
- do not begin the next slice automatically
- run `./scripts/phase-verify.sh` after implementation work
- stop immediately after verification
- if verification fails, fix the smallest failing scope only

---

## PHASE 1 SLICES
### 1A
- create `docs/product/PRD-v1.md`
- create `docs/architecture/adr-001-product-scope.md`

### 1B
- create `docs/architecture/adr-002-review-heuristics.md`
- define overdue, upcoming, neglected, stale

### 1C
- update `PROJECT_MEMORY.md`
- update `COMPACT_CONTEXT.md`
- update `PHASE_HANDOFF.md`

---

## PHASE 2 SLICES
### 2A
- scaffold Next.js 14 + TypeScript + Tailwind
- add base app shell

### 2B
- configure Prisma
- create base schema for:
  - workspace
  - product
  - node
  - edge
  - note
  - checklist
  - reminder

### 2C
- add Clerk integration shell
- confirm app boots and routes render

### 2D
- verify build/lint/test baseline

---

## PHASE 3 SLICES
### 3A
- protected routing
- auth shell
- sign-in/sign-up flow

### 3B
- workspace creation
- first product creation

### 3C
- onboarding routing into graph area
- verify protected app flow

---

## PHASE 4 SLICES
### 4A
- graph canvas shell with static sample data

### 4B
- node CRUD

### 4C
- edge CRUD

### 4D
- persist graph state

### 4E
- reload/edit/return verification

---

## PHASE 5 SLICES
### 5A
- node detail panel shell

### 5B
- notes CRUD

### 5C
- checklist CRUD

### 5D
- reminder CRUD

### 5E
- runbook text + combined node-action verification

---

## PHASE 6 SLICES
### 6A
- reminder query logic
- due/upcoming model

### 6B
- Today view UI

### 6C
- Today-to-node navigation and quick action loop

---

## PHASE 7 SLICES
### 7A
- neglected and stale heuristics implementation

### 7B
- Weekly review UI

### 7C
- review-to-node navigation and verification

---

## PHASE 8 SLICES
### 8A
- starter template

### 8B
- onboarding improvements and empty states

### 8C
- premium polish pass, restrained and minimal

---

## PHASE 9 SLICES
### 9A
- deploy config and environment setup polish

### 9B
- QA checklist and release sanity pass

### 9C
- beta-readiness verification and handoff
