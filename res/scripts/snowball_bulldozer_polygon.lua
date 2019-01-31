local polygon = {}

function polygon.getBounds(points)
    local xmin, xmax, ymin, ymax

    for i = 1, #points do
        local point = points[i]

        if (not xmin or point[1] < xmin) then
            xmin = point[1]
        end

        if (not xmax or point[1] > xmax) then
            xmax = point[1]
        end

        if (not ymin or point[2] < ymin) then
            ymin = point[2]
        end

        if (not ymax or point[2] > ymax) then
            ymax = point[2]
        end
    end

    return {
        x = xmin,
        y = ymin,
        width = xmax - xmin,
        height = ymax - ymin
    }
end

local function isLeft(p0, p1, p2)
    return ((p1[1] - p0[1]) * (p2[2] - p0[2]) - (p2[1] - p0[1]) * (p1[2] - p0[2]))
end

local function windings(p, v)
    
    local wn = 0

    for i = 1, #v - 1 do
        if v[i][2] <= p[2] then
            if (v[i + 1][2] > p[2]) then
                if isLeft(v[i], v[i + 1], p) > 0 then
                    wn = wn + 1
                end
            end
        else
            if (v[i + 1][2] <= p[2]) then
                if (isLeft(v[i], v[i + 1], p) < 0) then
                    wn = wn - 1
                end
            end
        end
    end
    return wn
end

function polygon.isClockwise(points)

    local sum = 0
    for i = 1, #points do
        local a = points[(i - 1) % #points + 1]
        local b = points[i % #points + 1]

        sum = sum + (b[1] - a[1]) * (b[2] + a[2])
    end

    return sum > 0

end

function  polygon.reverse( points )
    local result = {}
    for i = 0, #points - 1 do
        result[#result + 1] = points[#points - 1]
    end
    return result
end

function polygon.contains(points, point, bounds)   
    
    if (point[1] < bounds.x or point[1] > bounds.x + bounds.width or point[2] < bounds.y or point[2] > bounds.y + bounds.height) then
        return false
    end

    local poly = {table.unpack(points)}
    poly[#poly + 1] = poly[1]

    local horizontal = {{bounds.x, point[2]}, {point[1], point[2]}}
	local windingNumber = windings(point, poly)
    
    return windingNumber % 2 == 1
end

function polygon.getCircle(center, radius)
    local segments = math.max(4, math.floor(radius / 2))
    local da = math.pi * 2 / segments
    local result = {}

    for i = 1, segments do
        result[#result + 1] = {math.cos(da * (i - 1)) * radius + center[1], math.sin(da * (i - 1)) * radius + center[2]}
    end

    return result

end

return polygon
