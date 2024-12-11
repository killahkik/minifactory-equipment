-- TODO: make minifactory buildings- void powered assemblers, inserters for use in minifactory
-- TODO: look up how to have an underground make infinite items come out

-- TODO: make minifactory equipment entities- assemblers, inserters, belts
-- TODO: add locales for everything
-- equipment entities
local minifactoryBelt = {
    name = "minifactory-belt",
    type = "inventory-bonus-equipment",
    inventory_size_bonus = 0,
    shape = {
        width = 1,
        height = 1,
        type = "full"
    },
    categories = {"armor"},
    sprite = {
        filename = "__minifactory-equipment__/graphics/icons/transport-belt.png",
        width = 64,
        height = 64,
        priority = "medium"
    }
}
data:extend{minifactoryBelt}

local minifactoryInserter = {
    name = "minifactory-inserter",
    type = "inventory-bonus-equipment",
    inventory_size_bonus = 0,
    shape = {
        width = 1,
        height = 1,
        type = "full"
    },
    categories = {"armor"},
    sprite = {
        filename = "__minifactory-equipment__/graphics/icons/inserter.png",
        width = 64,
        height = 64,
        priority = "medium"
    }
}
data:extend{minifactoryInserter}

local minifactoryLongInserter = {
    name = "minifactory-long-inserter",
    type = "inventory-bonus-equipment",
    inventory_size_bonus = 0,
    shape = {
        width = 1,
        height = 1,
        type = "full"
    },
    categories = {"armor"},
    sprite = {
        filename = "__minifactory-equipment__/graphics/icons/long-handed-inserter.png",
        width = 64,
        height = 64,
        priority = "medium"
    }
}
data:extend{minifactoryLongInserter}

local minifactoryAssembler = {
    name = "minifactory-assembler",
    type = "inventory-bonus-equipment",
    inventory_size_bonus = 0,
    shape = {
        width = 2,
        height = 2,
        type = "full"
    },
    categories = {"armor"},
    sprite = {
        filename = "__minifactory-equipment__/graphics/icons/assembling-machine-1.png",
        width = 64,
        height = 64,
        priority = "medium"
    }
}
data:extend{minifactoryAssembler}

local minifactoryAssembler2 = {
    name = "minifactory-assembler-2",
    type = "inventory-bonus-equipment",
    inventory_size_bonus = 0,
    shape = {
        width = 2,
        height = 2,
        type = "full"
    },
    categories = {"armor"},
    sprite = {
        filename = "__minifactory-equipment__/graphics/icons/assembling-machine-2.png",
        width = 64,
        height = 64,
        priority = "medium"
    }
}
data:extend{minifactoryAssembler2}

-- building entities
local minifactoryBelt = table.deepcopy(data.raw["transport-belt"]["transport-belt"])
minifactoryBelt.name = "minifactory-belt"
data:extend{minifactoryBelt}

local minifactoryInserter = table.deepcopy(data.raw["inserter"]["inserter"])
minifactoryInserter.name = "minifactory-inserter"
minifactoryInserter.energy_source = {
    type = "void",
    usage_priority = "secondary-input",
    emissions = 0
}
data:extend{minifactoryInserter}

local minifactoryLongInserter = table.deepcopy(data.raw["inserter"]["long-handed-inserter"])
minifactoryLongInserter.name = "minifactory-long-inserter"
minifactoryLongInserter.energy_source = {
    type = "void",
    usage_priority = "secondary-input",
    emissions = 0
}
data:extend{minifactoryLongInserter}

local minifactoryAssembler = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-1"])
minifactoryAssembler.name = "minifactory-assembler"
minifactoryAssembler.energy_source = {
    type = "void",
    usage_priority = "secondary-input",
    emissions = 0
}
minifactoryAssembler.graphics_set.animation.layers[1].scale = 0.333
minifactoryAssembler.graphics_set.animation.layers[2].scale = 0.333
minifactoryAssembler.collision_box = {{-0.8, -0.8}, {0.8, 0.8}}
minifactoryAssembler.selection_box = {{-1, -1}, {1, 1}}
minifactoryAssembler.next_upgrade = nil
data:extend{minifactoryAssembler}

local minifactoryAssembler2 = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-2"])
minifactoryAssembler2.name = "minifactory-assembler-2"
minifactoryAssembler2.energy_source = {
    type = "void",
    usage_priority = "secondary-input",
    emissions = 0
}
minifactoryAssembler2.graphics_set.animation.layers[1].scale = 0.333
minifactoryAssembler2.graphics_set.animation.layers[2].scale = 0.333
minifactoryAssembler2.collision_box = {{-0.8, -0.8}, {0.8, 0.8}}
minifactoryAssembler2.selection_box = {{-1, -1}, {1, 1}}
minifactoryAssembler2.fluid_boxes[1].pipe_connections[1].position = {0, -0.5}
minifactoryAssembler2.fluid_boxes[2].pipe_connections[1].position = {0, -0.5}
minifactoryAssembler2.next_upgrade = nil
data:extend{minifactoryAssembler2}
