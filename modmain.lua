if (not GLOBAL.TheNet:GetIsServer()) or GLOBAL.TheShard:IsSlave() then
    return
end

local function GetId()
    GLOBAL.TheSim:QueryServer("https://gitee.com/jupitersh/dstgriefer/raw/master/grieferlist",
    function(result, isSuccessful, resultCode)
        if isSuccessful and string.len(result) > 1 and resultCode == 200 then
            --print(result)
            for item in string.gmatch(result, "[^\n]+") do
                GLOBAL.TheNet:Ban(item)
            end
        end
    end, "GET")
end

AddPrefabPostInit("world", function(inst)
    inst:DoTaskInTime(0, GetId)
end)