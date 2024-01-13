local prefabs = 
{
	"bee",
}

local assets =
{
    Asset("ANIM", "anim/beemine_hat.zip"),
    Asset("ANIM", "anim/beemine_hat_swap.zip"),
    Asset("SOUND", "sound/bee.fsb"), 

    Asset("ATLAS", "images/inventoryimages/beemine_hat.xml"),
    Asset("IMAGE", "images/inventoryimages/beemine_hat.tex"),
}

TUNING.BEEMINE_HAT_HP = 1
TUNING.BEEMINE_HAT_ABSORP = 0

local TARGET_CANT_TAGS = { "playerghost", "character"  }
local TARGET_ONEOF_TAGS = { "animal", "monster", "insect" }

local function SpawnBees(inst)
    inst.SoundEmitter:PlaySound("dontstarve/bee/beemine_explo")
    local player = GetPlayer()

    local target = FindEntity(player, 25, nil, nil, TARGET_CANT_TAGS, TARGET_ONEOF_TAGS)
    
    if target ~= nil then
        for i = 1, TUNING.BEEMINE_BEES do
            local bee = SpawnPrefab(inst.beeprefab)
            if bee ~= nil then
                local x, y, z = player.Transform:GetWorldPosition()
                local dist = math.random()
                local angle = math.random() * 2 * PI
                bee.Physics:Teleport(x + dist * math.cos(angle), y, z + dist * math.sin(angle))
                if bee.components.combat ~= nil then
                    bee.components.combat:SetTarget(target)
                end
            end
        end
        target:PushEvent("coveredinbees")
    end
end

local function OnTakeDamage(inst, damage_amount)
    SpawnBees(inst)
end

local function onEquip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_hat", "beemine_hat_swap", "swap_hat")
    owner.AnimState:Show("HAT")
    owner.AnimState:Show("HAIR_HAT")
    owner.AnimState:Hide("HAIR_NOHAT")
    owner.AnimState:Hide("HAIR")
    
    if owner:HasTag("player") then
        owner.AnimState:Hide("HEAD")
        owner.AnimState:Show("HEAD_HAIR")
    end
end


local function onUnequip(inst, owner)
    owner.AnimState:Hide("HAT")
    owner.AnimState:Hide("HAIR_HAT")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")

    if owner:HasTag("player") then
        owner.AnimState:Show("HEAD")
        owner.AnimState:Hide("HEAD_HAIR")
    end
end

local function fn()
	local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()

    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)

    anim:SetBank("beemine_hat")
    anim:SetBuild("beemine_hat")
    anim:PlayAnimation("idle")

    inst.beeprefab = "bee"
    inst:AddComponent("inspectable")

    inst:AddTag("hat")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "beemine_hat"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/beemine_hat.xml"
    
    inst:AddComponent("armor")
    inst.components.armor:InitCondition(TUNING.BEEMINE_HAT_HP, TUNING.BEEMINE_HAT_ABSORP)
    inst.components.armor.ontakedamage = OnTakeDamage
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(onEquip)
    inst.components.equippable:SetOnUnequip(onUnequip)

	return inst
end

return Prefab( "common/inventory/beemine_hat", fn, assets, prefabs ) 