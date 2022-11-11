Hour = 12

function GetTimeColorName()
    if Hour <= 5 or Hour >= 21 then
        return 'colorDarkest'
    end

    if Hour <= 7 or Hour >= 19 then
        return 'colorDarker'
    end

    return 'color'
end

function SetSprayTimeCorrectColor()
    for _, spray in pairs(SPRAYS) do
        Wait(0)

        local cIndex = 'color'

        if not spray.interior then
            cIndex = GetTimeColorName()
        end

        spray.color = COLORS[spray.originalColor][cIndex].hex
    end
end

Citizen.CreateThread(function()
    while true do
        Hour = GetClockHours()
        SetSprayTimeCorrectColor()
        Wait(10000)
    end
end)