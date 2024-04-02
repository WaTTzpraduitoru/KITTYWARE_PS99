getgenv().autoFruit = true
getgenv().checkTime = 30 -- amount of seconds to wait before checking again
getgenv().fruitTable = {"Apple", "Banana", "Orange", "Pineapple", "Watermelon", "Rainbow"}

local Library = require(game.ReplicatedStorage.Library)
local saveMod = require(game.ReplicatedStorage.Library.Client.Save)
local FruitMod = require(game.ReplicatedStorage.Library).FruitCmds
function Info(class) return saveMod.Get()["Inventory"][class] end
while getgenv().autoFruit do
    for _,fruit in pairs(getgenv().fruitTable) do
        if not FruitMod.Has(fruit) then 
            print("Need fruit",fruit)
            for ID,v in pairs(Info("Fruit")) do
                if v.id == fruit then
                    local amount; if not v._am then amount = 1 elseif v._am >= 20 then amount = 20 elseif v._am < 20 then amount = v._am end
                    warn("Attempting to Eat:", v.id, amount)
                    Library.Network.Fire("Fruits: Consume", ID, amount)
                end
                task.wait(.5)
            end
        end
    end
    task.wait(getgenv().checkTime)
end
