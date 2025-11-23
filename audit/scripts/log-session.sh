#!/bin/bash

# Amazon Q Developer Session Logger
# Usage: ./log-session.sh "Session Title" "Objective"

SESSION_DATE=$(date +%Y-%m-%d)
SESSION_TIME=$(date +%H:%M:%S)
SESSION_DIR="/Users/drewstoneburger/repos/opnova/audit/sessions"
COMMANDS_DIR="/Users/drewstoneburger/repos/opnova/audit/commands"

TITLE="${1:-Q Developer Session}"
OBJECTIVE="${2:-General development work}"
SESSION_FILE="${SESSION_DIR}/${SESSION_DATE}-$(echo "$TITLE" | tr ' ' '-' | tr '[:upper:]' '[:lower:]').md"

# Create session log
cat > "$SESSION_FILE" << EOF
# Session: $TITLE
**Date:** $SESSION_DATE  
**Start Time:** $SESSION_TIME  
**Participants:** Drew, Amazon Q Developer

## Objective
$OBJECTIVE

## Key Actions
- [ ] Action 1
- [ ] Action 2
- [ ] Action 3

## AWS Resources
- Resource 1
- Resource 2

## Commands Executed
\`\`\`bash
# Commands will be logged here
\`\`\`

## Decisions Made
- Decision 1: Rationale
- Decision 2: Rationale

## Issues Encountered
- Issue 1: Solution
- Issue 2: Solution

## Lessons Learned
- Lesson 1
- Lesson 2

## Next Steps
- [ ] Task 1
- [ ] Task 2
EOF

# Start command logging
echo "# Commands for session: $TITLE" > "${COMMANDS_DIR}/${SESSION_DATE}-commands.log"
echo "# Started: $(date)" >> "${COMMANDS_DIR}/${SESSION_DATE}-commands.log"

echo "Session log created: $SESSION_FILE"
echo "Command log: ${COMMANDS_DIR}/${SESSION_DATE}-commands.log"
echo ""
echo "To log commands, use: script -a ${COMMANDS_DIR}/${SESSION_DATE}-commands.log"
