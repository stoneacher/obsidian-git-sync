#!/bin/bash

VAULT_PATH=/Users/stoneacher/Obidian_Vaults
LOGFILE="/Users/stoneacher/obsidian-sync.log"

cd "$VAULT_PATH" || exit 1

echo "====== PUSH $(date '+%Y-%m-%d %H:%M:%S') ======" >> "$LOGFILE"

# Add all changes
git add .

# Check for staged changes
if git diff --cached --quiet; then
    echo "No changes to commit." >> "$LOGFILE"
    echo "No changes to commit."
else
    # Capture staged diff before commit
    CHANGES=$(git diff --cached --name-status)

    git commit -m "Auto-sync: $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOGFILE" 2>&1

    # Log and print changes
    echo "$CHANGES" >> "$LOGFILE"
    echo "$CHANGES"
fi

# Push to remote
git push origin master >> "$LOGFILE" 2>&1

# Add newline
echo "" >> "$LOGFILE"

exit 0

