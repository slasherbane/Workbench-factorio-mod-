---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by FiercePC.
--- DateTime: 15/11/2022 20:04
---

local Is = require('__stdlib__/stdlib/utils/is')
local Table = require('__stdlib__/stdlib/utils/table')

WorkBench = {
    luaEntity = nil,
    deploy = false,
    actualRecipe = nil,
    status = "empty" ,--empty , crafting ,error , requested , pending
    standardAmount = 40,
    index = nil
}
WorkBench.__index = WorkBench

function WorkBench:new(assembler)

    if Is.Nil(assembler) then
        log("No assembler")
        return
    end

    local work = {}
    setmetatable(work,WorkBench)
    work.luaEntity = assembler
    return work
end




-- force if true ignore the check against the status of the workbench
function Workbench.setRecipe(recipe,force)

    if( not force and self.status ~= "empty")then
        return
    end
    self.clearRecipe()
    self.actualRecipe = recipe
    self.status = "crafting"
end

function WorkBench.clearRecipe()
    self.actualRecipe = nil
    self.status = "empty"
end


-- verify if the actual recipe sequence in the machine need to be pursued,check the robot chest network  and if any change is detect
-- the crafting sequence is stop for that recipe if the amount is equal or beyond the needed amount
function WorkBench.verify()
    if(not Is.Nil(self.actualRecipe))then
        local checkNetworkData = {} --gatherData

        for _, item in pairs(checkNetworkData) do

            local recipeName = self.actualRecipe.luaRecipe.products[1].name
            if  recipeName == item.name and self.actualRecipe.craft >= item.amount then
                 self.discardRecipe(-1)
                 self.clearRecipe()
            end
        end
    end
end

function WorkBench.discardRecipe(value)
    self.actualRecipe.discardRecipe = value
    self.status = "pending"

end

function WorkBench.skipRecipe(time)
    self.actualRecipe.skip = true
    self.actualRecipe.skipTime = time
    self.clearRecipe()
end

-- process the time in game for chest and entity an recipe
function WorkBench.process()

end