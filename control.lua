-- TODO: block adding ghost equipment (check if the added equipment is a ghost and if true AND it's a minifactory piece of equipment, delete the ghost entity and return)
-- check if the equipment type is ghost, if true, return
-- TODO: return when adding non-minifactory equipment-- check if the equipment name starts with "minifactory" and if false, return
-- TODO: when taking off armor, if there is no new armor on, remove surface entities-- use checkPlayerGrid to check if the grid is valid, if false, remove surface entitites and return
-- TODO: hide equipment surfaces from remote view, use a button to view them instead
-- TODO: when taking off armor and there is no new armor on, set player's buff values to 0

-- item name to buff name and buff amount
BuffDict = {
    ["inserter"] = {"character_running_speed_modifier", 0.03},
    ["long-handed-inserter"] = {"character_running_speed_modifier", 0.04},
    ["assembling-machine-1"] = {"character_crafting_speed_modifier", 0.1},
    ["assembling-machine-2"] = {"character_crafting_speed_modifier", 0.2},
    ["transport-belt"] = {"character_inventory_slots_bonus", 1}
}

-- returns the surface name for the player's equipment surface, creating it if it doesn't exist
local function getOrMakePlayerSurfaceName(player_index)
    local surfaceName = "equipment_surface_" .. player_index
    if game.get_surface(surfaceName) == nil then
        game.create_surface(surfaceName, {
            width = 200,
            height = 200,
            no_enemies_mode = true,
            default_enable_all_autoplace_controls = false,
            autoplace_controls = {},
            autoplace_settings = {},
            seed = 1,
            starting_area = "none",
            starting_points = {},
            peaceful_mode = true,
            property_expression_names = {},
            cliff_settings = {name = "cliff", control = "cliff", cliff_elevation_interval = 0, cliff_elevation_0 = 0, cliff_smoothing = 1, richness = 1},
            territory_settings = {
                units = {},
                territory_index_expression = "",
                territory_variation_expression = "",
                minimum_territory_size = 0
            }
        })
        game.get_surface(surfaceName).always_day = true
    end
    local surface = game.surfaces[surfaceName]
    game.players[player_index].force.set_surface_hidden(surface, true)
    return surfaceName
end

local function printEquipmentGridContents(grid)
    for _, equipment in pairs(grid.equipment) do
        --game.print(equipment.name .. " at position " .. equipment.position.x .. ", " .. equipment.position.y)
    end
end

local function removeSurfaceEntitites(surface)
    for _, entity in pairs(surface.find_entities()) do
        entity.destroy()
    end
end

local function clearAndPrepareSurface(surface)
    -- clear surface
    removeSurfaceEntitites(surface)
    -- generate surface chunks
    surface.request_to_generate_chunks({0, 0}, 5)
end

local function deleteEntity(position, surface)
    --game.print("removing entities from surface " .. surface.name .. " at position " .. position.x .. ", " .. position.y)
    for _, entity in pairs(surface.find_entities_filtered{area = {{position.x, position.y}, {position.x + 1, position.y + 1}}}) do
        --game.print("destroying entity " .. entity.name)
        entity.destroy()
    end
end

local function addEntity(position, surface, entity, player)
    surface.create_entity{name = entity, position = position, force = player.force}
end

local function updateGUI(player_index, grid)
    --game.print("updating GUI for player " .. player_index)
    local player = game.get_player(player_index)
    if player == nil then
        return
    end
    local gui = player.gui
    -- scale camzoom based on grid width and height (max of either)
    local maxGridDimension = math.max(grid.width, grid.height)
    -- higher camzoom means more zoomed in
    local camZoom = 5 / maxGridDimension
    --game.print("camZoom: " .. camZoom)
    -- move cam to center of grid coordinates
    local camX = grid.width / 2
    local camY = grid.height / 2
    local camPosition = {camX, camY}
    --game.print("camPosition: " .. camX .. ", " .. camY)
    -- create frame and cam if there is none
    local root = gui.relative
    if root.equipment_camera_frame == nil then
        root.add{type = "frame", name = "equipment_camera_frame", direction = "vertical", caption = "Equipment Minifactory", anchor = {gui = defines.relative_gui_type.armor_gui, type = "armor", position = defines.relative_gui_position.right}}
        --game.print("created frame")
    end
    if root.equipment_camera_frame.equipment_camera == nil then
        root.equipment_camera_frame.add{type = "camera", name = "equipment_camera", position = camPosition, surface_index = game.get_surface("equipment_surface_" .. player_index).index, zoom = camZoom, style = "equipment_camera_style"}
        --game.print("created camera")
    else
        --update cam zoom
        root.equipment_camera_frame.equipment_camera.zoom = camZoom
        --update cam position
        root.equipment_camera_frame.equipment_camera.position = camPosition
    end
    -- TODO: add button to view player's equipment surface
end

local function createSurfaceEntities(surface, grid, player)
    for _, equipment in pairs(grid.equipment) do
        local position = equipment.position
        local name = equipment.name
        -- if entity with name doesnt exist, skip
        local entityPrototypes = prototypes.get_entity_filtered{{filter = "name", name = name}}
        if #(entityPrototypes) == 0 then
            --game.print("Entity " .. name .. " does not exist to place on surface " .. surface.name)
        else
            surface.create_entity{name = name, position = position, force = player.force}
        end
    end
end

local function getArmorGrid(player)
    local armor = player.character.get_inventory(defines.inventory.character_armor)[1]
    -- check slot isnt empty
    if armor.is_armor == false then
        return nil
    end
    if armor.grid == nil then
        return nil
    end
    --game.print(armor.name)
    local grid = armor.grid
    return grid
end

local function updateEquipmentSurface(playerIndex)
    local player = game.get_player(playerIndex)
    if player == nil then
        return
    end
    local grid = getArmorGrid(player)
    if grid == nil then
        return
    end
    --get/make equipment surface
    local surface = game.get_surface(getOrMakePlayerSurfaceName(playerIndex))
    player.force.chart_all(surface)
end

local function updateEquipmentSurfaceEndpoints(player_index)
    --game.print("updating endpoint items for player " .. player_index)
    local surface = game.get_surface(getOrMakePlayerSurfaceName(player_index))
    if surface == nil then
        return
    end
    local endpoint = surface.find_entities_filtered{type = "container"}
    if #endpoint == 0 then
        return
    end
    local endpointInventory = endpoint[1].get_inventory(defines.inventory.chest)
    if storage.playerGrids[player_index].endpointItems == nil then
        storage.playerGrids[player_index].endpointItems = {}
    end
    if endpointInventory == nil then
        return
    end
    if endpointInventory.is_empty() == false then
        local items = endpointInventory.get_contents()
        table.insert(storage.playerGrids[player_index].endpointItems, items)
        for _, item in pairs(items) do
            --game.print("added items to endpointItems" .. player_index .. ": " .. item.name .. " " .. item.count)
        end
        endpointInventory.clear()
    else
        table.insert(storage.playerGrids[player_index].endpointItems, {})
        --game.print("added empty table to endpointItems" .. player_index)
    end
    -- ensure endpointItems table does not exceed 10 elements
    if #storage.playerGrids[player_index].endpointItems > 10 then
        local removed = table.remove(storage.playerGrids[player_index].endpointItems, 1)
        for _, item in pairs(removed) do
            --game.print("removed element from endpointItems" .. player_index .. ": " .. item.name .. " " .. item.count)
        end
    end
end

local function getTotalEndpointItems(player_index) -- returns table of item name to item count
    --game.print("getting total endpoint items for player " .. player_index)
    local totalItems = {} 
    if storage.playerGrids[player_index].endpointItems == nil then
        --game.print("endpointItems is nil for " .. player_index)
    end
    for _, items in pairs(storage.playerGrids[player_index].endpointItems) do
        for _, item in pairs(items) do
            if totalItems[item.name] == nil then
                totalItems[item.name] = item.count
            else
                totalItems[item.name] = totalItems[item.name] + item.count
            end
        end
    end
    return totalItems
end

local function getBuffValue(itemName, itemCount)
    local buff = BuffDict[itemName]
    if buff == nil then
        game.print("buff not found for item " .. itemName)
        return nil
    else
        game.print("buff value applied for item " .. itemName .. ": " .. buff[2] * itemCount)
    end
    return buff[2] * itemCount
end

local function getBuffName(itemName)
    local buff = BuffDict[itemName]
    if buff == nil then
        game.print("buff not found for item " .. itemName)
        return nil
    else
        game.print("buff name applied for item " .. itemName .. ": " .. buff[1])
    end
    return buff[1]
end

local function updatePlayerBuffs(player_index) -- update storage with updated buff values
    game.print("updating player buffs for player " .. player_index)
    local totalItems = getTotalEndpointItems(player_index)
    -- ensure storage tables exist
    if storage.playerBuffs == nil then
        storage.playerBuffs = {}
    end
    if storage.playerBuffs[player_index] == nil then
        storage.playerBuffs[player_index] = {}
    end
    if storage.lastPlayerBuffs == nil then
        storage.lastPlayerBuffs = {}
    end
    -- update lastPlayerBuffs with values
    storage.lastPlayerBuffs[player_index] = {}
    for _, buffKey in pairs(BuffDict) do
        storage.lastPlayerBuffs[player_index][buffKey] = 0
    end
    for buff, value in pairs(storage.playerBuffs[player_index]) do
        storage.lastPlayerBuffs[player_index][buff] = value
    end
    -- update buffs with new values
    storage.playerBuffs[player_index] = {}
    for itemName, itemCount in pairs(totalItems) do
        game.print("item: " .. itemName .. " count: " .. itemCount)
        -- add buffs based on item count
        if storage.playerBuffs[player_index][itemCount] == nil or storage.playerBuffs[player_index][itemCount] == 0 then
            local buffValue = getBuffValue(itemName, itemCount)
            storage.playerBuffs[player_index][getBuffName(itemName)] = buffValue
        end
    end
end

-- TODO: make function for getting change in player buffs from storage and use that to update player's buffs
local function getBuffDifference(player_index) -- calculate difference in buffs between last update and now
    local difference = {}
    local buffNames = {}
    if storage.lastPlayerBuffs == nil or storage.lastPlayerBuffs == {} then
        return storage.playerBuffs[player_index]
    end
    -- get every buff name
    for _, buffKey in pairs(BuffDict) do
        -- dont add duplicates
        local exists = false
        for _, buffName in pairs(buffNames) do
            if buffName == buffKey[1] then
                exists = true
                break
            end
        end
        if exists == false then
            table.insert(buffNames, buffKey[1])
        end
    end
    for _, buffName in pairs(buffNames) do
        if storage.playerBuffs[player_index][buffName] == nil then
            storage.playerBuffs[player_index][buffName] = 0
        end
        if storage.lastPlayerBuffs[player_index][buffName] == nil then
            storage.lastPlayerBuffs[player_index][buffName] = 0
        end
        difference[buffName] = storage.playerBuffs[player_index][buffName] - storage.lastPlayerBuffs[player_index][buffName]
        game.print("------- buff differences")
        for buffName, buffValue in pairs(difference) do
            if buffValue > 0 or buffValue < 0 then
                game.print("buff difference: " .. buffName .. " " .. buffValue)
            end
        end
    end
end

local function applyPlayerBuffs(player_index) --TODO: add difference in buffs between last update and now to player's buffs
    local player = game.get_player(player_index)
    local count = 0
    if player == nil then
        return
    end
    -- check buffs table
    game.print("buffs count:" .. count)
    if storage.playerBuffs[player_index] == nil then
        game.print("buffs is nil")
        return
    end
    if storage.playerBuffs[player_index] == {} then
        game.print("buffs is empty")
        return
    end
    -- add difference in buffs
    local difference = getBuffDifference(player_index)
    for buffName, buffValue in pairs(storage.playerBuffs[player_index]) do
        player[buffName] = player[buffName] + difference[buffName]
    end
end

local function checkPlayerGrid(grid)
    if grid == nil then
        return false
    end
    if not grid.player_owner or not grid.player_owner.character then
        return false
    end
    return true
end

local function savePlayerGrid(grid, playerIndex)
    -- save player's grid to storage table for later comparison
    if playerIndex == nil then
        playerIndex = grid.player_owner.index
        --game.print("playerIndex is nil, setting to " .. playerIndex)
    end
    if storage.playerGrids == nil then
        storage.playerGrids = {}
        --game.print("created playerGrids table")
    end
    if storage.playerGrids[playerIndex] == nil then
        storage.playerGrids[playerIndex] = {}
    end
    if storage.playerGrids[playerIndex].equipment == nil then
        storage.playerGrids[playerIndex].equipment = {}
    end
    -- clear storage table
    storage.playerGrids[playerIndex].equipment = {}
    -- copy equipment pos and name to storage table
    for _, equipment in pairs(grid.equipment) do
        local position = equipment.position
        local name = equipment.name
        local equipmentCopy = {position = position, name = name}
        table.insert(storage.playerGrids[playerIndex].equipment, equipmentCopy)
    end
    --game.print("saved grid at storage.playerGrids[" .. playerIndex .. "], new count: " .. #storage.playerGrids[playerIndex].equipment)
    printEquipmentGridContents(grid)
end

local function getPositionsOfRemovedEquipment(grid, lastGrid)
    -- compare player's last saved grid to current grid to find removed equipment
    local positions = {}
    -- compare grid.equipment and lastGrid.equipment to find removed equipment- for each position in lastGrid.equipment, if it doesnt exist in grid.equipment, add to positions
    --game.print("count of equipment in lastGrid: " .. #lastGrid.equipment)
    printEquipmentGridContents(lastGrid)
    --game.print("count of equipment in grid: " .. #grid.equipment)
    printEquipmentGridContents(grid)
    for _, equipment in pairs(lastGrid.equipment) do
        local position = equipment.position
        local name = equipment.name
        local removed = true
        for _, currentEquipment in pairs(grid.equipment) do
            if currentEquipment.position.x == position.x and currentEquipment.position.y == position.y and currentEquipment.name == name then
                removed = false
                --game.print("equipment not removed, position: " .. position.x .. ", " .. position.y)
                break
            end
        end
        if removed == true then
            table.insert(positions, position)
        end
    end
    return positions
end

local function getPositionsOfAddedEquipment(grid, lastGrid)
    --game.print("getting positions of added equipment")
    -- compare player's last saved grid to current grid to find added equipment
    local positions = {}
    --game.print("count of equipment in lastGrid: " .. #lastGrid.equipment)
    printEquipmentGridContents(lastGrid)
    --game.print("count of equipment in grid: " .. #grid.equipment)
    printEquipmentGridContents(grid)
    -- compare grid.equipment and lastGrid.equipment to find added equipment- for each position in grid.equipment, if it doesnt exist in lastGrid.equipment, add to positions
    for _, equipment in pairs(grid.equipment) do
        local position = equipment.position
        local name = equipment.name
        local added = true
        for _, lastEquipment in pairs(lastGrid.equipment) do
            if lastEquipment.position.x == position.x and lastEquipment.position.y == position.y and lastEquipment.name == name then
                added = false
                --game.print("equipment not added, position: " .. position.x .. ", " .. position.y)
                break
            end
        end
        if added == true then
            table.insert(positions, position)
        end
    end
    return positions
end

local function onAddEquipment(event)
    --game.print("adding equipment")
    local grid = event.grid
    local entity = event.equipment.name
    local shape = event.equipment.shape
    if checkPlayerGrid(grid) == false then
        return
    end
    local playerIndex = event.grid.player_owner.index
    local player = game.get_player(playerIndex)
    local lastGrid = storage.playerGrids[playerIndex]
    local positions = getPositionsOfAddedEquipment(grid, lastGrid)
    savePlayerGrid(grid, playerIndex)
    updateEquipmentSurface(playerIndex)
    -- check positions has at least one element and add new entities to surface
    if #positions > 0 then
        for _, position in pairs(positions) do
            --game.print("adding entity to surface " .. getOrMakePlayerSurfaceName(playerIndex) .. " at position: " .. position.x .. ", " .. position.y)
            -- make sure it's placed at top left corner according to shape (since it seems to place at bottom right default)
            if shape.width > 1 then
                local count = shape.width
                while count > 1 do
                    position.x = position.x + 1
                    count = count - 1
                end
            end
            if shape.height > 1 then
                local count = shape.height
                while count > 1 do
                    position.y = position.y + 1
                    count = count - 1
                end
            end
            addEntity(position, game.get_surface(getOrMakePlayerSurfaceName(playerIndex)), entity, player)
        end
    else
        --game.print("no positions to add")
    end
end



local function onRemoveEquipment(event)
    --game.print("removing equipment")
    local grid = event.grid
    if checkPlayerGrid(grid) == false then
        --game.print("not player grid")
        return
    end
    local playerIndex = event.grid.player_owner.index
    local player = game.get_player(playerIndex)
    local lastGrid = storage.playerGrids[playerIndex]
    local positions = getPositionsOfRemovedEquipment(grid, lastGrid)
    savePlayerGrid(grid, playerIndex)
    updateEquipmentSurface(playerIndex)
    if #positions > 0 then
        for _, position in pairs(positions) do
            deleteEntity(position, game.get_surface(getOrMakePlayerSurfaceName(playerIndex)))
        end
    else
        --game.print("no positions to remove, positions = " .. #positions)
    end
end

local function onChangeArmor(event)
    local playerIndex = event.player_index
    local player = game.get_player(playerIndex)
    local grid = getArmorGrid(player)
    local surface = game.get_surface(getOrMakePlayerSurfaceName(playerIndex))
    if grid == nil then
        return
    end
    --game.print(event.player_index)
    updateEquipmentSurface(playerIndex)
    clearAndPrepareSurface(surface)
    createSurfaceEntities(surface, grid, player)
    updateGUI(playerIndex, grid)
    savePlayerGrid(grid, playerIndex)
end

local function onTick(event)
    local endpointsSeconds = 5
    if event.tick % (60 * endpointsSeconds) == 0 then
        for _, player in pairs(game.players) do
            updateEquipmentSurfaceEndpoints(player.index)
            if game.get_surface(getOrMakePlayerSurfaceName(player.index)) ~= nil then
                player.force.chart_all(game.get_surface(getOrMakePlayerSurfaceName(player.index)))
            end
            updatePlayerBuffs(player.index)
            applyPlayerBuffs(player.index)
        end
    end
end


script.on_event(defines.events.on_equipment_inserted, onAddEquipment)
script.on_event(defines.events.on_equipment_removed, onRemoveEquipment)
script.on_event(defines.events.on_player_armor_inventory_changed, onChangeArmor)

script.on_event(defines.events.on_tick, onTick)

-- TODO: add update proofing to GUI, see https://github.com/ClaudeMetz/UntitledGuiGuide/wiki/Chapter-8:-Going-With-the-Times