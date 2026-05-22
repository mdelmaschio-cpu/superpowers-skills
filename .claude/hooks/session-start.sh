#!/bin/bash
set -euo pipefail

# Set SUPERPOWERS_SKILLS_ROOT so skills can be referenced with ${SUPERPOWERS_SKILLS_ROOT}/skills/...
echo "export SUPERPOWERS_SKILLS_ROOT=\"${CLAUDE_PROJECT_DIR}\"" >> "$CLAUDE_ENV_FILE"
