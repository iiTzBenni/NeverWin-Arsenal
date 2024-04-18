if game.PLaceId == 286090429 then

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

local CombatTab = Window:MakeTab({
	Name = "Combat",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

-- inf ammo
local Player = game.Players.LocalPlayer
local InfiniteAmmo = false

CombatTab:AddButton({
    Name = "Infinite Ammo",
    Callback = function()
        InfiniteAmmo = true
		print("Infinite Ammo toggle on")
    end
})

game.Players.LocalPlayer.Backpack.Arsenal.Changed:Connect(function()
    if InfiniteAmmo then
        game.Players.LocalPlayer.Backpack.Arsenal.Ammo.Value = math.huge
    end
end)

game.Players.LocalPlayer.Backpack.Arsenal.Ammo.Changed:Connect(function()
    if InfiniteAmmo then
        game.Players.LocalPlayer.Backpack.Arsenal.Ammo.Value = math.huge
    end
end)

-- Silent aim
local Player = game.Players.LocalPlayer
local SilentAim = false

CombatTab:AddButton({
    Name = "Silent Aim",
    Callback = function()
        SilentAim = true
        print("Silent Aim toggle on")
    end
})

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

-- fov aimbot
local Player = game.Players.LocalPlayer
local FOVAimbot = false
local FOV = 90

Tab:AddButton({
    Name = "FOV Aimbot",
    Callback = function()
        FOVAimbot = true
        print("FOV Aimbot toggle on")
    end
})

game.Players.LocalPlayer.Backpack.Arsenal.Equipped:Connect(function(weapon)
    if FOVAimbot then
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
            local camera = game.Workspace.CurrentCamera
            local viewAngle = camera.FieldOfView
            local viewDistance = (camera.CFrame.LookVector * viewAngle / 2) / math.tan(math.rad(viewAngle / 2))
            local viewCenter = camera.CFrame.LookVector * viewDistance
            local viewCone = viewCenter + camera.CFrame.RightVector * FOV / 2 + camera.CFrame.UpVector * viewDistance
            local viewPlane = camera.CFrame.RightVector * FOV
            local viewPoint = viewCone - viewPlane
            local viewRay = camera.CFrame.LookVector * viewDistance
            local hit, position, normal, surface = workspace:FindPartOnRayWithIgnoreList(viewRay, {Player.Character, target})

            if hit and position and (position - viewPoint).Magnitude < viewDistance then
                mouse.Target = aimPos.LookVector
            end
        end
    end
end)

OrionLib:Init()
