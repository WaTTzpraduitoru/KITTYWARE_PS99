getgenv().autoGarden = true
getgenv().InstaPlant = true
getgenv().Water = false

local RepStor = game.ReplicatedStorage
local Library = require(RepStor.Library)

while getgenv().autoGarden do task.wait()
    for i = 1,10 do
        Library.Network.Invoke("Instancing_InvokeCustomFromClient", "FlowerGarden", "PlantSeed", i, "Diamond")
        if getgenv().InstaPlant then Library.Network.Invoke("Instancing_InvokeCustomFromClient", "FlowerGarden", "InstaGrowSeed", i) end
        if getgenv().Water then Library.Network.Invoke("Instancing_InvokeCustomFromClient", "FlowerGarden", "WaterSeed", i) end
        Library.Network.Invoke("Instancing_InvokeCustomFromClient", "FlowerGarden", "ClaimPlant", i)
    end
end

local lootbags = nil
lootbags = workspace.__THINGS.Lootbags.ChildAdded:Connect(function(v)
    Library.Network.Fire("Lootbags_Claim",{v.Name})
    task.wait()
    v:Destroy()
end)
