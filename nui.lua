ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local display = false
RegisterCommand("+openmenuspray", function(source, args)
    ESX.TriggerServerCallback('souki:spraycheck', function(aha)
        if aha then
            SetDisplay(not display)
        else
            ESX.ShowNotification("~r~Vous n'avez pas de spray sur vous.") 
        end
    end)
end)
RegisterNetEvent('souki:hehavespray')
AddEventHandler('souki:hehavespray', function(source)
    ExecuteCommand("+openmenuspray")
end)
RegisterNUICallback("exit", function(data)
    print("exited", {0,255,0})
    SetDisplay(false)
end)
RegisterNUICallback("main", function(data)
    local texte = data.text
    local police = data.police
    local taille = data.taille

    --
    print("text : "..data.text)
    print("police : "..data.police)
    print("taille : "..data.taille)
    print("color : "..data.color)
    --
    SetDisplay(false)
    --
    if data.police == "1" then
        policef = 1
    elseif data.police == "2" then
        policef = 2
    elseif data.police == "3" then
        policef = 3
    elseif data.police == "4" then
        policef = 4
    elseif data.police == "5" then
        policef = 5
    elseif data.police == "6" then
        policef = 6
    end
    --
    if data.taille == "1" then
        taillef = 1
    elseif data.taille == "2" then
        taillef = 2
    elseif data.taille == "3" then
        taillef = 3
    elseif data.taille == "4" then
        taillef = 4
    elseif data.taille == "5" then
        taillef = 5
    elseif data.taille == "6" then
        taillef = 6
    elseif data.taille == "7" then
        taillef = 7
    elseif data.taille == "8" then
        taillef = 8
    elseif data.taille == "9" then
        taillef = 9
    elseif data.taille == "10" then
        taillef = 10
    elseif data.taille == "11" then
        taillef = 11
    elseif data.taille == "12" then
        taillef = 12
    elseif data.taille == "13" then
        taillef = 13
    elseif data.taille == "14" then
        taillef = 14
    elseif data.taille == "15" then
        taillef = 15
    elseif data.taille == "16" then
        taillef = 16
    elseif data.taille == "17" then
        taillef = 17
    elseif data.taille == "18" then
        taillef = 18
    elseif data.taille == "19" then
        taillef = 19
    elseif data.taille == "20" then
        taillef = 20
    elseif data.taille == "21" then
        taillef = 21
    elseif data.taille == "22" then
        taillef = 22
    elseif data.taille == "23" then
        taillef = 23
    elseif data.taille == "24" then
        taillef = 24
    elseif data.taille == "25" then
        taillef = 25
    elseif data.taille == "26" then
        taillef = 26
    elseif data.taille == "27" then
        taillef = 27
    elseif data.taille == "28" then
        taillef = 28
    elseif data.taille == "29" then
        taillef = 29
    end
    --
    if data.color == "#000000" then
        colorf = 21
    elseif data.color == "#404040" then
        colorf = 20
    elseif data.color == "#808080" then
        colorf = 22
    elseif data.color == "#C0C0C0" then
        colorf = 19
    elseif data.color == "#ffffff" then
        colorf = 1
    elseif data.color == "#980000" then
        colorf = 2
    elseif data.color == "#ff0000" then
        colorf = 3
    elseif data.color == "#ff9900" then
        colorf = 13
    elseif data.color == "#ffff00" then
        colorf = 9
    elseif data.color == "#00ff00" then
        colorf = 12
    elseif data.color == "#00ffff" then
        colorf = 8
    elseif data.color == "#4a86e8" then
        colorf = 7
    elseif data.color == "#0000ff" then
        colorf = 6
    elseif data.color == "#9900ff" then
        colorf = 17
    elseif data.color == "#ff00ff" then
        colorf = 5
    end
    --
    if taillef == nil then
        ESX.ShowNotification("~r~Vous n'avez pas tout remplis !")
    else
        TriggerEvent('rcore_spray:spray', texte, policef, taillef, colorf)
    end
end)
RegisterNUICallback("error", function(data)
    print(data.error, {255,0,0})
    SetDisplay(false)
end)
function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end
Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        -- https://runtime.fivem.net/doc/natives/#_0xFE99B66D079CF6BC
        --[[ 
            inputGroup -- integer , 
	        control --integer , 
            disable -- boolean 
        ]]
        SetPedStealthMovement(GetPlayerPed(-1),true,"")
        DisableControlAction(0,21,true) -- disable sprint
        DisableControlAction(0,24,true) -- disable attack
        DisableControlAction(0,25,true) -- disable aim
        DisableControlAction(0,47,true) -- disable weapon
        DisableControlAction(0,58,true) -- disable weapon
        DisableControlAction(0,263,true) -- disable melee
        DisableControlAction(0,264,true) -- disable melee
        DisableControlAction(0,257,true) -- disable melee
        DisableControlAction(0,140,true) -- disable melee
        DisableControlAction(0,141,true) -- disable melee
        DisableControlAction(0,142,true) -- disable melee
        DisableControlAction(0,143,true) -- disable melee
        DisableControlAction(0,75,true) -- disable exit vehicle
        DisableControlAction(27,75,true) -- disable exit vehicle
        DisableControlAction(0,32,true) -- move (w)
        DisableControlAction(0,34,true) -- move (a)
        DisableControlAction(0,33,true) -- move (s)
        DisableControlAction(0,35,true) -- move (d)
    end
end)


