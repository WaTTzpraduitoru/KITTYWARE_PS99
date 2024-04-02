getgenv().autoAuction = true
local itemClass = "Pet"
local itemName = "Huge Bat"
local SellPrice = 25000000

repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.PlaceId ~= nil
repeat task.wait() until game:GetService("Players").LocalPlayer
repeat task.wait() until not game.Players.LocalPlayer.PlayerGui:FindFirstChild("__INTRO")

local RepStor = game.ReplicatedStorage
local Player = game.Players.LocalPlayer
local Library = require(RepStor.Library)
local Network = game.ReplicatedStorage.Network
local HttpService = game:GetService("HttpService")
local saveMod = require(RepStor.Library.Client.Save).Get()
local itemUID = nil
for i,v in pairs(saveMod.Inventory[itemClass]) do
    if v.id == itemName then
        itemUID = i
        break
    end
end

function getServer()
    local servers = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. tostring(game.PlaceId) .. '/servers/Public?sortOrder=Desc&limit=100')).data
    local server = servers[Random.new():NextInteger(10, 80)]
    if server then return server else return getServer() end
end

while getgenv().autoAuction do task.wait()
    local AuctionSuccess,AuctionReason = game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Auction: Create"):InvokeServer(itemUID, SellPrice)
    if not AuctionSuccess then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, getServer().id, Player)
    end
end
