# ADR-002: Review Heuristics — Due, Upcoming, Overdue, Neglected, Stale

## Status
Accepted

## Context
DevFlow Atlas surfaces operational work through two review interfaces: the Today view and the Weekly review. For these views to be useful, the system needs clear, locked definitions for five attention states. Without locked definitions, implementation choices will diverge across phases and the review surfaces will behave inconsistently.

The heuristics must be:
- expressible as simple date comparisons or field presence checks
- implementable without external services or AI inference
- explainable to a user in one sentence each
- sufficient to drive the core loop: map graph → attach routines → return later → act on what needs attention

## Definitions

### due
A reminder whose scheduled date equals today's date and which has not been marked complete.

```
reminder.date == today AND reminder.completed == false
```

### upcoming
A reminder whose scheduled date falls within the next 7 days (exclusive of today) and which has not been marked complete.

```
reminder.date > today AND reminder.date <= today + 7 days AND reminder.completed == false
```

The 7-day window is locked for V1. It is short enough to feel actionable and long enough to allow light preparation.

### overdue
A reminder whose scheduled date is in the past and which has not been marked complete.

```
reminder.date < today AND reminder.completed == false
```

Overdue items are the highest-signal state. They represent explicit commitments the user has not fulfilled.

### neglected
A node that has had no activity within the last 14 days. Activity is defined as any of:
- a note created or updated on the node
- a checklist item checked off on the node
- a reminder completed on the node
- a reminder created on the node

```
node.last_activity_at < today - 14 days
```

`last_activity_at` is a denormalized timestamp updated on any of the above events. Nodes with no activity record at all are also considered neglected (never touched after creation beyond 14 days).

The 14-day threshold is locked for V1.

### stale
A node that has no reminders set, no checklist items, and no notes — it exists in the graph but has no operational content attached to it.

```
node has zero reminders AND zero checklist items AND zero notes
```

Stale differs from neglected. A neglected node once had content but has gone quiet. A stale node was never operationally set up. Both appear in the Weekly review for different reasons: neglected nodes need a check-in; stale nodes may need to be either populated or removed.

---

## Today View — V1 Surface Definition

The Today view is a lightweight daily attention surface. It answers: "What do I need to look at right now?"

**Today view surfaces:**
1. All overdue reminders (across all nodes and products in the workspace)
2. All due-today reminders
3. All upcoming reminders (next 7 days)

**Sort order:** overdue first (oldest first), then due today, then upcoming (soonest first).

**Today view does not surface:**
- neglected nodes (that belongs to the Weekly review)
- stale nodes (that belongs to the Weekly review)
- completed items

**Interaction target:** each item links directly to its parent node so the user can act immediately.

---

## Weekly Review — V1 Surface Definition

The Weekly review is a periodic attention surface. It answers: "What areas of my operation have gone quiet or are falling behind?"

**Weekly review surfaces:**
1. All overdue reminders not yet resolved (same as Today view — repeated for completeness during review)
2. All neglected nodes (no activity in 14+ days)
3. All stale nodes (no operational content at all)

**Sort order within each section:** overdue reminders sorted oldest-first; neglected nodes sorted by last_activity_at ascending (quietest first); stale nodes sorted by created_at ascending (oldest first).

**Weekly review does not surface:**
- due-today or upcoming reminders (those belong to Today view)
- completed items
- recently active nodes

**Interaction target:** each item links directly to the relevant node for immediate action.

---

## Implementation Notes for Coding Agents

1. `last_activity_at` must be a column on the `node` table, updated by a server-side write any time a note, checklist item, reminder, or runbook text is created or modified on that node.
2. All date comparisons use the user's local calendar date, not UTC timestamp, where possible. For V1, UTC is acceptable if local timezone handling is not yet implemented.
3. The 7-day and 14-day thresholds are product constants, not user-configurable in V1.
4. "Completed" for a reminder means a boolean `completed` flag on the reminder record.
5. The stale check is a simple join/count: if a node has zero rows in notes, checklist_items, and reminders, it is stale.
6. These heuristics require no ML, scoring, or external calls. They are pure database queries.

---

## Consequences

- Phase 6 (Today view) must implement the due/upcoming/overdue queries against the reminder table using the thresholds defined here.
- Phase 7 (Weekly review) must implement the neglected and stale queries against the node table using the thresholds defined here.
- The `node` table schema (Phase 2B) must include a `last_activity_at` column.
- If the 7-day or 14-day thresholds need adjustment after user feedback, that is a product decision requiring a new ADR or explicit user approval — not an implementation judgment call.
- Today view and Weekly review are intentionally separated. Do not merge them into a single surface in V1.
