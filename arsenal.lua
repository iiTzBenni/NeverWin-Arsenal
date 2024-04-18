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

-- inf ammo
local InfiniteAmmo = MainTab:AddToggle({
    Name = "Infinite Ammo",
    Default = false,
    Callback = function(Value)
        if Value then
            game.ReplicatedStorage.AmmoPickupEvent.OnServerEvent:Connect(function(player, pickup)
                local weapon = player.Character:FindFirstChild("Gun")
                if weapon then
                    local ammoBox = weapon:FindFirstChild("AmmoBox")
                    if ammoBox then
                        local ammo = ammoBox:FindFirstChild("CurrentAmmo")
                        if ammo then
                            ammo.Value = ammo.Value + ammoBox.MaxAmmo.Value
                        end
                    end
                end
            end)
        else
            game.ReplicatedStorage.AmmoPickupEvent.OnServerEvent:Disconnect()
        end
    end    
})

-- fast fire rate
local FastFireRate = MainTab:AddToggle({
    Name = "Fast Fire Rate",
    Default = false,
    Callback = function(Value)
        if Value then
            local gun = game.Players.LocalPlayer.Character:FindFirstChild("Gun")
            if gun then
                local fireRate = gun:FindFirstChild("FireRate")
                if fireRate then
                    fireRate.Value = fireRate.Value / 2 -- Set the fire rate to half of its original value
                end
            end
        else
            local gun = game.Players.LocalPlayer.Character:FindFirstChild("Gun")
            if gun then
                local fireRate = gun:FindFirstChild("FireRate")
                if fireRate then
                    fireRate.Value = fireRate.Value * 2 -- Reset the fire rate to its original value
                end
            end
        end
    end    
})

-- rainbow gun

local RainbowGun = MainTab:AddToggle({
    Name = "Rainbow Gun",
    Default = false,
    Callback = function(Value)
        if Value then
            local gun = game.Players.LocalPlayer.Character:FindFirstChild("Gun")
            if gun then
                local rainbowMaterial = Instance.new("Material")
                rainbowMaterial.Name = "RainbowMaterial"
                rainbowMaterial.Parent = gun
                local rainbowColor = Instance.new("NumberValue")
                rainbowColor.Name = "RainbowColor"
                rainbowColor.Parent = rainbowMaterial
                rainbowColor.Value = 0
                local hueShift = 0.01
                spawn(function()
                    while Value do
                        rainbowColor.Value = rainbowColor.Value + hueShift
                        if rainbowColor.Value > 1 then
                            rainbowColor.Value = 0
                        end
                        rainbowMaterial.Color = Color3.fromHSV(rainbowColor.Value, 1, 1)
                        wait(0.05)
                    end
                end)
            end
        else
            local gun = game.Players.LocalPlayer.Character:FindFirstChild("Gun")
            if gun then
                local rainbowMaterial = gun:FindFirstChild("RainbowMaterial")
                if rainbowMaterial then
                    rainbowMaterial:Destroy()
                end
            end
        end
    end    
})

OrionLib:Init()
