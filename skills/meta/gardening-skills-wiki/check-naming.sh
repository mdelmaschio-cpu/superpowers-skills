#!/bin/bash
# Check naming consistency in skills wiki

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_SKILLS_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
SKILLS_DIR="${1:-$DEFAULT_SKILLS_DIR}"

if [ ! -d "$SKILLS_DIR" ]; then
    echo "ERROR: skills directory not found: $SKILLS_DIR" >&2
    exit 2
fi

echo "## Naming & Structure"

warnings=0
errors=0

# Note: counters are updated in the main shell, so the loops below must not be
# fed by a pipe. `while ... done < <(find ...)` keeps them out of a subshell;
# `find ... | while` would discard every increment and always report success.
while IFS= read -r dir; do
    dir_name=$(basename "$dir")

    if [[ "$dir_name" == "INDEX.md" ]] || [[ "$(dirname "$dir")" == "$SKILLS_DIR" ]]; then
        continue
    fi

    if [[ "$dir_name" =~ [A-Z] ]]; then
        echo "  ⚠️  Mixed case: $dir_name (should be kebab-case)"
        warnings=$((warnings + 1))
    fi

    if [[ "$dir_name" =~ _ ]]; then
        echo "  ⚠️  Underscore: $dir_name (should use hyphens)"
        warnings=$((warnings + 1))
    fi
done < <(find "$SKILLS_DIR" -mindepth 2 -maxdepth 2 -type d)

[ $warnings -eq 0 ] && echo "  ✅ Directory names OK" || echo "  ⚠️  $warnings naming issues"

echo ""
while IFS= read -r empty_dir; do
    echo "  ⚠️  EMPTY: ${empty_dir#"$SKILLS_DIR"/}"
    warnings=$((warnings + 1))
done < <(find "$SKILLS_DIR" -type d -empty)

echo ""
while IFS= read -r skill_file; do
    # Quote the command substitution: an unquoted $(dirname "$f") word-splits
    # on spaces, so a path like ".../Pronto all'uso/..." reported as "Pronto".
    skill_name="$(basename "$(dirname "$skill_file")")"

    if ! grep -q "^name:" "$skill_file"; then
        echo "  ❌ MISSING 'name': $skill_name/SKILL.md"
        errors=$((errors + 1))
    fi

    if ! grep -q "^description:" "$skill_file"; then
        echo "  ❌ MISSING 'description': $skill_name/SKILL.md"
        errors=$((errors + 1))
    fi

    if ! grep -q "^when_to_use:" "$skill_file"; then
        echo "  ❌ MISSING 'when_to_use': $skill_name/SKILL.md"
        errors=$((errors + 1))
    fi

    if ! grep -q "^version:" "$skill_file"; then
        echo "  ⚠️  MISSING 'version': $skill_name/SKILL.md"
        warnings=$((warnings + 1))
    fi

    name_value=$(grep "^name:" "$skill_file" | head -1 | cut -d: -f2- | xargs)
    if [[ "$name_value" =~ ^How\ to ]]; then
        echo "  ⚠️  Passive name: $skill_name has 'How to' prefix (prefer active voice)"
        warnings=$((warnings + 1))
    fi
done < <(find "$SKILLS_DIR" -type f -name "SKILL.md")

echo ""
echo "  Frontmatter: $errors error(s), $warnings warning(s)"

[ $errors -eq 0 ]
