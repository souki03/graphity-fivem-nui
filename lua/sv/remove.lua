ESX.RegisterUsableItem("spray_remover", function(playerId)
    TriggerClientEvent('rcore_spray:removeClosestSpray', playerId)
end)


RegisterNetEvent('rcore_spray:remove')
AddEventHandler('rcore_spray:remove', function(pos)
    local Source = source

    local xPlayer = ESX.GetPlayerFromId(Source)
    local item = xPlayer.getInventoryItem("spray_remover")
    
    if item.count > 0 then
        xPlayer.removeInventoryItem("spray_remover", 1)
        local sprayAtCoords = GetSprayAtCoords(pos)

        MySQL.Async.execute([[
            DELETE FROM sprays WHERE x=@x AND y=@y AND z=@z LIMIT 1
        ]], {
            ['@x'] = pos.x,
            ['@y'] = pos.y,
            ['@z'] = pos.z,
        })

        for idx, s in pairs(SPRAYS) do
            if s.location.x == pos.x and s.location.y == pos.y and s.location.z == pos.z then
                SPRAYS[idx] = nil
            end
        end
        TriggerClientEvent('rcore_spray:setSprays', -1, SPRAYS)

        local sprayAtCoordsAfterRemoval = GetSprayAtCoords(pos)

        -- ensure someone doesnt bug it so its trying to remove other tags
        -- while deducting loyalty from not-deleted-but-at-coords tag
        if sprayAtCoords and not sprayAtCoordsAfterRemoval then
            TriggerEvent('rcore_sprays:removeSpray', Source, sprayAtCoords.text, sprayAtCoords.location)
        end
    end
end)

ESX.RegisterServerCallback('souki:spraycheck', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem("spray").count >= 1 then
        cb(true)
    else
        cb(false)
    end
end)