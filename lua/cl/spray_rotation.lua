Rotation = 0.0
RotationStep = 12.0

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if IsDisabledControlPressed(0, 15) then
            Rotation = Rotation + RotationStep
        elseif IsDisabledControlPressed(0, 14) then
            Rotation = Rotation - RotationStep
        end
    end
end)