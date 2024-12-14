-- minifactory belt

local minifactoryBelt = {
    type = "item",
    name = "minifactory-belt",
    icon = "__minifactory-equipment__/graphics/icons/transport-belt.png",
    icon_size = 64,
    subgroup = "minifactory-equipment",
    order = "a",
    place_as_equipment_result = "minifactory-belt",
    stack_size = 50
}
data:extend{minifactoryBelt}

local recipe = {
    type = "recipe",
    name = "minifactory-belt",
    enabled = true,
    order = "a",
    ingredients = {
        {type = "item", name = "iron-plate", amount = 10},
        {type = "item", name = "transport-belt", amount = 15}
    },
    results = {{type = "item", name = "minifactory-belt", amount = 1}}
}
data:extend{recipe}

-- minifactory inserter

local minifactoryInserter = {
    type = "item",
    name = "minifactory-inserter",
    icon = "__minifactory-equipment__/graphics/icons/fast-inserter.png",
    icon_size = 64,
    subgroup = "minifactory-equipment",
    order = "b",
    place_as_equipment_result = "minifactory-inserter",
    stack_size = 50
}
data:extend{minifactoryInserter}

local recipe = {
    type = "recipe",
    name = "minifactory-inserter",
    enabled = true,
    order = "a",
    ingredients = {
        {type = "item", name = "iron-plate", amount = 20},
        {type = "item", name = "electronic-circuit", amount = 30},
        {type = "item", name = "inserter", amount = 5}
    },
    results = {{type = "item", name = "minifactory-inserter", amount = 1}}
}
data:extend{recipe}

-- minifactory long inserter
local minifactoryLongInserter = {
    type = "item",
    name = "minifactory-long-inserter",
    icon = "__minifactory-equipment__/graphics/icons/long-handed-inserter.png",
    icon_size = 64,
    subgroup = "minifactory-equipment",
    order = "c",
    place_as_equipment_result = "minifactory-long-inserter",
    stack_size = 50
}
data:extend{minifactoryLongInserter}

local recipe = {
    type = "recipe",
    name = "minifactory-long-inserter",
    enabled = true,
    order = "a",
    ingredients = {
        {type = "item", name = "iron-plate", amount = 20},
        {type = "item", name = "electronic-circuit", amount = 30},
        {type = "item", name = "long-handed-inserter", amount = 5}
    },
    results = {{type = "item", name = "minifactory-long-inserter", amount = 1}}
}
data:extend{recipe}

--minifactory assembler 2
local minifactoryAssembler2 = {
    type = "item",
    name = "minifactory-assembler-2",
    icon = "__minifactory-equipment__/graphics/icons/assembling-machine-2.png",
    icon_size = 64,
    subgroup = "minifactory-equipment",
    order = "e",
    place_as_equipment_result = "minifactory-assembler-2",
    stack_size = 50
}
data:extend{minifactoryAssembler2}

local recipe = {
    type = "recipe",
    name = "minifactory-assembler-2",
    enabled = true,
    order = "a",
    ingredients = {
        {type = "item", name = "iron-plate", amount = 20},
        {type = "item", name = "electronic-circuit", amount = 30},
        {type = "item", name = "assembling-machine-2", amount = 5}
    },
    results = {{type = "item", name = "minifactory-assembler-2", amount = 1}}
}
data:extend{recipe}

local minifactoryEndpoint = {
    type = "item",
    name = "minifactory-endpoint",
    icon = "__minifactory-equipment__/graphics/icons/steel-chest.png",
    icon_size = 64,
    subgroup = "minifactory-equipment",
    order = "f",
    place_as_equipment_result = "minifactory-endpoint",
    stack_size = 50
}
data:extend{minifactoryEndpoint}

local recipe = {
    type = "recipe",
    name = "minifactory-endpoint",
    enabled = true,
    order = "a",
    ingredients = {
        {type = "item", name = "steel-plate", amount = 20},
        {type = "item", name = "advanced-circuit", amount = 30},
        {type = "item", name = "steel-chest", amount = 5}
    },
    results = {{type = "item", name = "minifactory-endpoint", amount = 1}}
}
data:extend{recipe}

--minifactory spawner iron
local minifactorySpawnerIron = {
    type = "item",
    name = "minifactory-spawner-iron",
    icon = "__minifactory-equipment__/graphics/icons/underground-belt.png",
    icon_size = 64,
    subgroup = "minifactory-equipment",
    order = "g",
    place_as_equipment_result = "minifactory-spawner-iron",
    stack_size = 50
}
data:extend{minifactorySpawnerIron}

local recipe = {
    type = "recipe",
    name = "minifactory-spawner-iron",
    enabled = true,
    order = "a",
    ingredients = {
        {type = "item", name = "iron-plate", amount = 20},
        {type = "item", name = "electronic-circuit", amount = 5},
        {type = "item", name = "underground-belt", amount = 10}
    },
    results = {{type = "item", name = "minifactory-spawner-iron", amount = 1}}
}
data:extend{recipe}

--minifactory spawner copper
local minifactorySpawnerCopper = {
    type = "item",
    name = "minifactory-spawner-copper",
    icon = "__minifactory-equipment__/graphics/icons/underground-belt.png",
    icon_size = 64,
    subgroup = "minifactory-equipment",
    order = "h",
    place_as_equipment_result = "minifactory-spawner-copper",
    stack_size = 50
}
data:extend{minifactorySpawnerCopper}

local recipe = {
    type = "recipe",
    name = "minifactory-spawner-copper",
    enabled = true,
    order = "a",
    ingredients = {
        {type = "item", name = "copper-plate", amount = 20},
        {type = "item", name = "electronic-circuit", amount = 5},
        {type = "item", name = "underground-belt", amount = 10}
    },
    results = {{type = "item", name = "minifactory-spawner-copper", amount = 1}}
}
data:extend{recipe}