-- ==========================================
-- FiveM Lua Snippets & Helper Functions
-- Author: dexcription
-- ==========================================

Helpers = {}

-- 1. Optimized Distance Check (Resmon friendly)
-- Returns true if player is within range of target coordinates
function Helpers.IsPlayerInRange(targetCoords, maxDistance)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    return #(playerCoords - targetCoords) <= maxDistance
end

-- 2. Currency Formatter (e.g., 1500000 -> $1,500,000)
function Helpers.FormatMoney(amount)
    local formatted = tostring(amount)
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then break end
    end
    return "$" .. formatted
end

-- 3. Server-Side Discord Webhook Logger
if IsDuplicityVersion() then
    function Helpers.SendDiscordLog(webhookUrl, title, message, color)
        local embed = {{
            ["title"] = title,
            ["description"] = message,
            ["color"] = color or 3447003, -- Default blue
            ["footer"] = {
                ["text"] = os.date("%Y-%m-%d %H:%M:%S") .. " | Server Logs"
            }
        }}
        PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({username = "Server Logger", embeds = embed}), { ['Content-Type'] = 'application/json' })
    end
end
