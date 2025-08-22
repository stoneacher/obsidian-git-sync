#!/bin/bash

VAULT_PATH=/Users/stoneacher/Obidian_Vaults
LOGFILE="/Users/stoneacher/obsidian-sync.log"

cd "$VAULT_PATH" || exit 1

echo "====== PULL $(date '+%Y-%m-%d %H:%M:%S') ======" >> "$LOGFILE"

# Capture pull output
PULL_OUTPUT=$(git pull origin master --rebase 2>&1)

# Log and print
echo "$PULL_OUTPUT" >> "$LOGFILE"
echo "$PULL_OUTPUT"

# Add newline
echo "" >> "$LOGFILE"

exit 0
