DEBUG_RAY = false

PLAYER_NAME_HEAP = {}

SCALEFORM_ID_MIN = 1
SCALEFORM_ID_MAX = 12

SPRAY_FORWARD_OFFSET = 0.035

FORBIDDEN_MATERIALS = {
    [1913209870] = true,
    [-1595148316] = true,
    [510490462] = true,
    [909950165] = true,
    [-1907520769] = true,
    [-1136057692] = true,
    [509508168] = true,
    [1288448767] = true,
    [-786060715] = true,
    [-1931024423] = true,
    [-1937569590] = true,
    [-878560889] = true,
    [1619704960] = true,
    [1550304810] = true,
    [951832588] = true,
    [2128369009] = true,
    [-356706482] = true,
    [1925605558] = true,
    [-1885547121] = true,
    [-1942898710] = true,
    [312396330] = true,
    [1635937914] = true,
    [-273490167] = true,
    [1109728704] = true,
    [223086562] = true,
    [1584636462] = true,
    [-461750719] = true,
    [1333033863] = true,
    [-1286696947] = true,
    [-1833527165] = true,
    [581794674] = true,
    [-913351839] = true,
    [-2041329971] = true,
    [-309121453] = true,
    [-1915425863] = true,
    [1429989756] = true,
    [673696729] = true,
    [244521486] = true,
    [435688960] = true,
    [-634481305] = true,
    [-1634184340] = true,
}

SPRAYS = {}

RegisterNetEvent('rcore_spray:setSprays')
AddEventHandler('rcore_spray:setSprays', function(s)
    SPRAYS = s

    SetSprayTimeCorrectColor()
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('rcore_spray:playerSpawned')
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local scaleformHandleIdx = SCALEFORM_ID_MIN
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        for _, spray in pairs(SPRAYS) do
            if spray.color and #(coords - spray.location) < 100.0 then
                DrawSpray(PLAYER_NAME_HEAP[scaleformHandleIdx], spray)

                scaleformHandleIdx = scaleformHandleIdx + 1

                if scaleformHandleIdx >= SCALEFORM_ID_MAX then
                    break
                end
            end
        end

        if IsSpraying then
            local rayEndCoords, rayNormal, fwdVector = FindRaycastedSprayCoords()
            if rayEndCoords and rayNormal then
                local cIndex = 'color'
                local sprayCoords = rayEndCoords + fwdVector * SPRAY_FORWARD_OFFSET

                local isInterior = GetInteriorFromEntity(PlayerPedId()) > 0

                if not isInterior then
                    cIndex = GetTimeColorName()
                end

                DrawSpray(PLAYER_NAME_HEAP[SCALEFORM_ID_MAX], {
                    location = sprayCoords,
                    rotation = rayNormal, 
                    
                    scale = (SprayScaleSelect[SprayScale] / 10.0) * FONTS[SprayFont].sizeMult,
                    text = FormattedSprayText,
                    font = FONTS[SprayFont].font,
                    color = COLORS[SprayColor][cIndex].hex,
                })
            end
        end
    end
end)

local rotCam = nil
local wantedSprayLocation = nil
local wantedSprayRotation = nil
local currentSprayRotation = nil
currentComputedRotation = vector3(0,0,0)

Citizen.CreateThread(function()
    rotCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
    local ttl = 30

    while true do
        Wait(0)

        if wantedSprayLocation and wantedSprayRotation and IsSpraying then
            if ttl >= 0 then
                ttl = ttl - 1
            end

            if currentSprayRotation ~= wantedSprayRotation or not currentSprayRotation or ttl < 0 then
                ttl = 30
                local wantedSprayRotationFixed = vector3(
                    wantedSprayRotation.x, 
                    wantedSprayRotation.y, 
                    wantedSprayRotation.z + 0.03
                )

                local camRot = GetRotationThruCamera(wantedSprayLocation, wantedSprayRotationFixed)

                currentSprayRotation = wantedSprayRotation
                currentComputedRotation = camRot
            end
        end
    end
end)

function GetRotationThruCamera(location, normal)
    local camLookPosition = location - normal * 10

    SetCamCoord(rotCam,  location.x, location.y, location.z)

    PointCamAtCoord(rotCam, camLookPosition.x, camLookPosition.y, camLookPosition.z)

    SetCamActive(rotCam, true)
    Citizen.Wait(0)
    local rot =  GetCamRot(rotCam, 2)
    SetCamActive(rotCam, false)

    return rot
end

function DrawSpray(scaleformHandle, sprayData, meth)
    if scaleformHandle and HasScaleformMovieLoaded(scaleformHandle) then
        if not IsPauseMenuActive() then
            PushScaleformMovieFunction(scaleformHandle, "SET_PLAYER_NAME")
            PushScaleformMovieFunctionParameterString("<FONT color='#" .. sprayData.color .. "' FACE='" .. sprayData.font .. "'>" .. sprayData.text)
            PopScaleformMovieFunctionVoid()

            if not sprayData.realRotation then
                wantedSprayLocation = sprayData.location
                wantedSprayRotation = sprayData.rotation
            end

            --local reallyGoodRot = rotateVec3(fwdvec, rotvec, math.rad(90.0)) * 0.2
            -- DrawScaleformMovie_3d(
            DrawScaleformMovie_3dNonAdditive(
                scaleformHandle,
                sprayData.location, -- X, Y and Z location
                sprayData.realRotation or currentComputedRotation, -- X, Y and Z rotation
                1.0, -- UNK Float p7
                1.0, -- UNK Float p8 -- Text sharpness?
                1.0, -- UNK Float p9
                sprayData.scale, sprayData.scale, -- X, Y scale
                1.0, -- Unknown Float p12
                2 -- Unknown Any p13
            )
        end
    end
end

Citizen.CreateThread(function() 
    while true do
        LoadAllSprayScaleforms()
		Wait(5000)
	end 
end)

function LoadAllSprayScaleforms()
    for i = SCALEFORM_ID_MIN, SCALEFORM_ID_MAX do
        Wait(0)
        local paddedI = i

        if paddedI < 10 then
            paddedI = "0" .. paddedI
        end

        if not PLAYER_NAME_HEAP[i] or not HasScaleformMovieLoaded(PLAYER_NAME_HEAP[i]) then
            PLAYER_NAME_HEAP[i] = RequestScaleformMovieInteractive("PLAYER_NAME_" .. paddedI)
            while not HasScaleformMovieLoaded(PLAYER_NAME_HEAP[i]) do Citizen.Wait(0) end
        end
    end
end

function rgbToHex(rgb)
	local hexadecimal = ''

	for key, value in pairs(rgb) do
		local hex = ''

		while(value > 0)do
			local index = math.fmod(value, 16) + 1
			value = math.floor(value / 16)
			hex = string.sub('0123456789ABCDEF', index, index) .. hex			
		end

		if(string.len(hex) == 0)then
			hex = '00'

		elseif(string.len(hex) == 1)then
			hex = '0' .. hex
		end

		hexadecimal = hexadecimal .. hex
	end

	return hexadecimal
end

