local config = {}
local file = fileOpen("config.json")
if file then
    local jsonText = fileRead(file, fileGetSize(file))
    fileClose(file)
    config = fromJSON(jsonText)
else
    outputDebugString("⚠️ config.json غير موجود أو فيه مشكلة.")
    return
end

local botToken = config.token
local guildID = config.guild_id
local roles = config.roles
local prefix = config.prefix or "!"

------------------------------------------
-- وظيفة إرسال طلب API لـ Discord
------------------------------------------
function sendDiscordRequest(endpoint, method, data, callback)
    local url = "https://discord.com/api/v10/" .. endpoint

    fetchRemote(url,
        {
            method = method,
            headers = {
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bot " .. botToken
            },
            postData = data and toJSON(data) or nil
        },
        function (response, info)
            if info.success then
                if callback then callback(response) end
            else
                outputDebugString("❌ فشل الاتصال بـ Discord API")
                outputDebugString("Error: " .. tostring(response))
            end
        end
    )
end

------------------------------------------
-- مثال أمر بسيط: !ping
------------------------------------------
addCommandHandler("ping",
    function(player)
        outputChatBox("* Pong! البوت شغال تمام ❤️", player, 150, 250, 150)
    end
)

------------------------------------------
-- مثال: إضافة رول للاعب في الديسكورد
------------------------------------------
function addRole(discordUser, roleID)
    local endpoint = ("guilds/%s/members/%s"):format(guildID, discordUser)
    local data = { roles = { roleID } }

    sendDiscordRequest(endpoint, "PATCH", data,
        function(response)
            outputDebugString("✔️ تم إعطاء رول للاعب بنجاح")
        end
    )
end
