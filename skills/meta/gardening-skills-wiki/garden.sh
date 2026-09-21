#!/bin/bash
# Master gardening script for skills wiki maintenance

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Default to this repository's own skills/ tree. The scripts live at
# <repo>/skills/meta/gardening-skills-wiki/, so ../.. is <repo>/skills.
# Previously this defaulted to a hardcoded personal path; when that path did
# not exist every check silently found nothing and printed a passing report.
DEFAULT_SKILLS_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
SKILLS_DIR="${1:-$DEFAULT_SKILLS_DIR}"

if [ ! -d "$SKILLS_DIR" ]; then
    echo "ERROR: skills directory not found: $SKILLS_DIR" >&2
    echo "Usage: $(basename "$0") [path/to/skills]" >&2
    exit 2
fi

echo "=== Skills Wiki Health Check ==="
echo "Checking: $SKILLS_DIR"
echo ""

# Make scripts executable if not already
chmod +x "$SCRIPT_DIR"/*.sh 2>/dev/null

status=0

# Run all checks
bash "$SCRIPT_DIR/check-naming.sh" "$SKILLS_DIR" || status=1
echo ""

bash "$SCRIPT_DIR/check-links.sh" "$SKILLS_DIR" || status=1
echo ""

bash "$SCRIPT_DIR/check-index-coverage.sh" "$SKILLS_DIR" || status=1

echo ""
echo "=== Health Check Complete ==="
echo ""
echo "Fix: ❌ errors (broken/missing) | Consider: ⚠️  warnings | ✅ = correct"

exit $status
