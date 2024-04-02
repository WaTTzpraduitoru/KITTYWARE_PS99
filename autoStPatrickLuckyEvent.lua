local Client = require(game.ReplicatedStorage.Library.Client)
local Library = require(game.ReplicatedStorage.Library)
local HatchCount = Client.Save.Get().EggHatchCount

for i,v in pairs(Client.CustomEggsCmds.All()) do
    if v._id == "St Patrick Egg" then
        if v._hatchable then
            while v._hatchable do
                game.Players.LocalPlayer.CFrame = CFrame.new(Vector3.new(v._position))
                Library.Network.Invoke("CustomEggs_Hatch", v._uid, HatchCount)
            end
        end
    end
end
