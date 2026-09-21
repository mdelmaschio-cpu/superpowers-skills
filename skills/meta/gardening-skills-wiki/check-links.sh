#!/bin/bash
# Check for @ links (force-load context) and validate skill path references

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_SKILLS_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
SKILLS_DIR="${1:-$DEFAULT_SKILLS_DIR}"

if [ ! -d "$SKILLS_DIR" ]; then
    echo "ERROR: skills directory not found: $SKILLS_DIR" >&2
    exit 2
fi

echo "## Links & References"

backticked_refs=0
at_links=0

# A line that documents the anti-pattern is not a violation of it. Skills that
# teach "don't use @refs" necessarily quote one as a bad example, marked with ❌
# or "Bad:". Flagging those produced false positives that trained readers to
# ignore this check.
is_negative_example() {
    [[ "$1" == *"❌"* ]] || [[ "$1" =~ (^|[[:space:]])Bad: ]]
}

in_fenced_block() {
    local file="$1" line_num="$2" count
    count=$(sed -n "1,${line_num}p" "$file" | grep -c '^```')
    [ $((count % 2)) -eq 1 ]
}

while IFS= read -r file; do
    # Quote the command substitutions: an unquoted $(dirname "$file")
    # word-splits on spaces, so ".../Pronto all'uso/x/SKILL.md" was reported
    # as "Pronto/SKILL.md" — untraceable to the real file.
    rel_name="$(basename "$(dirname "$file")")/$(basename "$file")"

    # Backtick-wrapped @ links
    while IFS=: read -r line_num _; do
        actual_line=$(sed -n "${line_num}p" "$file")
        [[ "$actual_line" =~ ^[[:space:]]{4,} ]] && continue
        in_fenced_block "$file" "$line_num" && continue
        is_negative_example "$actual_line" && continue

        ref=$(printf '%s' "$actual_line" | grep -oE '@[a-zA-Z0-9._~/-]+\.(md|sh|ts|js|py)' | head -1)
        echo "  ❌ BACKTICKED: ${ref:-<unparsed>} on line $line_num"
        echo "     File: $rel_name"
        echo "     Fix: use skills/category/skill-name (no @, no backticked path)"
        backticked_refs=$((backticked_refs + 1))
    done < <(grep -nE '`[^`]*@[a-zA-Z0-9._~/-]+\.(md|sh|ts|js|py)[^`]*`' "$file")

    # Any @ link to a .md/.sh/.ts/.js/.py file (force-loads, burns context)
    while IFS=: read -r line_num _; do
        actual_line=$(sed -n "${line_num}p" "$file")
        [[ "$actual_line" =~ ^[[:space:]]{4,} ]] && continue
        in_fenced_block "$file" "$line_num" && continue
        is_negative_example "$actual_line" && continue

        # grep -o with ERE syntax (+, (a|b)) but no -E never matched, so every
        # finding printed an empty reference. -E makes the pattern work.
        ref=$(printf '%s' "$actual_line" | grep -oE '@[a-zA-Z0-9._/-]+\.(md|sh|ts|js|py)' | head -1)
        [ -z "$ref" ] && continue
        ref_path="${ref#@}"

        echo "  ❌ @ LINK: $ref on line $line_num"
        echo "     File: $rel_name"

        if [[ "$ref_path" == skills/* ]]; then
            corrected="${ref_path%/SKILL.md}"
            echo "     Fix: $ref → $corrected"
        else
            echo "     Fix: Convert to skills/category/skill-name format"
        fi

        at_links=$((at_links + 1))
    done < <(grep -nE '(^|[ (>-])@[a-zA-Z0-9._/-]+\.(md|sh|ts|js|py)' "$file" \
                | grep -v '@[a-zA-Z0-9._%+-]*@' \
                | grep -v 'email.*@' \
                | grep -v '`.*@.*`')
done < <(find "$SKILLS_DIR" -type f -name "*.md")

total_issues=$((backticked_refs + at_links))
if [ $total_issues -eq 0 ]; then
    echo "  ✅ All skill references OK"
else
    [ $backticked_refs -gt 0 ] && echo "  ❌ $backticked_refs backticked references"
    [ $at_links -gt 0 ] && echo "  ❌ $at_links @ links (force-load context)"
fi

echo ""
echo "Correct format: skills/category/skill-name"
echo "  Bad:  @skills/path/SKILL.md (force-loads) or @../path (brittle)"
echo "  Good: skills/category/skill-name (load with Read tool when needed)"

echo ""
# Verify all skills mentioned in INDEX files exist
while IFS= read -r index_file; do
    index_dir=$(dirname "$index_file")

    grep -oE '@[a-zA-Z0-9-]+/SKILL\.md' "$index_file" | while read -r skill_ref; do
        skill_path="$index_dir/${skill_ref#@}"

        if [[ ! -f "$skill_path" ]]; then
            echo "  ❌ BROKEN: $skill_ref in $(basename "$index_dir")/INDEX.md"
            echo "     Expected: $skill_path"
        fi
    done
done < <(find "$SKILLS_DIR" -type f -name "INDEX.md")

echo ""
while IFS= read -r skill_file; do
    skill_dir="$(basename "$(dirname "$skill_file")")"
    category_dir="$(dirname "$(dirname "$skill_file")")"
    index_file="$category_dir/INDEX.md"

    if [[ -f "$index_file" ]]; then
        if ! grep -q "@$skill_dir/SKILL.md" "$index_file"; then
            echo "  ⚠️  ORPHANED: $skill_dir/SKILL.md not in $(basename "$category_dir")/INDEX.md"
        fi
    fi
done < <(find "$SKILLS_DIR" -type f -path "*/*/SKILL.md")

[ $total_issues -eq 0 ]
