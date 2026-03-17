# PROJECT_MEMORY

## Project goal
Build DevFlow Atlas as a manual-first operating graph for indie software businesses.

The product should let a user map how their software business runs, attach routines directly to nodes, and return later to manage upkeep from one calm visual control surface.

## Core V1 loop
1. create a graph of the product and operating surfaces
2. attach notes, checklists, reminders, and runbook text to nodes
3. return later and see due, upcoming, overdue, and neglected operational work
4. act directly from the graph or review surfaces

## Locked product constraints
- V1 is manual-first
- V1 includes graph creation, node actions, Today view, and Weekly review
- V1 excludes deep integrations, AI suggestions, collaboration, advanced analytics, and complex billing
- The graph should be operational, not decorative
- Visual polish matters, but should not trigger design-system overbuild

## Locked technical stack
See `docs/architecture/STACK_LOCK.md` for the full source of truth.

## Target users
- indie hackers with multiple live products
- solo SaaS builders
- technical founders running lean operations
- tiny teams without appetite for enterprise tooling

## Domain terms
- workspace: top-level container for a user’s operating graph environment
- product: one software product inside a workspace
- node: a mapped operational surface, lifecycle area, or responsibility zone
- edge: a visual relationship between nodes
- routine: a repeatable operational action attached to a node
- Today view: lightweight daily attention surface
- Weekly review: review surface for overdue, neglected, and stale operational areas

## Locked review heuristics (ADR-002)
These are product constants for V1. Do not make them configurable.

- **due**: reminder.date == today AND not completed
- **upcoming**: reminder.date within next 7 days (exclusive of today) AND not completed
- **overdue**: reminder.date < today AND not completed
- **neglected**: node.last_activity_at < today − 14 days (activity = note/checklist/reminder created, updated, or completed on the node)
- **stale**: node has zero notes, zero checklist items, and zero reminders

**Today view surfaces:** overdue reminders → due-today reminders → upcoming reminders (sorted oldest/soonest first within each group)

**Weekly review surfaces:** overdue reminders → neglected nodes (quietest first) → stale nodes (oldest first)

**Locked constraints (ADR-002):**
- `node.last_activity_at` is a required column on the node table, updated on any note, checklist, reminder, or runbook change on that node
- The 7-day and 14-day thresholds are locked product constants, not user-configurable
- All heuristic checks are pure database queries — no ML, scoring, or external calls

## Approved V1 capabilities
- auth
- workspace creation
- one or more products inside a workspace
- manual node and edge creation
- node notes
- node checklists
- node reminders
- basic runbook text
- Today view
- Weekly review
- onboarding template

## Excluded V1 capabilities
- repo/tool auto-import
- AI-generated suggestions
- collaboration
- real-time editing
- deep integrations
- advanced analytics
- complex plan/billing logic
