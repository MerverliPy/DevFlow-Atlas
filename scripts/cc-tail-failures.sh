#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: $0 <log_file> [tail_lines]" >&2
  exit 1
fi

LOG_FILE="$1"
TAIL_LINES="${2:-120}"

if [[ ! -f "$LOG_FILE" ]]; then
  echo "Error: log file not found: $LOG_FILE" >&2
  exit 1
fi

echo "# Tail ($TAIL_LINES lines)"
echo
tail -n "$TAIL_LINES" "$LOG_FILE"

echo
echo "# Matching failure lines"
echo
grep -nE '(ERROR|Error:|FAIL|Failed|Exception|Traceback|Cannot find module|Module not found|panic:|Caused by:)' "$LOG_FILE" || true
