-- Booting the library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

OrionLib:MakeNotification({
	Name = "Made by iiTzBenni",
	Content = "Thanks for using our script",
	Image = "rbxassetid://4483345998",
	Time = 5
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

-- NeverWin - Arsenal Script (Infinite Ammo)
local Player = game.Players.LocalPlayer
local Ammo = 0
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
        Ammo = math.huge
    else
        Ammo = 0
    end
end)

game.Players.LocalPlayer.Backpack.Arsenal.Ammo.Changed:Connect(function()
    if InfiniteAmmo then
        Ammo = math.huge
    end
end)

-- NeverWin - Arsenal Script (Fast Fire Rate)

local Player = game.Players.LocalPlayer
local FireRateMultiplier = 0.5 -- Set the fire rate multiplier here (e.g. 0.5 for double fire rate)
local FastFireRate = false

MainTab:AddToggle({
    Name = "Fast Fire Rate",
    Default = false,
    Callback = function(Value)
        FastFireRate = Value
    end
})

game.Players.LocalPlayer.Backpack.Arsenal.FireRate.Changed:Connect(function()
    if FastFireRate then
        local CurrentFireRate = Player.Backpack.Arsenal.FireRate.Value
        Player.Backpack.Arsenal.FireRate.Value = CurrentFireRate * FireRateMultiplier
    end
end)

-- NeverWin - Arsenal Script (Rainbow Gun)

local Player = game.Players.LocalPlayer
local RainbowGun = false

MainTab:AddToggle({
    Name = "Rainbow Gun",
    Default = false,
    Callback = function(Value)
        RainbowGun = Value
    end
})

game.Players.LocalPlayer.Backpack.Arsenal.PrimaryPart.Color = Color3.fromHSV(math.random(), 1, 1)

game.Players.LocalPlayer.Backpack.Arsenal.PrimaryPart.Touched:Connect(function(hit)
    if RainbowGun then
        game.Players.LocalPlayer.Backpack.Arsenal.PrimaryPart.Color = Color3.fromHSV(math.random(), 1, 1)
    end
end)

local MainSection = MainTab:AddSection({
	Name = "Aim Modifiers"
})

-- NeverWin - Arsenal Script (Aimbot)

local Player = game.Players.LocalPlayer
local Aimbot = false

MainTab:AddToggle({
    Name = "Aimbot",
    Default = false,
    Callback = function(Value)
        Aimbot = Value
    end
})

game.Players.LocalPlayer.Character.Humanoid.Died:Connect(function()
    Aimbot = false
end)

game.Players.LocalPlayer.Backpack.Arsenal.Equipped:Connect(function(weapon)
    if Aimbot then
        local target = nil
        local closestDistance = math.huge

        for i, player in ipairs(game.Players:GetPlayers()) do
            if player ~= Player and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                local distance = (player.Character.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    target = player.Character.HumanoidRootPart
                end
            end
        end

        if target then
            local aimPos = CFrame.new(Player.Character.HumanoidRootPart.Position, target.Position)
            Player.Character.HumanoidRootPart.CFrame = aimPos
        end
    end
end)

-- NeverWin - Arsenal Script (Silent Aim)

local Player = game.Players.LocalPlayer
local SilentAim = false

MainTab:AddToggle({
    Name = "Silent Aim",
    Default = false,
    Callback = function(Value)
        SilentAim = Value
    end
})

game.Players.LocalPlayer.Character.Humanoid.Died:Connect(function()
    SilentAim = false
end)

game.Players.LocalPlayer.Backpack.Arsenal.Equipped:Connect(function(weapon)
    if SilentAim then
        local target = nil
        local closestDistance = math.huge

        for i, player in ipairs(game.Players:GetPlayers()) do
            if player ~= Player and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                local distance = (player.Character.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    target = player.Character.HumanoidRootPart
                end
            end
        end

        if target then
            local aimPos = CFrame.new(Player.Character.HumanoidRootPart.Position, target.Position)
            local mouse = Player:GetMouse()
            mouse.Target = aimPos.LookVector
        end
    end
end)

-- NeverWin - Arsenal Script (Team Check)

local Player = game.Players.LocalPlayer
local TeamCheck = false

MainTab:AddToggle({
    Name = "Team Check",
    Default = false,
    Callback = function(Value)
        TeamCheck = Value
    end
})

game.Players.LocalPlayer.Character.Humanoid.Died:Connect(function()
    TeamCheck = false
end)

game.Players.LocalPlayer.Backpack.Arsenal.Equipped:Connect(function(weapon)
    if TeamCheck then
        local target = nil
        local closestDistance = math.huge

        for i, player in ipairs(game.Players:GetPlayers()) do
            if player ~= Player and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                local distance = (player.Character.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance and player.Team ~= Player.Team then
                    closestDistance = distance
                    target = player.Character.HumanoidRootPart
                end
            end
        end

        if target then
            print("Closest enemy player is " .. target.Name)
        else
            print("No enemy players found")
        end
    end
end)



OrionLib:Init()
