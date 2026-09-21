#!/bin/bash
# Check that all skills are properly listed in INDEX files

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_SKILLS_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
SKILLS_DIR="${1:-$DEFAULT_SKILLS_DIR}"

if [ ! -d "$SKILLS_DIR" ]; then
    echo "ERROR: skills directory not found: $SKILLS_DIR" >&2
    exit 2
fi

echo "## INDEX Coverage"

index_total=$(find "$SKILLS_DIR" -type f -name "INDEX.md" | wc -l)
if [ "$index_total" -eq 0 ]; then
    # Say so explicitly. Printing nothing looked identical to "all checks
    # passed" and hid the fact that this check had nothing to work with.
    echo "  ℹ️  No INDEX.md files in $SKILLS_DIR — nothing to check"
    echo "     (this repo documents categories in CLAUDE.md instead)"
    exit 0
fi

for category_dir in "$SKILLS_DIR"/*/; do
    [[ ! -d "$category_dir" ]] && continue
    category=$(basename "$category_dir")

    index_file="$category_dir/INDEX.md"
    [[ ! -f "$index_file" ]] && continue

    skill_count=0
    missing_count=0

    while IFS= read -r skill_file; do
        skill_count=$((skill_count + 1))
        # Quote the command substitution — see check-naming.sh for why.
        skill_name="$(basename "$(dirname "$skill_file")")"

        if ! grep -q "@$skill_name/SKILL.md" "$index_file"; then
            echo "  ❌ NOT INDEXED: $skill_name/SKILL.md"
            missing_count=$((missing_count + 1))
        fi
    done < <(find "$category_dir" -mindepth 2 -type f -name "SKILL.md")

    if [ $skill_count -gt 0 ] && [ $missing_count -eq 0 ]; then
        echo "  ✅ $category: all $skill_count skills indexed"
    elif [ $missing_count -gt 0 ]; then
        echo "  ⚠️  $category: $missing_count/$skill_count skills missing"
    fi
done

echo ""
# Verify INDEX entries have descriptions
while IFS= read -r index_file; do
    category="$(basename "$(dirname "$index_file")")"

    grep -oE '@[a-zA-Z0-9-]+/SKILL\.md' "$index_file" | while read -r ref; do
        skill_name=${ref#@}
        skill_name=${skill_name%/SKILL.md}

        line_num=$(grep -n "$ref" "$index_file" | head -1 | cut -d: -f1)
        [ -z "$line_num" ] && continue

        description=$(sed -n "${line_num}p" "$index_file" | sed "s|.*$ref *- *||")

        if [[ -z "$description" || "$description" == *"$ref"* ]]; then
            next_line=$((line_num + 1))
            description=$(sed -n "${next_line}p" "$index_file")

            if [[ -z "$description" ]]; then
                echo "  ⚠️  NO DESCRIPTION: $category/INDEX.md reference to $skill_name"
            fi
        fi
    done
done < <(find "$SKILLS_DIR" -type f -name "INDEX.md")
