local polygon = require "snowball_bulldozer_polygon"
local plan = require "snowball_bulldozer_planner"
local bulldozer = {}

bulldozer.markerStore = nil
bulldozer.finisherStore = nil
bulldozer.lastMarker = nil
bulldozer.markerId = "asset/snowball_bulldozer_marker.mdl"
bulldozer.finisherId = "asset/snowball_bulldozer_finisher.mdl"
bulldozer.zoneId = nil



function bulldozer.getObjects(points, type)
       
   
    local bounds = polygon.getBounds(points)  
    local center = bulldozer.getCenter(bounds)
    local radius = bulldozer.getRadius(center, points) 
    local entities = game.interface.getEntities({pos = center, radius = radius}, {includeData = true})

    local result = {}

    if entities then
        for id, data in pairs(entities) do
            if data.type == "ASSET_GROUP" and (type == nil or type == "ASSET_GROUP") then
                local markercount = data.models["asset/snowball_bulldozer_marker.mdl"] or 0
                local finishercount = data.models["asset/snowball_bulldozer_finisher.mdl"] or 0

                if markercount == 0 and finishercount == 0 and polygon.contains(points, data.position, bounds) then
                    result[#result + 1] = data
                end
            elseif data.type == "CONSTRUCTION" and (type == nil or type == "CONSTRUCTION") then
                if polygon.contains(points, data.position, bounds) then
                    result[#result + 1] = data
                    result[#result].setPlayer = #data.simBuildings > 0
                end
            end
        end
    end

    return result
end

function bulldozer.updateMarkers()
    if not bulldozer.markerStore then
        bulldozer.markerStore = {}
    end
    if not bulldozer.finisherStore then
        bulldozer.finisherStore = {}
    end

    return plan.updateEntityLists(bulldozer.markerId, bulldozer.markerStore, bulldozer.finisherId, bulldozer.finisherStore)
end

function bulldozer.getPoints()
    if not bulldozer.markerStore then
        return nil
    end

    local result = {}

    for i = 1, #bulldozer.markerStore do
        local marker = bulldozer.markerStore[i]
        result[#result + 1] = {marker.position[1], marker.position[2], marker.position[3]}
    end

    if #result > 0 then
        return result
    else
        return nil
    end
end

function bulldozer.getCenter(bounds)
     return {bounds.x + 0.5 * bounds.width, bounds.y + 0.5 * bounds.height}
end

function bulldozer.getRadius(center, points)
    local dmax = nil

    for i = 1, #points do
        local dx = center[1] - points[i][1]
        local dy = center[2] - points[i][2]
        local d = dx * dx + dy * dy

        if not dmax or dmax < d then
            dmax = d
        end
    end

    print("dmax: "..dmax)

    return math.sqrt(dmax)
end

function bulldozer.plan(result, color)
    bulldozer.updateMarkers()

    for i = 1, #bulldozer.finisherStore do
        local finisher = bulldozer.finisherStore[i]
        game.interface.bulldoze(finisher.id)
    end

    bulldozer.finisherStore = {}

    for i = 1, #bulldozer.markerStore + 1 do
        result.models[#result.models + 1] = {
            id = bulldozer.markerId,
            transf = {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
        }
    end

    local poly = bulldozer.getPoints()

    if poly then
        if #poly == 1 then
            local dozezone = {
                polygon = {{poly[1][1] - 5, poly[1][2], poly[1][3]}, {poly[1][1] + 5, poly[1][2], poly[1][3]}},
                draw = true,
                drawColor = color
            }
            game.interface.setZone("bulldoze_zone", dozezone)
        else
            local dozezone = {polygon = poly, draw = true, drawColor = color}
            game.interface.setZone("bulldoze_zone", dozezone)
        end
    end
end

function bulldozer.reset(result)
    result.models[#result.models + 1] = {
        id = bulldozer.finisherId,
        transf = {0.01, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 1}
    }

    game.interface.setZone("bulldoze_zone", nil)

    if not bulldozer.markerStore then
        return
    end

    for i = 1, #bulldozer.markerStore do
        local marker = bulldozer.markerStore[i]
        game.interface.bulldoze(marker.id)
    end

    bulldozer.markerStore = {}
end

function bulldozer.bulldoze(result, type)
    result.models[#result.models + 1] = {
        id = bulldozer.finisherId,
        transf = {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
    }

    if not bulldozer.markerStore then
        return
    end

    local points = bulldozer.getPoints()
    game.interface.setZone("bulldoze_zone", nil)

    for i = 1, #bulldozer.markerStore do
        local marker = bulldozer.markerStore[i]
        game.interface.bulldoze(marker.id)
    end

    bulldozer.markerStore = {}

    if (not points) or (#points < 3) then
        return result
    end

    local objects = bulldozer.getObjects(points, type)
    local player = game.interface.getPlayer()

    for i = 1, #objects do
        if objects[i].setPlayer then
            game.interface.setPlayer(objects[i].id, player)
        end

        game.interface.bulldoze(objects[i].id)
    end
end

function bulldozer.level(result, level)
    result.models[#result.models + 1] = {
        id = bulldozer.finisherId,
        transf = {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
    }

    if not bulldozer.markerStore then
        return
    end

    local points = bulldozer.getPoints()
    game.interface.setZone("bulldoze_zone", nil)

    for i = 1, #bulldozer.markerStore do
        local marker = bulldozer.markerStore[i]
        game.interface.bulldoze(marker.id)
    end

    bulldozer.markerStore = {}

    if (not points) or (#points < 3) then
        return result
    end

    game.interface.buildConstruction(
        "asset/snowball_bulldozer_area.con",
        {points = points, level = level},
        {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
    )
end

return bulldozer
