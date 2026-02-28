#!/usr/bin/env bash
#
# lint-architecture.sh — Validate architectural boundaries
#
# This script checks that code follows the layer dependency rules
# defined in ARCHITECTURE.md. Customize the checks below for your
# project's specific module structure.
#
# Usage: ./scripts/lint-architecture.sh
#
# Exit codes:
#   0 — All checks passed
#   1 — Violations found
#

set -euo pipefail

VIOLATIONS=0
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=== Architectural Boundary Linter ==="
echo ""

# -------------------------------------------------------
# Layer dependency rules (customize for your project)
# -------------------------------------------------------
# Dependencies flow downward only:
#   Types → Config → Repo → Service → Runtime → UI
#
# Example checks (uncomment and adapt when you have source code):
#
# check_no_import "src/types" "src/config|src/repo|src/service|src/runtime|src/ui" "Types layer must not import from higher layers"
# check_no_import "src/config" "src/repo|src/service|src/runtime|src/ui" "Config layer must not import from higher layers"
# check_no_import "src/repo" "src/service|src/runtime|src/ui" "Repo layer must not import from Service, Runtime, or UI"
# check_no_import "src/service" "src/runtime|src/ui" "Service layer must not import from Runtime or UI"
# check_no_import "src/runtime" "src/ui" "Runtime layer must not import from UI"

check_no_import() {
  local source_dir="$1"
  local forbidden_pattern="$2"
  local message="$3"

  if [ ! -d "$source_dir" ]; then
    return 0
  fi

  local found
  found=$(grep -rn "from ['\"].*\(${forbidden_pattern}\)" "$source_dir" --include="*.ts" --include="*.tsx" --include="*.js" --include="*.jsx" 2>/dev/null || true)

  if [ -n "$found" ]; then
    echo -e "${RED}VIOLATION:${NC} $message"
    echo "$found"
    echo ""
    VIOLATIONS=$((VIOLATIONS + 1))
  fi
}

# -------------------------------------------------------
# File size check
# -------------------------------------------------------
echo "Checking file sizes (max 300 lines)..."
if [ -d "src" ]; then
  while IFS= read -r file; do
    lines=$(wc -l < "$file")
    if [ "$lines" -gt 300 ]; then
      echo -e "${YELLOW}WARNING:${NC} $file has $lines lines (max 300)"
      VIOLATIONS=$((VIOLATIONS + 1))
    fi
  done < <(find src -type f \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" \) 2>/dev/null)
fi

# -------------------------------------------------------
# Console.log check
# -------------------------------------------------------
echo "Checking for console.log in production code..."
if [ -d "src" ]; then
  found=$(grep -rn "console\.\(log\|warn\|error\|info\|debug\)" src --include="*.ts" --include="*.tsx" --include="*.js" --include="*.jsx" | grep -v "\.test\." | grep -v "__tests__" || true)
  if [ -n "$found" ]; then
    echo -e "${YELLOW}WARNING:${NC} Found console statements in production code:"
    echo "$found"
    echo ""
    VIOLATIONS=$((VIOLATIONS + 1))
  fi
fi

# -------------------------------------------------------
# Results
# -------------------------------------------------------
echo ""
if [ "$VIOLATIONS" -eq 0 ]; then
  echo -e "${GREEN}All architectural checks passed.${NC}"
  exit 0
else
  echo -e "${RED}Found $VIOLATIONS violation(s). Fix them before opening a PR.${NC}"
  exit 1
fi
