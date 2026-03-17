#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

LOG_FILE="/tmp/devflow-atlas-phase-verify.log"
: > "$LOG_FILE"

run_and_log() {
  local label="$1"
  shift
  echo "==> $label" | tee -a "$LOG_FILE"
  if "$@" 2>&1 | tee -a "$LOG_FILE"; then
    echo "PASS: $label" | tee -a "$LOG_FILE"
  else
    echo "FAIL: $label" | tee -a "$LOG_FILE"
    echo
    echo "Verification failed. Inspect:"
    echo "  $LOG_FILE"
    echo "  ./scripts/cc-first-error.sh $LOG_FILE 25"
    echo "  ./scripts/cc-tail-failures.sh $LOG_FILE 120"
    exit 1
  fi
}

CURRENT_PHASE="$(grep -o '"current_phase":[[:space:]]*[0-9]*' PHASE_STATE.json | grep -o '[0-9]*' | head -n1)"
[[ -n "$CURRENT_PHASE" ]] || { echo "Could not parse current phase" >&2; exit 1; }

if (( CURRENT_PHASE <= 1 )); then
  required_files=(
    "CLAUDE.md"
    ".claude/settings.json"
    "PROJECT_MEMORY.md"
    "COMPACT_CONTEXT.md"
    "PHASE_HANDOFF.md"
    "PHASE_STATE.json"
    "docs/architecture/STACK_LOCK.md"
    "docs/plan/IMPLEMENTATION_PHASES.md"
    "docs/plan/IMPLEMENTATION_SLICES.md"
  )
  for f in "${required_files[@]}"; do
    [[ -f "$f" ]] || { echo "Missing required file: $f" >&2; exit 1; }
  done
  echo "Phase $CURRENT_PHASE verification passed: control files present."
  exit 0
fi

[[ -f "package.json" ]] || { echo "Missing package.json" >&2; exit 1; }

if npm run | grep -q ' lint'; then
  run_and_log "npm run lint" npm run lint
fi

if npm run | grep -q ' typecheck'; then
  run_and_log "npm run typecheck" npm run typecheck
fi

if npm run | grep -q ' test'; then
  run_and_log "npm run test" npm run test
fi

if npm run | grep -q ' build'; then
  run_and_log "npm run build" npm run build
fi

echo "Verification complete."
