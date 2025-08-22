# Obsidian Git Sync Automation with Hammerspoon

This repository provides a simple, automated solution for keeping your [Obsidian](https://obsidian.md/) vault in sync with a remote Git repository using [Hammerspoon](https://www.hammerspoon.org/) on macOS. It leverages Hammerspoon's scripting capabilities to automatically pull and push changes to your Obsidian vault when the Obsidian app is launched or closed.

---

## Features

- **Automatic Git Pull on Launch:**
  - When you open Obsidian, the latest changes from your remote repository are pulled into your local vault.
- **Automatic Git Push on Quit:**
  - When you quit Obsidian, your local changes are committed and pushed to the remote repository.
- **macOS Notifications:**
  - Get real-time notifications about sync status and errors.
- **Debouncing:**
  - Prevents duplicate syncs from rapid app events.
- **Logging:**
  - All sync activity is logged to `obsidian-sync.log` for troubleshooting.

---

## How It Works

- **Hammerspoon** runs a Lua script (`init.lua`) that watches for Obsidian app events.
- On **launch**, it runs a shell script to `git pull` the latest changes.
- On **quit**, it runs a shell script to `git add`, `commit`, and `push` your changes.
- Notifications and logs keep you informed of sync status.

---

## Setup Instructions

### 1. Prerequisites
- macOS
- [Hammerspoon](https://www.hammerspoon.org/) installed
- [Obsidian](https://obsidian.md/) installed
- Your Obsidian vault is a Git repository (initialized and connected to a remote, e.g., GitHub)

### 2. Clone or Copy This Repo
Clone this repository or copy the files into your Hammerspoon config directory (usually `~/.hammerspoon`).

### 3. Configure Paths
- **Vault Path:**
  - Edit `obsidian-pull-example.sh` and `obsidian-push-example.sh` to set the correct path to your Obsidian vault (`VAULT_PATH`).
- **Log File:**
  - Optionally, adjust the `LOGFILE` path if desired.

### 4. Rename Example Scripts
Rename the example scripts to remove `-example`:
```sh
mv obsidian-pull-example.sh obsidian-pull.sh
mv obsidian-push-example.sh obsidian-push.sh
chmod +x obsidian-pull.sh obsidian-push.sh
```

### 5. Edit `init.lua` if Needed
- If you changed script names or paths, update the script paths in `init.lua` accordingly.

### 6. Reload Hammerspoon
- Open Hammerspoon and click "Reload Config" (or run `hs.reload()` in the Hammerspoon console).
- You should see a notification: **"Hammerspoon Reloaded ✅"**

---

## File Overview

- `init.lua` — Main Hammerspoon config. Watches for Obsidian app events and triggers sync scripts.
- `obsidian-pull-example.sh` — Bash script to pull latest changes from remote.
- `obsidian-push-example.sh` — Bash script to add, commit, and push changes to remote.
- `obsidian-sync.log` — Log file for all sync activity (created automatically).
- `Spoons/` — (Optional) Hammerspoon extensions folder.

---

## Customization
- **Change debounce interval** in `init.lua` to adjust how often syncs can occur.
- **Add more notifications** or logging as needed.
- **Integrate with other automation tools** if desired.

---

## Troubleshooting
- **No sync?**
  - Check `obsidian-sync.log` for errors.
  - Ensure your vault path and script permissions are correct.
  - Make sure your vault is a valid Git repository and you have network access.
- **Notifications not appearing?**
  - Ensure Hammerspoon has notification permissions in macOS System Preferences.

---

## Security & Privacy
- This setup runs local shell scripts and interacts with your Git repository. Review scripts before use.
- No data is sent anywhere except your configured Git remote.

---

## License
MIT License. See [LICENSE](LICENSE) for details.

---

## Credits
- Inspired by the Obsidian community and Hammerspoon automation examples.

---

## Contributions
Pull requests and suggestions are welcome!
