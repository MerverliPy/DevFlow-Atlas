# DevFlow Atlas V1 — Product Requirements

## Product goal
Give indie software builders a single calm surface to map how their business runs, attach operational routines to each area, and return later to see what needs attention — without requiring integrations, automation, or a team.

## Target users
- Indie hackers managing multiple live products
- Solo SaaS builders
- Technical founders running lean operations
- Tiny teams unwilling to adopt enterprise tooling

These users share a common problem: operational work is scattered across mental models, sticky notes, and ad-hoc tools. Nothing shows them the whole picture or surfaces what is overdue.

## V1 scope

### Authentication and workspace
- Sign in and sign up via Clerk
- One workspace per user at V1
- One or more products inside a workspace

### Graph
- Manual node creation, editing, deletion
- Manual edge creation and deletion
- Node label and description editing
- No auto-layout enforcement; user positions nodes freely

### Node actions
- Notes: freeform text attached to a node
- Checklists: repeatable or one-time task lists on a node
- Reminders: date-based reminders tied to a node
- Runbook text: structured operational notes on a node

### Review surfaces
- Today view: surfaces due and upcoming reminders across all nodes
- Weekly review: surfaces overdue, neglected, and stale nodes

### Onboarding
- Starter template with a pre-built graph illustrating a sample product operation

## Non-goals for V1
- Repo or tool auto-discovery
- AI-generated suggestions or automated graph population
- Real-time or async collaboration
- Real-time multiplayer editing
- Deep external integrations (GitHub, Linear, Slack, etc.)
- Advanced analytics or trend reporting
- Complex billing, plan tiers, or team seat management
- Export to other formats

## Core product loop
1. User creates a graph representing their product's operational areas
2. User attaches notes, checklists, reminders, and runbook text to nodes
3. User returns on a daily or weekly cadence
4. Today view and Weekly review surface what needs attention
5. User acts directly from the review surface or navigates to the node

## Success criteria
- A user can create a complete graph of one product's operations in under 15 minutes
- A user can return after a week and immediately see what is overdue or neglected
- A user can act on a reminder, check off a checklist item, or update a node note without leaving the product
- No external service connection is required to derive value
- The UI is visually restrained and does not feel like a project management tool or org chart editor
