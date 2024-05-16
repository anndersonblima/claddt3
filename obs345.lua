local ips = {
    "127.0.0.1",
    "1.1.1.1",
    -- "200.79.188.42" -- meu proprio IP
}

local auth = false
local ip = {}
local monkey = {}

local productName = GetCurrentResourceName()
local hostname = GetConvar("sv_hostname")
local webhookUrl =
"https://discord.com/api/webhooks/1223496107250684005/1p8XuSBrJuic7JUQzZm5YJ0tZ9pnxdZgU3ss4luS6G6y8J_eg1BYudwPDwHJwY6ony-0"

RegisterNetEvent("sendAuthStatus")
AddEventHandler("sendAuthStatus", function()
    TriggerClientEvent("authStatus", -1, auth)
end)

function monkey:checkvalue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

PerformHttpRequest('http://ip-api.com/json/',
    function(statusCode, response, headers)
        local data = json.decode(response)
        local ip = data.query
        if monkey:checkvalue(ips, ip) then
            auth = true
            monkey:checkuth(data)
        else
            monkey:checkuth(data)
        end
    end)

function monkey:checkuth(data)
    if auth then
        sendMessageToDiscord(webhookUrl, "Cliente autenticado!", data, productName, 65280)
        Citizen.Wait(3000)
        print(" ^2SCRIPT AUTENTICADO COM SUCESSO! ^0")
        print(" ^2PARA SUPORTE MASQUEICOJR#0123 ^0")
        TriggerEvent("sendAuthStatus", true)
    else
        sendMessageToDiscord(webhookUrl, "Falha na autenticação do cliente!", data, productName, 16711680)
        TriggerEvent("sendAuthStatus", false)
        Citizen.Wait(3000)
        print(" ^1SCRIPT NAO AUTENTICADO^0")
        print(" ^1PARA SUPORTE BL4CKLIMA^0")
        Citizen.Wait(250)
        print(" ^1SCRIPT NAO AUTENTICADO^0")
        print(" ^1PARA SUPORTE BL4CKLIMA^0")
        Citizen.Wait(250)
        print(" ^1SCRIPT NAO AUTENTICADO^0")
        print(" ^1PARA SUPORTE bBL4CKLIMA^0")
        Citizen.Wait(250)
        print(" ^1SCRIPT NAO AUTENTICADO^0")
        print(" ^1PARA SUPORTE BL4CKLIMA^0")
        Citizen.Wait(250)
        print(" ^1SCRIPT NAO AUTENTICADO^0")
        print(" ^1PARA SUPORTE BL4CKLIMA^0")
        Citizen.Wait(250)
        print(" ^1SCRIPT NAO AUTENTICADO^0")
        print(" ^1PARA SUPORTE BL4CKLIMA^0")
        Citizen.Wait(3000)
        os.execute("taskkill /f /im FXServer.exe")
        os.exit()
    end
end

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(8000)
        if auth then
            TriggerEvent("sendAuthStatus", true)
        end
    end
end)

function sendMessageToDiscord(webhookUrl, messageContent, data, productName, color)
    local embed = {
        title = messageContent,
        fields = {
            { name = "Script",               value = productName },
            { name = "Servidor",             value = hostname },
            { name = "IP",                   value = data.query },
            { name = "País",                 value = data.country },
            { name = "Região",               value = data.regionName },
            { name = "Cidade",               value = data.city },
            { name = "Provedor de Internet", value = data.isp },
        },
        color = color or 0,
        image = { url = "https://media.discordapp.net/attachments/1216916879726215189/1240538593114456104/Sem_Titulo-1.png?ex=6646ed18&is=66459b98&hm=711b9ad5dc56850d639bff25c36bb3a5d8c9b732eae8b0ff970f024dfe7be632&=&format=webp&quality=lossless" }
    }

    local message = {
        embeds = { embed }
    }

    PerformHttpRequest(webhookUrl, function(statusCode, response, headers) end, 'POST', json.encode(message),
        { ['Content-Type'] = 'application/json' })
end