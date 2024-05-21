local QBCore = exports['qb-core']:GetCoreObject()

function isWhitelisted(player)
    local whitelisted = false
    for i, id in ipairs(Config.Admins) do
        for x, pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                whitelisted = true
            end
        end
    end
    return whitelisted
end

RegisterNetEvent('DrkCore:CheckWhitelist')
AddEventHandler('DrkCore:CheckWhitelist', function()
    local source = source
    if isWhitelisted(source) then
        TriggerClientEvent('DrkCore:OpenMenu', source)
    else
        TriggerClientEvent('DrkCore:Notify', source, "error", "No Permissions.")
    end
end)

RegisterNetEvent('DrkCore:CreateItem')
AddEventHandler('DrkCore:CreateItem', function(itemname, itemlabel, itemweight, itemimage, itemdescription, usable)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if isWhitelisted(source) then
        local itemDefinition = string.format("%s = { name = '%s', label = '%s', weight = %d, type = 'item', image = '%s.png', unique = true, useable = %s, shouldClose = true, combinable = nil, description = '%s' },\n", itemname, itemname, itemlabel, itemweight, itemimage, tostring(usable), itemdescription)

        local filePath = 'resources/[qb]/qb-core/shared/items.lua'

        local function addItemToFile(filePath, itemDefinition)
            local file = io.open(filePath, "r")
            if file then
                local lines = {}
                for line in file:lines() do
                    table.insert(lines, line)
                end
                file:close()

                table.insert(lines, 31, itemDefinition) 

                file = io.open(filePath, "w")
                if file then
                    for _, line in ipairs(lines) do
                        file:write(line .. "\n")
                    end
                    file:close()
                    TriggerClientEvent('DrkCore:Notify', source, "success", Config.SucessMessage)
                else
                    TriggerClientEvent('DrkCore:Notify', source, "error", "Failed to open items.lua file.")
                end
            else
                TriggerClientEvent('DrkCore:Notify', source, "error", "Failed to open items.lua file.")
            end
        end

        addItemToFile(filePath, itemDefinition)
    else
        TriggerClientEvent('DrkCore:Notify', source, "error", Config.NoPermsMessage)
    end
end)
