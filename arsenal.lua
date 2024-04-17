-- Booting the library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

OrionLib:MakeNotification({
	Name = "Made by iiTzBenni",
	Content = "Thanks for using our script",
	Image = "rbxassetid://4483345998",
	Time = 15
})

-- Window
local Window = OrionLib:MakeWindow({Name = "NeverWin - Arsenal", HidePremium = false, SaveConfig = true, ConfigFolder = "Orion", 
IntroEnabled = true, IntroText ="NeverWin Hub", IntroIcon = "https://i.ibb.co/WyQcqLW/B11-EAE04-032-E-4-DB9-9-B11-125-FDAE006-EE.jpg", Icon = "https://i.ibb.co/WyQcqLW/B11-EAE04-032-E-4-DB9-9-B11-125-FDAE006-EE.jpg"})

-- Main Tab
local MainTab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local MainSection = MainTab:AddSection({
	Name = "Gun Modifiers"
})

-- Inf ammo
local Player = game.Players.LocalPlayer
local InfiniteAmmo = false

local Player = game.Players.LocalPlayer
local InfiniteAmmo = false

MainTab:AddToggle({
    Name = "Infinite Ammo",
    Default = false,
    Callback = function(Value)
        InfiniteAmmo = Value
    end
})

game.Players.LocalPlayer.Backpack.Arsenal.Changed:Connect(function()
    if InfiniteAmmo then
        game.Players.LocalPlayer.Backpack.Arsenal.Ammo.Value = _G.AmmoInClip
    end
end)

game.Players.LocalPlayer.Backpack.Arsenal.Ammo.Changed:Connect(function()
    if InfiniteAmmo then
        game.Players.LocalPlayer.Backpack.Arsenal.Ammo.Value = _G.AmmoInClip
    end
end)

OrionLib:Init()
