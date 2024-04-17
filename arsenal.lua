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

-- Local Player
local player = game.Players.LocalPlayer

-- Loop through all the guns in the player's backpack
for i, gun in ipairs(player.Backpack:GetChildren()) do
    -- Check if the gun has a "MaxPrimaryAmmo" property
    if gun:FindFirstChild("MaxPrimaryAmmo") then
        -- Set the gun's "Ammo" property to its "MaxPrimaryAmmo" property
        gun.Ammo = gun.MaxPrimaryAmmo.Value

        -- Connect the gun's "Reload" event to a function that resets the gun's ammo to its max
        gun.Reload:Connect(function()
            gun.Ammo = gun.MaxPrimaryAmmo.Value
        end)
    end
end

-- Connect to the player's "ChildAdded" event to check for new guns
player.Backpack.ChildAdded:Connect(function(child)
    -- Check if the new child is a gun
    if child:IsA("Model") and child:FindFirstChild("MaxPrimaryAmmo") then
        -- Set the gun's "Ammo" property to its "MaxPrimaryAmmo" property
        child.Ammo = child.MaxPrimaryAmmo.Value

        -- Connect the gun's "Reload" event to a function that resets the gun's ammo to its max
        child.Reload:Connect(function()
            child.Ammo = child.MaxPrimaryAmmo.Value
        end)
    end
end)

-- Add a toggle to the UI
MainTab:AddToggle({
    Name = "Infinite Ammo",
    Default = false,
    Callback = function(Value)
        -- If the toggle is on, set the gun's ammo to its max value
        if Value then
            for i, gun in ipairs(player.Backpack:GetChildren()) do
                if gun:FindFirstChild("MaxPrimaryAmmo") then
                    gun.Ammo = gun.MaxPrimaryAmmo.Value
                end
            end
        end
    end
})

-- NeverWin - Arsenal Script (Fast Fire Rate)

-- Local Player
local player = game.Players.LocalPlayer

-- Loop through all the guns in the player's backpack
for i, gun in ipairs(player.Backpack:GetChildren()) do
    -- Check if the gun has a "FireRate" property
    if gun:FindFirstChild("FireRate") then
        -- Set the gun's "FireRate" property to a very fast value
        gun.FireRate = 0.05
    end
end

-- Connect to the player's "ChildAdded" event to check for new guns
player.Backpack.ChildAdded:Connect(function(child)
    -- Check if the new child is a gun
    if child:IsA("Model") then
        -- Check if the gun has a "FireRate" property
        if child:FindFirstChild("FireRate") then
            -- Set the gun's "FireRate" property to a very fast value
            child.FireRate = 0.05
        end
    end
end)

-- Add a toggle to the UI
MainTab:AddToggle({
    Name = "Fast Fire Rate",
    Default = false,
    Callback = function(Value)
        -- If the toggle is on, set the gun's fire rate to a very fast value
        if Value then
            for i, gun in ipairs(player.Backpack:GetChildren()) do
                if gun:FindFirstChild("FireRate") then
                    gun.FireRate = 0.05
                end
            end
        end
    end
})

-- NeverWin - Arsenal Script (Rainbow Gun)

-- Local Player
local player = game.Players.LocalPlayer

-- Create a rainbow material
local rainbowMaterial = Instance.new("Material")
rainbowMaterial.Name = "Rainbow"
rainbowMaterial.Parent = game.CoreGui
rainbowMaterial.Texture = "http://www.roblox.com/asset/?id=3270111"
rainbowMaterial.Color = Color3.fromRGB(255, 0, 0)
rainbowMaterial.Parent = game.CoreGui

-- Create a function that updates the rainbow material's color
local function updateRainbowColor()
    local hue = tick() % 1
    local r, g, b = Color3.fromHSV(hue, 1, 1)
    rainbowMaterial.Color = Color3.new(r, g, b)
end

-- Connect the "Ticked" event to the updateRainbowColor function
game:GetService("RunService").Heartbeat:Connect(updateRainbowColor)

-- Add a toggle to the UI
MainTab:AddToggle({
    Name = "Rainbow Gun",
    Default = false,
    Callback = function(Value)
        -- If the toggle is on, apply the rainbow material to the player's gun mesh
        if Value then
            for i, gun in ipairs(player.Backpack:GetChildren()) do
                if gun:FindFirstChild("MainPart") then
                    local mesh = Instance.new("SpecialMesh")
                    mesh.MeshType = Enum.MeshType.Brick
                    mesh.Parent = gun.MainPart

                    -- Connect the "Ticked" event to a function that updates the gun's mesh material
                    game:GetService("RunService").Heartbeat:Connect(function()
                        mesh.Material = rainbowMaterial
                    end)
                end
            end
        end
    end
})

local MainSection = MainTab:AddSection({
	Name = "Aim Modifiers"
})

-- NeverWin - Arsenal Script (Silent Aim)

-- Local Player
local player = game.Players.LocalPlayer

-- Create a function that aims the player's camera at the nearest enemy
local function silentAim()
    local closestEnemy, closestDistance = nil, math.huge

    -- Loop through all the enemies in the game
    for i, enemy in ipairs(game.Workspace:GetDescendants()) do
        -- Check if the enemy is a humanoid
        if enemy:FindFirstChild("Humanoid") then
            -- Calculate the distance between the player and the enemy
            local distance = (enemy.PrimaryPart.Position - player.Character.PrimaryPart.Position).Magnitude

            -- Check if the enemy is closer than the current closest enemy
            if distance < closestDistance then
                -- Set the new closest enemy
                closestEnemy = enemy
                closestDistance = distance
            end
        end
    end

    -- Check if there is a valid enemy
    if closestEnemy then
        -- Calculate the direction to the enemy's head
        local headPosition = closestEnemy.Head.Position
        local direction = (headPosition - player.Character.Head.Position).Unit

        -- Set the camera's CFrame to look at the enemy's head
        player.Camera.CFrame = player.Camera.CFrame * CFrame.new(0, 0, -10) * CFrame.Angles(math.atan2(direction.x, direction.z), math.asin(direction.y), 0)
    end
end

-- Add a toggle to the UI
MainTab:AddToggle({
    Name = "Silent Aim",
    Default = false,
    Callback = function(Value)
        -- If the toggle is on, aim the player's camera at the nearest enemy
        if Value then
            while true do
                silentAim()
                wait(0.1)
            end
        end
    end
})

OrionLib:Init()
