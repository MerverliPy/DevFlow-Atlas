#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

fail() { echo "FAIL: $1" >&2; exit 1; }
warn() { echo "WARN: $1"; }
pass() { echo "PASS: $1"; }

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
  [[ -f "$f" ]] || fail "missing required file: $f"
done
pass "core repo control files present"

if git rev-parse --show-toplevel >/dev/null 2>&1; then
  pass "inside git repo"
else
  fail "not inside a git repo"
fi

CURRENT_PHASE="$(grep -o '"current_phase":[[:space:]]*[0-9]*' PHASE_STATE.json | grep -o '[0-9]*' | head -n1)"
[[ -n "$CURRENT_PHASE" ]] || fail "could not parse current phase"
pass "current phase detected: $CURRENT_PHASE"

if [[ -f ".nvmrc" ]]; then
  REQUIRED_NODE="$(cat .nvmrc)"
  if command -v node >/dev/null 2>&1; then
    NODE_MAJOR="$(node -v | sed 's/v//' | cut -d. -f1)"
    if [[ "$NODE_MAJOR" == "$REQUIRED_NODE" ]]; then
      pass "node version matches .nvmrc ($REQUIRED_NODE)"
    else
      warn "node version mismatch: expected $REQUIRED_NODE, got $NODE_MAJOR"
    fi
  else
    warn "node not installed yet"
  fi
fi

if (( CURRENT_PHASE >= 2 )); then
  command -v npm >/dev/null 2>&1 || fail "npm is required for phase >= 2"
  pass "npm available"
fi

if (( CURRENT_PHASE >= 3 )); then
  [[ -f ".env.local" || -f ".env.example" ]] || fail "phase >= 3 expects .env.local or .env.example"
  pass "environment file available"
fi

if (( CURRENT_PHASE >= 4 )); then
  [[ -f "package.json" ]] || fail "phase >= 4 expects package.json"
  pass "package.json present"
fi

if [[ -n "$(git status --short 2>/dev/null)" ]]; then
  warn "working tree is not clean"
else
  pass "working tree clean"
fi

echo "Preflight complete."
