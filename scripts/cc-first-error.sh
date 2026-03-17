#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: $0 <log_file> [context_lines]" >&2
  exit 1
fi

LOG_FILE="$1"
CONTEXT="${2:-25}"

if [[ ! -f "$LOG_FILE" ]]; then
  echo "Error: log file not found: $LOG_FILE" >&2
  exit 1
fi

MATCH_LINE="$(grep -nEm1 '(ERROR|Error:|FAIL|Failed|Exception|Traceback|Cannot find module|Module not found|panic:|Caused by:)' "$LOG_FILE" | cut -d: -f1 || true)"

if [[ -z "${MATCH_LINE:-}" ]]; then
  echo "# No obvious error signature found."
  echo "# Last 120 lines:"
  echo
  tail -n 120 "$LOG_FILE"
  exit 0
fi

START=$(( MATCH_LINE - CONTEXT ))
END=$(( MATCH_LINE + CONTEXT ))

if (( START < 1 )); then
  START=1
fi

echo "# First likely error at line $MATCH_LINE"
echo "# Showing lines $START-$END"
echo

nl -ba "$LOG_FILE" | sed -n "${START},${END}p"
