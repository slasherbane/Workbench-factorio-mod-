---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by FiercePC.
--- DateTime: 17/11/2022 21:19
---

local Event = require('__stdlib__/stdlib/event/event')

Event.register(defines.events.on_init,function(e)
    Main()
end)

Event.register(defines.events.CustomInputEvent,function(e)
    if(e.input_name == "create_workbench")then

        if( not WorkBenchDeploy:alreadyExistWorkbench(e.entity)) then
            table.insert(global.Workable,WorkBench:new(e.entity))
        end
    end
end)