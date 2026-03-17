# ADR-001: Product Scope — Manual-First Operating Graph

## Status
Accepted

## Context
DevFlow Atlas needs a clear product identity before any implementation begins. Without a locked scope, the graph canvas risks becoming a generic diagram tool, an enterprise portal, or an AI-assisted workflow builder — none of which serve the target user.

## Decision

### Identity: manual-first operating graph
DevFlow Atlas is an operating graph, not a diagram. The distinction matters:
- A diagram represents structure for communication or documentation.
- An operating graph is a live control surface. Every node is a responsibility zone the user actively manages. Every routine attached to a node is actionable, not decorative.

The product is manual-first because:
- The target user is a solo or near-solo operator. Their operations are too idiosyncratic for auto-generated graphs to be useful.
- Manual construction forces clarity. The act of placing a node and naming it is itself valuable.
- Manual operation removes the fragility of external integrations at V1.

### Why V1 excludes AI suggestions
AI-generated graph suggestions would:
- Remove the intentionality that gives the graph meaning
- Add infrastructure complexity (LLM calls, prompt management, context boundaries) before core value is proven
- Risk producing generic, low-signal graphs that users do not trust

AI features are deferred, not ruled out permanently.

### Why V1 excludes deep integrations
Integrations with GitHub, Linear, Slack, and similar tools would:
- Make every sync question a product decision (what triggers, what updates, conflict resolution)
- Add failure modes before the core loop is validated
- Require compliance, auth scopes, and webhook infrastructure disproportionate to V1 goals

The graph is fed by the user's knowledge, not by external event streams.

### Why V1 excludes real-time collaboration
Real-time collaboration requires:
- Operational transforms or CRDT-based conflict resolution
- Presence awareness UI
- Multi-user permission modeling

None of this serves the primary user, who is a solo or near-solo operator. Adding it at V1 would bloat the foundation before product-market fit.

### Why the graph must be operational, not decorative
The graph canvas must enforce operational semantics:
- Nodes represent areas the user is responsible for maintaining.
- Routines (notes, checklists, reminders, runbooks) are attached directly to nodes.
- The review surfaces (Today view, Weekly review) derive their content from graph state.

If the graph were purely decorative — a static org chart or system diagram — there would be no reason to return to it. The graph must degrade visibly when work is neglected: nodes should surface overdue or stale state directly from the canvas.

### Why DevFlow Atlas is not a static diagram tool
Static diagram tools (Miro, Lucidchart, Whimsical) produce outputs for sharing and communication. They have no concept of overdue, neglected, or stale. DevFlow Atlas is not a place to document how a product works — it is a place to run it.

### Why DevFlow Atlas is not an enterprise portal
Enterprise portals (Notion, Confluence, Linear) are built for teams, workflows, approvals, and integrations. They carry complexity that is hostile to the solo operator. DevFlow Atlas is deliberately small and opinionated: one user, one workspace, direct action.

### Why DevFlow Atlas is not a generic workflow builder
Generic workflow builders (n8n, Zapier, Make) automate processes between external services. DevFlow Atlas does not automate. It surfaces what needs human attention and makes acting on it easy.

## Consequences
- Implementation must always ask: does this feature make the graph more operational?
- UI work should prioritize the review surfaces and action loops over visual customization.
- Any new feature that requires an external service dependency at V1 should be rejected or deferred.
- The graph library (React Flow) is chosen to support an operational canvas, not a presentation tool — avoid features that push it toward decoration.
