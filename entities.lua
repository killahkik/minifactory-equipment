
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
        filename = "__minifactory-equipment__/graphics/icons/fast-inserter.png",
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

local minifactoryEndpoint = {
    name = "minifactory-endpoint",
    type = "inventory-bonus-equipment",
    inventory_size_bonus = 0,
    shape = {
        width = 1,
        height = 1,
        type = "full"
    },
    categories = {"armor"},
    sprite = {
        filename = "__minifactory-equipment__/graphics/icons/steel-chest.png",
        width = 64,
        height = 64,
        priority = "medium"
    }
}
data:extend{minifactoryEndpoint}

local minifactorySpawnerIron = {
    name = "minifactory-spawner-iron",
    type = "inventory-bonus-equipment",
    inventory_size_bonus = 0,
    shape = {
        width = 1,
        height = 1,
        type = "full"
    },
    categories = {"armor"},
    sprite = {
        filename = "__minifactory-equipment__/graphics/icons/minifactory-spawner-iron.png",
        width = 64,
        height = 64,
        priority = "medium"
    }
}
data:extend{minifactorySpawnerIron}

local minifactorySpawnerCopper = {
    name = "minifactory-spawner-copper",
    type = "inventory-bonus-equipment",
    inventory_size_bonus = 0,
    shape = {
        width = 1,
        height = 1,
        type = "full"
    },
    categories = {"armor"},
    sprite = {
        filename = "__minifactory-equipment__/graphics/icons/minifactory-spawner-copper.png",
        width = 64,
        height = 64,
        priority = "medium"
    }
}
data:extend{minifactorySpawnerCopper}

local minifactoryElectricFurnace = {
    name = "minifactory-electric-furnace",
    type = "inventory-bonus-equipment",
    inventory_size_bonus = 0,
    shape = {
        width = 3,
        height = 3,
        type = "full"
    },
    categories = {"armor"},
    sprite = {
        filename = "__minifactory-equipment__/graphics/icons/electric-furnace.png",
        width = 64,
        height = 64,
        priority = "medium"
    }
}
data:extend{minifactoryElectricFurnace}

-- building entities
local minifactoryBelt = table.deepcopy(data.raw["transport-belt"]["transport-belt"])
minifactoryBelt.name = "minifactory-belt"
data:extend{minifactoryBelt}

local minifactoryInserter = table.deepcopy(data.raw["inserter"]["fast-inserter"])
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

local minifactoryEndpoint = table.deepcopy(data.raw["container"]["steel-chest"])
minifactoryEndpoint.name = "minifactory-endpoint"
minifactoryEndpoint.next_upgrade = nil
data:extend{minifactoryEndpoint}

local minifactorySpawnerIron = table.deepcopy(data.raw["underground-belt"]["underground-belt"])
minifactorySpawnerIron.name = "minifactory-spawner-iron"
minifactorySpawnerIron.minable.result = "minifactory-spawner-iron"
minifactorySpawnerIron.max_distance = 0
minifactorySpawnerIron.next_upgrade = nil
data:extend{minifactorySpawnerIron}

local minifactorySpawnerCopper = table.deepcopy(data.raw["underground-belt"]["underground-belt"])
minifactorySpawnerCopper.name = "minifactory-spawner-copper"
minifactorySpawnerCopper.minable.result = "minifactory-spawner-copper"
minifactorySpawnerCopper.max_distance = 0
minifactorySpawnerCopper.next_upgrade = nil
data:extend{minifactorySpawnerCopper}

local minifactoryElectricFurnace = table.deepcopy(data.raw["furnace"]["electric-furnace"])
minifactoryElectricFurnace.name = "minifactory-electric-furnace"
minifactoryElectricFurnace.energy_source = {
    type = "void",
    usage_priority = "secondary-input",
    emissions = 0
}
minifactoryElectricFurnace.crafting_speed = 5.333
minifactoryElectricFurnace.next_upgrade = nil
data:extend{minifactoryElectricFurnace}