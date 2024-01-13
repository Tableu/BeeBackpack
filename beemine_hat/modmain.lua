PrefabFiles = {
        "beemine_hat"
}
 

STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH

GLOBAL.STRINGS.NAMES.BEEMINE_HAT = "Beemine Hat"
STRINGS.RECIPE_DESC.BEEMINE_HAT = "Protect yourself with bees"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.BEEMINE_HAT = "Now that's smart!"

local beemine_hat = GLOBAL.Recipe("beemine_hat",{ Ingredient("beemine", 1), Ingredient("strawhat", 1)},                     
RECIPETABS.DRESS, TECH.NONE)