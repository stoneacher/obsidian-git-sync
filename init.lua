hs.notify.new({
    title = "Hammerspoon Reloaded ✅",
    informativeText = "Obsidian sync automation is now active!"
}):send()

local syncLogPath = "/Users/stoneacher/obsidian-sync.log"

-- Tracking last sync time to prevent double execution
local lastSyncTime = 0
local debounceInterval = 5 -- sec

-- Create notification helper
local function createNotification(title, message, details)
    local body = message
    if details and #details > 0 then
        -- Trim details if too long
        if #details > 200 then
            details = details:sub(1, 200) .. "\n[...]"
        end
        body = body .. "\n\n" .. details
    end

    hs.notify.new({
        title = title,
        informativeText = body,
        soundName = nil -- optional sound
        
    }):send()
end

-- Pull function
local function pullObsidianVault()
    createNotification("Obsidian Pull", "Pulling latest changes...")

    -- Pull Script - add path to your script
    local output, status = hs.execute("/bin/bash /Users/stoneacher/obsidian-pull.sh")

    local title = status and "Obsidian Pull ✅" or "Obsidian Pull ❌"
    local message = status and "Vault pull completed successfully!" or "Vault pull failed! Check log."

    createNotification(title, message, output)
end

-- Push (Sync) function
local function syncObsidianVault()
    createNotification("Obsidian Sync", "Starting vault sync...")

    -- Pull Script - add path to your script
    local output, status = hs.execute("/bin/bash /Users/stoneacher/obsidian-push.sh")

    local title = status and "Obsidian Sync ✅" or "Obsidian Sync ❌"
    local message = status and "Vault sync completed successfully!" or "Vault sync failed! Check log."

    createNotification(title, message, output)
end

-- Event names for debugging
local eventNames = {
    [hs.application.watcher.launched] = "launched",
    [hs.application.watcher.terminated] = "terminated",
    [hs.application.watcher.activated] = "activated",
    [hs.application.watcher.deactivated] = "deactivated",
    [hs.application.watcher.hidden] = "hidden",
    [hs.application.watcher.unhidden] = "unhidden",
}

-- Application watcher for Obsidian
local obsidianWatcher = hs.application.watcher.new(function(appName, eventType, appObject)
    if appName == "Obsidian" then
        print("Obsidian event detected: " .. (eventNames[eventType] or tostring(eventType)))

        local currentTime = os.time()

        -- Only debounce meaningful events
        if eventType == hs.application.watcher.launched then
            if currentTime - lastSyncTime < debounceInterval then
                print("Debounced Obsidian launch event")
                return
            end
            lastSyncTime = currentTime

            hs.timer.doAfter(0.5, function() pullObsidianVault() end)

        elseif eventType == hs.application.watcher.terminated then
            if currentTime - lastSyncTime < debounceInterval then
                print("Debounced Obsidian terminated event")
                return
            end
            lastSyncTime = currentTime

            hs.timer.doAfter(0.5, function() syncObsidianVault() end)
        end
    end
end)

-- Start watcher
obsidianWatcher:start()
