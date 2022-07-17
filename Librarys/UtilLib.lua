local orionRepo = 'https://raw.githubusercontent.com/shlexware/Orion/main/'
local OrionLib = loadstring(game:HttpGet((orionRepo .. 'source')))()

local UtilsLib = {}

-- // Version
UtilsLib.Version = '1.0.0'

-- // Services
UtilsLib.Players = game:GetService("Players")
UtilsLib.ReplicatedStorage = game:GetService("ReplicatedStorage")
UtilsLib.RunService = game:GetService("RunService")
UtilsLib.UserInputService = game:GetService("UserInputService")
UtilsLib.TweenService = game:GetService("TweenService")

-- // Variables
UtilsLib.Player = UtilsLib.Players.LocalPlayer
UtilsLib.Character = UtilsLib.Player.Character
UtilsLib.Humanoid = UtilsLib.Character:FindFirstChild("Humanoid")
UtilsLib.HRP = UtilsLib.Character:FindFirstChild("HumanoidRootPart")
UtilsLib.Camera = workspace.CurrentCamera
UtilsLib.CoreGui = game:GetService("CoreGui")
UtilsLib.PlayerCount = tostring(#UtilsLib.Players:GetPlayers())
UtilsLib.FOV = UtilsLib.Camera.FieldOfView
UtilsLib.UserId = UtilsLib.Player.UserId
UtilsLib.Mouse = UtilsLib.Player:GetMouse()
UtilsLib.Displayname = UtilsLib.Player.DisplayName
UtilsLib.Username = UtilsLib.Player.Name
UtilsLib.Age = UtilsLib.Player.AccountAge
UtilsLib.TeamColor = UtilsLib.Player.TeamColor
if UtilsLib.Humanoid ~= nil then
    UtilsLib.Health = UtilsLib.Humanoid.Health
    UtilsLib.State = UtilsLib.Humanoid:GetState()
    UtilsLib.WalkSpeed = UtilsLib.Humanoid.WalkSpeed
    UtilsLib.JumpPower = UtilsLib.Humanoid.JumpPower
    UtilsLib.MaxHealth = UtilsLib.Humanoid.MaxHealth
end

UtilsLib.Icons = {
	TabIcons = {
		Home = "rbxassetid://9792650361",
		Aimbot = "rbxassetid://9792632523",
		Visuals = "rbxassetid://9792631281",
		Player = "rbxassetid://9792631906",
		Misc = "rbxassetid://9792634811",
		Settings = "rbxassetid://9792633222",
		Credits = "rbxassetid://9792634075",
		Exit = "rbxassetid://9792635572"
	},
	NotificationIcons = {
		Success = "rbxassetid://9838874163",
		Warning = "rbxassetid://9838873385",
		Error = "rbxassetid://9838876113",
		Informational = "rbxassetid://9838877673",
		Custom = "rbxassetid://9838878267"
	},
	NowaLogo = "rbxassetid://10006089373"
}

UtilsLib.Uptime = {
    Days = math.floor( elapsedTime() / 86400 ),
    Hours = math.floor( elapsedTime() / 3600 ),
    Minutes = math.floor( elapsedTime() / 60 ),
    Seconds = math.floor( elapsedTime() ),
    Formatted = string.format( "%02dd:%02dh:%02dm:%02ds", math.floor( elapsedTime() / 86400 % 24 ),  math.floor( elapsedTime() / 3600 % 60 ), math.floor( elapsedTime() / 60 % 60 ), math.floor( elapsedTime() % 60 ) )
}

UtilsLib.Stats = {
    FPS = 60,
    Memory = math.round(game:GetService('Stats'):GetTotalMemoryUsageMb()),
    Ping = math.round(tonumber(string.split(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString(), ' ')[1]))
}

UtilsLib.RunService.RenderStepped:Connect(function (delta)
    -- // Stats Refresh
    UtilsLib.Stats.FPS = math.round(1 / delta)
    UtilsLib.Stats.Memory = math.round(game:GetService('Stats'):GetTotalMemoryUsageMb())
    UtilsLib.Stats.Ping = math.round(tonumber(string.split(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString(), ' ')[1]))
end)

task.spawn(function()
    while task.wait() do
        -- // Variables Refresh
    UtilsLib.Player = UtilsLib.Players.LocalPlayer
    UtilsLib.Character = UtilsLib.Player.Character
    UtilsLib.Humanoid = UtilsLib.Character:FindFirstChildWhichIsA("Humanoid")
    UtilsLib.HRP = UtilsLib.Character:FindFirstChild("HumanoidRootPart")
    UtilsLib.Camera = workspace.CurrentCamera
    UtilsLib.CoreGui = game:GetService("CoreGui")
    UtilsLib.PlayerCount = tostring(#UtilsLib.Players:GetPlayers())
    UtilsLib.FOV = UtilsLib.Camera.FieldOfView
    UtilsLib.UserId = UtilsLib.Player.UserId
    UtilsLib.Mouse = UtilsLib.Player:GetMouse()
    UtilsLib.Displayname = UtilsLib.Player.DisplayName
    UtilsLib.Username = UtilsLib.Player.Name
    UtilsLib.Age = UtilsLib.Player.AccountAge
    UtilsLib.TeamColor = UtilsLib.Player.TeamColor
    if UtilsLib.Humanoid ~= nil then
        UtilsLib.Health = UtilsLib.Humanoid.Health
        UtilsLib.State = UtilsLib.Humanoid:GetState()
        UtilsLib.WalkSpeed = UtilsLib.Humanoid.WalkSpeed
        UtilsLib.JumpPower = UtilsLib.Humanoid.JumpPower
        UtilsLib.MaxHealth = UtilsLib.Humanoid.MaxHealth
    end
    -- // Uptime Refresh
    UtilsLib.Uptime.Days = math.floor( elapsedTime() / 86400 )
    UtilsLib.Uptime.Hours = math.floor( elapsedTime() / 3600 )
    UtilsLib.Uptime.Minutes = math.floor( elapsedTime() / 60 )
    UtilsLib.Uptime.Seconds = math.floor( elapsedTime() )
    UtilsLib.Uptime.Formatted = string.format( "%02dd:%02dh:%02dm:%02ds", math.floor( elapsedTime() / 86400 % 24 ),  math.floor( elapsedTime() / 3600 % 60 ), math.floor( elapsedTime() / 60 % 60 ), math.floor( elapsedTime() % 60 ) )
    end
end)

-- // Functions
local function UtilsLib:Log(type, message, title, time)
    if type == "info" then
		OrionLib:MakeNotification({
			Name = title or "[Utility] INFO: ",
			Content = tostring(message),
			Image = UtilsLib.NotificationIcons.Informational,
			Time = tonumber(time) or 5
		})
    elseif type == "warn" then
		OrionLib:MakeNotification({
			Name = title or "[Utility] WARNING: ",
			Content = tostring(message),
			Image = UtilsLib.NotificationIcons.Warning,
			Time = tonumber(time) or 5
		})
    elseif type == "error" then
		OrionLib:MakeNotification({
			Name = title or "[Utility] ERROR: ",
			Content = tostring(message),
			Image = UtilsLib.NotificationIcons.Error,
			Time = tonumber(time) or 5
		})
    end
end

function UtilsLib:LoadUrl(url)
    return loadstring(game:HttpGet(url))()
end

function UtilsLib:Try(func, name, verbose)
    local success, err = pcall(function() func() end)
    if not success and verbose then
        UtilsLib:Log("error", string.format('Function "%s" failed to run, Error: %s', name, err))
    elseif success and verbose then
        UtilsLib:Log("info", string.format('Function "%s" ran successfully!', name))
    end
end

function UtilsLib:GetExecutor()
    local exploit =
    (syn and syn.protect_gui and not getexecutorname and not is_sirhurt_closure and not pebc_execute and "Synapse X") or
    (getexecutorname and identifyexecutor and gethui and "ScriptWare") or
    (secure_load and "Sentinel") or
    (is_sirhurt_closure and "Sirhurt") or
    (pebc_execute and "ProtoSmasher") or
    (KRNL_LOADED and "Krnl") or
    (WrapGlobal and "WeAreDevs") or
    (isvm and "Proxo") or
    (shadow_env and "Shadow") or
    (jit and "EasyExploits") or
    (getreg()['CalamariLuaEnv'] and "Calamari") or
    (unit and "Unit") or
    (IS_VIVA_LOADED and "VIVA") or
    (IS_COCO_LOADED and "Coco") or
    ("Undetectable")
    return exploit
end

if not getgenv().isUtilsLibLive then 
    getgenv().isUtilsLibLive = true
end

return UtilsLib;
