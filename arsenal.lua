if game.PlaceId == "286090429" then

    -- Booting up the library
    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

    -- Creating a window
    local Window = OrionLib:MakeWindow({Name = "NeverWin - Arsenal", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
            Name = "NeverWin Arsenal",
            IntroEnabled = "True",
            IntroText = "NeverWin Arsenal",
            IntroIcon = "https://i.ibb.co/WyQcqLW/B11-EAE04-032-E-4-DB9-9-B11-125-FDAE006-EE.jpg",
            Icon = "https://i.ibb.co/WyQcqLW/B11-EAE04-032-E-4-DB9-9-B11-125-FDAE006-EE.jpg",

    local CombatTab = Window:MakeTab({
                Name = "Combat",
                Icon = "rbxassetid://4483345998",
                PremiumOnly = false
            })

    local Section = CombatTab:AddSection({
                Name = "Aim"
            })
            
    -- function and values for aimbot
    -- Define a function that takes a player as input and returns a function as output
local function createAimbot(player)
    -- Define a function that will be used to aim at the target
    local function aimAtTarget(target)
        -- Get the position of the target
        local targetPosition = target.Position

        -- Get the position of the player's character
        local character = player.Character
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local playerPosition = humanoidRootPart.Position

        -- Calculate the direction to the target
        local direction = (targetPosition - playerPosition).Unit

        -- Set the player's character's look direction
        humanoidRootPart.LookDirection = direction
    end

    -- Define a function that will be used to check if the aimbot should be enabled
    local function shouldEnableAimbot()
        -- Check if the player is on a PC
        if player.Keyboard then
            -- Check if the player is holding down the right mouse button
            return player.Keyboard.RightMouseButtonDown
        else
            -- Check if the player is on a mobile device
            if player.TouchEnabled then
                -- Check if the player is touching the screen
                return player.TouchEnabled.TouchCount > 0
            end
        end

        -- If none of the above conditions are met, return false
        return false
    end

    -- Define a function that will be used to enable or disable the aimbot
    local function toggleAimbot()
        -- Check if the aimbot should be enabled
        if shouldEnableAimbot() then
            -- Enable the aimbot
            print("Aimbot enabled")

            -- Get the current target
            local target = game.Players.LocalPlayer.Character.HumanoidRootPart

            -- Aim at the target
            aimAtTarget(target)
        else
            -- Disable the aimbot
            print("Aimbot disabled")
        end
    end

    -- Return the function that will be used to enable or disable the aimbot
    return toggleAimbot
end

-- Use a remote event to allow users to send code to the executor
local remoteEvent = Instance.new("RemoteEvent")
remoteEvent.Name = "ExecuteCode"
remoteEvent.Parent = game.ReplicatedStorage

-- Connect the remote event to the executor
remoteEvent.OnServerEvent:Connect(function(player, code)
    -- Create a new instance of the executor
    local executor = createAimbot(player)

    -- Execute the code
    executor()
end

-- Add a toggle to the CombatTab
CombatTab:AddToggle({
    Name = "Aimbot",
    Default = false,
    Callback = function(Value)
        -- Enable or disable the aimbot
        toggleAimbot()
    end
})

-- functions and values for silent aim
-- Define a function that takes a player as input and returns a function as output
local function createSilentAim(player)
    -- Define a function that will be used to aim at the target
    local function aimAtTarget(target)
        -- Get the position of the target
        local targetPosition = target.Position

        -- Get the position of the player's character
        local character = player.Character
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local playerPosition = humanoidRootPart.Position

        -- Calculate the direction to the target
        local direction = (targetPosition - playerPosition).Unit

        -- Set the player's character's look direction
        humanoidRootPart.LookDirection = direction

        -- Calculate the distance to the target
        local distance = (targetPosition - playerPosition).Magnitude

        -- Calculate the angle between the player's position and the target's position
        local angle = math.atan2(direction.Y, direction.X)

        -- Calculate the rotation of the player's character
        local rotation = math.rad(math.atan2(math.sin(angle), math.cos(angle)) * (180 / math.pi))

        -- Set the player's character's rotation
        character.HumanoidRootPart.Rotation = rotation

        -- Move the player's character towards the target
        character.Humanoid:MoveTo(targetPosition, distance)
    end

    -- Define a function that will be used to check if the silent aim should be enabled
    local function shouldEnableSilentAim()
        -- Check if the player is on a PC
        if player.Keyboard then
            -- Check if the player is holding down the left mouse button
            return player.Keyboard.LeftMouseButtonDown
        else
            -- Check if the player is on a mobile device
            if player.TouchEnabled then
                -- Check if the player is touching the screen
                return player.TouchEnabled.TouchCount > 0
            end
        end

        -- If none of the above conditions are met, return false
        return false
    end

    -- Define a function that will be used to enable or disable the silent aim
    local function toggleSilentAim()
        -- Check if the silent aim should be enabled
        if shouldEnableSilentAim() then
            -- Enable the silent aim
            print("Silent aim enabled")

            -- Get the current target
            local target = game.Players.LocalPlayer.Character.HumanoidRootPart

            -- Aim at the target
            aimAtTarget(target)
        else
            -- Disable the silent aim
            print("Silent aim disabled")
        end
    end

    -- Return the function that will be used to enable or disable the silent aim
    return toggleSilentAim
end

-- Use a remote event to allow users to send code to the executor
local remoteEvent = Instance.new("RemoteEvent")
remoteEvent.Name = "ExecuteCode"
remoteEvent.Parent = game.ReplicatedStorage

-- Connect the remote event to the executor
remoteEvent.OnServerEvent:Connect(function(player, code)
    -- Create a new instance of the executor
    local executor = createSilentAim(player)

    -- Execute the code
    executor()
end

-- Add a toggle to the CombatTab
CombatTab:AddToggle({
    Name = "Silent Aim",
    Default = false,
    Callback = function(Value)
        -- Enable or disable the silent aim
        toggleSilentAim()
    end
})

local Section = CombatTab:AddSection({
	Name = "Visuals"
})

OrionLib:Init()
