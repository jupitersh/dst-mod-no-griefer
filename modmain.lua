if (not GLOBAL.TheNet:GetIsServer()) or GLOBAL.TheShard:IsSecondary() then
    return
end

local json = GLOBAL.json

local function GetId()
    GLOBAL.TheSim:QueryServer("https://gitee.com/jupitersh/dstgriefer/raw/master/grieferlist.json",
    function(result, isSuccessful, resultCode)
        if isSuccessful and string.len(result) > 1 and resultCode == 200 then
            local players = json.decode(result)
            for _, player in pairs(players) do
                GLOBAL.TheNet:Ban(player)
            end
        end
    end, "GET")
end

AddPrefabPostInit("world", function(inst)
    inst:DoTaskInTime(0, GetId)
end)