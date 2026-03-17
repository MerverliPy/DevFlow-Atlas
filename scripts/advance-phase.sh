#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STATE="$ROOT/PHASE_STATE.json"

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <phase-number>" >&2
  echo "Allowed values: 0 1 2 3 4 5 6 7 8 9" >&2
  exit 1
fi

PHASE="$1"

case "$PHASE" in
  0) NAME="Skeleton repo" ;;
  1) NAME="Product and architecture lock" ;;
  2) NAME="App foundation and data model" ;;
  3) NAME="Auth, workspace, and product setup" ;;
  4) NAME="Graph canvas core" ;;
  5) NAME="Node action layer" ;;
  6) NAME="Today view and reminder loop" ;;
  7) NAME="Weekly review mode" ;;
  8) NAME="Onboarding template and polish" ;;
  9) NAME="Beta readiness" ;;
  *) echo "Invalid phase: $PHASE" >&2; exit 1 ;;
esac

cat > "$STATE" <<EOF2
{
  "current_phase": $PHASE,
  "phase_name": "$NAME",
  "policy": "Agents must only work inside the current phase. They must stop at phase completion and ask for explicit approval before the next phase.",
  "manual_advance_required": true
}
EOF2

echo "Updated $STATE to phase $PHASE ($NAME)"
echo "Remember to update COMPACT_CONTEXT.md and PHASE_HANDOFF.md for the new phase."
