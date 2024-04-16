if game.PlaceID == "286090429" then
-- Booting up the library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Window
local Window = OrionLib:MakeWindow({Name = "NeverWin Hub - Arsenal", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
         Name = "Neverwin Arsenal",
         IntroText = "Neverwin - Best Scripts",
         IntroIcon = "https://ibb.co/pzg3GSv",
         Icon = "https://ibb.co/pzg3GSv",

OrionLib:MakeNotification({
	Name = "NeverWin Hub",
	Content = "Executed Successfully. Thanks for using",
	Image = "rbxassetid://4483345998",
	Time = 5
})

local CombatTab = Window:MakeTab({
	Name = "Combat",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = CombatTab:AddSection({
	Name = "Aim"
})

-- Values
local CombatTab = script.Parent
local AIMBOT_ENABLED = false

-- Function
local function Aimbot()
    local target = GetNearestPlayer()

    if target then
        local targetCharacter = target.Character
        local targetHumanoidRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
        local targetAimPart = targetCharacter:FindFirstChild("Head")

        if targetAimPart then
            Humanoid.MoveTo(targetAimPart.Position)
            Humanoid.MoveToFinished:Wait()
            Humanoid.MoveTo(targetHumanoidRootPart.Position)
        end
    end
end

CombatTab:AddToggle({
	Name = "Aimbot", -- Name of the toggle
	Default = false, -- Default value of the toggle
	Callback = function(Value) -- Callback function when the toggle is changed
		AIMBOT_ENABLED = Value
		if AIMBOT_ENABLED then
			game:GetService("RunService").Heartbeat:Connect(function()
				Aimbot()
			end)
		else
			game:GetService("RunService").Heartbeat:Disconnect()
		end
	end    
})


end
OrionLib:Init()