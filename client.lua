local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand(Config.OpenCommand, function()
    TriggerServerEvent('DrkCore:CheckWhitelist')
end)

RegisterNetEvent('DrkCore:OpenMenu')
AddEventHandler('DrkCore:OpenMenu', function()

    local input = lib.inputDialog('Drks Item Creator', {
        {type = 'input', label = 'Name', description = 'The name of the Item you are creating / Removing', required = true, min = 0, max = 100},
        {type = 'input', label = 'Tag', description = 'The label that appears on the Item.', required = true, min = 0, max = 100},
        {type = 'number', label = 'Weight', description = 'The amount of Weight for the item.', icon = 'hashtag', required = true},
        {type = 'input', label = 'Image', description = 'Enter the image filename (without extension) for the item.', required = true, min = 0, max = 100},
        {type = 'input', label = 'Description', description = 'Enter a description for the item.', required = true, min = 0, max = 200},
        {type = 'checkbox', label = 'Usable', description = 'Check if the item is usable.', default = false}
    })
    
    

    if not input then return end
    TriggerServerEvent("DrkCore:CreateItem", input[1], input[2], input[3], input[4], input[5], input[6])
end)

RegisterNetEvent('DrkCore:Notify')
AddEventHandler('DrkCore:Notify', function(type, message)
    lib.notify({
        type = type,
        description = message,
    })
end)
