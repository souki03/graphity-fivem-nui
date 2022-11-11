local DBL_EPSILON = 2.2204460492503131E-16

function DrawPositionMatrix(start, normal)
    local stdStart = start - GetEntityForwardVector(PlayerPedId())
    DrawLine(
        stdStart.x, stdStart.y, stdStart.z,
        stdStart.x + 1.0, stdStart.y, stdStart.z,
        255, 0, 0, 255
    )
    
    DrawLine(
        stdStart.x, stdStart.y, stdStart.z,
        stdStart.x, stdStart.y + 1.0, stdStart.z,
        0, 0, 255, 255
    )
    
    DrawLine(
        stdStart.x, stdStart.y, stdStart.z,
        stdStart.x, stdStart.y, stdStart.z+1.0,
        0, 255, 0, 255
    )

    local newZ = normalize(vCross(normal, vector3(0, 0, 1)))
    local newX = normalize(vCross(normal, newZ))

    DrawLine(
        start.x, start.y, start.z,
        start.x + normal.x, start.y + normal.y, start.z + normal.z,
        255, 0, 0, 255
    )

    DrawLine(
        start.x, start.y, start.z,
        start.x + newZ.x, start.y + newZ.y, start.z + newZ.z,
        0, 255, 0, 255
    )

    DrawLine(
        start.x, start.y, start.z,
        start.x + newX.x, start.y + newX.y, start.z + newX.z,
        0, 0, 255, 255
    )

end

function vCross(v,u)
    local a, b, c = v.x, v.y, v.z
    local xOut = b * u.z - c * u.y
    local yOut = c * u.x - a * u.z
    local zOut = a * u.y - b * u.x
    return vector3(xOut, yOut, zOut)
end

function normalize(v)
    local len = #v
    return len == 0 and v or scale(v, 1/len)
end

function scale(v, s)
    return vector3(
        v.x * s,
        v.y * s,
        v.z * s
    )
end