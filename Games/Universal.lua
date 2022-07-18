local orionRepo = 'https://raw.githubusercontent.com/shlexware/Orion/main/'
local nowaRepo = 'https://raw.githubusercontent.com/NotKaskus/Nowa-Hub/main/'
local nowaV2Repo = 'https://raw.githubusercontent.com/NotKaskus/NowaHub-V2/main/'

local OrionLib = loadstring(game:HttpGet((orionRepo .. 'source')))()
local EspLib = loadstring(game:HttpGet(nowaRepo .. 'Resources/Lib/UniversalEsp.lua'))()
local AimbotLib = loadstring(game:HttpGet(nowaV2Repo .. 'Librarys/UniversalAimbot.lua'))()
local UtilsLib = loadstring(game:HttpGet(nowaV2Repo .. 'Librarys/UtilLib.lua'))()

local PlayerModule = loadstring(game:HttpGet(nowaV2Repo .. 'Modules/PlayerModule.lua'))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")
local IYMouse = LocalPlayer:GetMouse()
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

UtilsLib:SetLib(OrionLib)
local Window = OrionLib:MakeWindow({
	Name = "Nowa Hub",
	HidePremium = true,
	SaveConfig = true,
	ConfigFolder = "NowaHub",
	IntroText = "Nowa Hub"
})

local CombatTab = Window:MakeTab({ Name = "Combat", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local VisualTab = Window:MakeTab({ Name = "Visual", Icon = "rbxassetid://9792631281", PremiumOnly = false })
local PlayerTab = Window:MakeTab({ Name = "Player", Icon = "rbxassetid://9792631906", PremiumOnly = false })
local SettingsTab = Window:MakeTab({ Name = "Settings", Icon = "rbxassetid://9792633222", PremiumOnly = false })

local AimbotSection = CombatTab:AddSection({ Name = "Aimbot" })

AimbotSection:AddToggle({
	Name = "Team Check",
	Default = true,
	Callback = function(Value)
		AimbotLib:Set('Other', 'TeamCheck', Value)
	end    
})

AimbotSection:AddToggle({
	Name = "Potato Aim",
	Default = true,
	Callback = function(Value)
		AimbotLib:Set('Aimbot', 'Use_mousemoverel', Value)
	end    
})

AimbotSection:AddSlider({
	Name = "Aim Smoothness",
	Min = 0,
	Max = 200,
	Default = 100,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Smoothness",
	Callback = function(Value)
		AimbotLib:Set('Aimbot', 'Strength', Value)
	end    
})

AimbotSection:AddSlider({
	Name = "Max Distance",
	Min = 0,
	Max = 1000,
	Default = 500,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Distance",
	Callback = function(Value)
		AimbotLib:Set('Other', 'MaximumDistance', Value)
	end    
})

AimbotSection:AddDropdown({
	Name = "Target Part",
	Default = "Head",
	Options = {"Head"},
	Callback = function(Value)
		AimbotLib:Set('Aimbot', 'TargetPart', Value)
	end    
})

local TriggerBotSection = CombatTab:AddSection({ Name = "Trigger Bot" })

TriggerBotSection:AddToggle({
	Name = "Toggle TriggerBot",
	Default = false,
	Callback = function(Value)
		AimbotLib:Set('TriggerBot', 'Enabled', Value)
	end    
})

TriggerBotSection:AddToggle({
	Name = "Spam",
	Default = false,
	Callback = function(Value)
		AimbotLib:Set('TriggerBot', 'Spam', Value)
	end    
})

TriggerBotSection:AddSlider({
	Name = "Click Per Second",
	Min = 1,
	Max = 150,
	Default = 10,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Click",
	Callback = function(Value)
		AimbotLib:Set('TriggerBot', 'ClicksPerSecond', Value)
	end    
})

TriggerBotSection:AddSlider({
	Name = "Delay",
	Min = 0,
	Max = 150,
	Default = 60,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Delay",
	Callback = function(Value)
		AimbotLib:Set('TriggerBot', 'Delay', Value)
	end    
})

VisualTab:AddButton({
	Name = "Fullbright",
	Default = false,
	Callback = function(Value)
		Lighting.Brightness = 2
		Lighting.ClockTime = 14
		Lighting.FogEnd = 100000
		Lighting.GlobalShadows = false
		Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
	end    
})

local EspSection = VisualTab:AddSection({ Name = "ESP" })

EspLib:Set('Tracers', 'Enabled', false)
EspLib:Set('Names', 'ShowDistance', true)

EspSection:AddToggle({
	Name = "Team Check",
	Default = true,
	Callback = function(Value)
		EspLib:Set('Other', 'TeamCheck', Value)
	end    
})

EspSection:AddToggle({
	Name = "Boxes",
	Default = false,
	Callback = function(Value)
		EspLib:Set('Boxes', 'Enabled', Value)
	end    
})

EspSection:AddToggle({
	Name = "Skeletons",
	Default = false,
	Callback = function(Value)
		EspLib:Set('HeadDots', 'Enabled', Value)
		EspLib:Set('Skeletons', 'Enabled', Value)
	end    
})

EspSection:AddToggle({
	Name = "Look Tracers",
	Default = false,
	Callback = function(Value)
		EspLib:Set('LookTracers', 'Enabled', Value)
	end    
})

EspSection:AddToggle({
	Name = "Names",
	Default = false,
	Callback = function(Value)
		EspLib:Set('Names', 'Enabled', Value)
	end    
})

EspSection:AddToggle({
	Name = "Health Bars",
	Default = false,
	Callback = function(Value)
		EspLib:Set('HealthBars', 'Enabled', Value)
	end    
})

EspSection:AddToggle({
	Name = "Rainbow Color",
	Default = false,
	Callback = function(Value)
		local ESP_RAINBOW = Value
		EspLib:Set('Boxes', 'RainbowColor', ESP_RAINBOW)
		EspLib:Set('Skeletons', 'RainbowColor', ESP_RAINBOW)
		EspLib:Set('HealthBars', 'RainbowColor', ESP_RAINBOW)
		EspLib:Set('LookTracers', 'RainbowColor', ESP_RAINBOW)
		EspLib:Set('Names', 'RainbowColor', ESP_RAINBOW)
		EspLib:Set('HeadDots', 'RainbowColor', ESP_RAINBOW)
	end    
})

EspSection:AddSlider({
	Name = "Max Distance",
	Min = 0,
	Max = 1000,
	Default = 500,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Distance",
	Callback = function(Value)
		EspLib:Set('Other', 'MaximumDistance', Value)
	end    
})

EspSection:AddColorpicker({
	Name = "ESP Color (Broken)",
	Default = Color3.fromRGB(255,255,255),
	Callback = function(Value)
		local ESP_COLOR = Value
		EspLib:Set('Boxes', 'Color', ESP_COLOR)
		EspLib:Set('Skeletons', 'Color', ESP_COLOR)
		EspLib:Set('HealthBars', 'Color', ESP_COLOR)
		EspLib:Set('LookTracers', 'Color', ESP_COLOR)
		EspLib:Set('Names', 'Color', ESP_COLOR)
		EspLib:Set('HeadDots', 'Color', ESP_COLOR)
	end	  
})

local TracerSection = VisualTab:AddSection({ Name = "Tracers" })

TracerSection:AddToggle({
	Name = "Tracers",
	Default = false,
	Callback = function(Value)
		EspLib:Set('Tracers', 'Enabled', Value)
	end    
})

TracerSection:AddToggle({
	Name = "Tracers Rainbow Color",
	Default = false,
	Callback = function(Value)
		EspLib:Set('Tracers', 'RainbowColor', Value)
	end    
})

TracerSection:AddDropdown({
	Name = "Tracer Origin",
	Default = "Bottom",
	Options = { 'Top', 'Center', 'Bottom', 'Mouse' },
	Callback = function(Value)
		EspLib:Set('Tracers', 'Origin', Value)
	end    
})

TracerSection:AddColorpicker({
	Name = "Tracer Color (Broken)",
	Default = Color3.fromRGB(255,255,255),
	Callback = function(Value)
		EspLib:Set('Tracers', 'Color', Value)
	end	  
})

local PlayerFlyingSection = PlayerTab:AddSection({ Name = "Flying" })

PlayerFlyingSection:AddToggle({
	Name = "Fly",
	Default = false,
	Callback = function(Value)
		PlayerModule:FlyToggle(Value)
	end    
})

local FlySpeedSlider = PlayerFlyingSection:AddSlider({
	Name = "Flying Speed",
	Min = 1,
	Max = 150,
	Default = 1,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		PlayerModule:FlySpeed(Value)
	end    
})

PlayerFlyingSection:AddDropdown({
	Name = "Fly Mode",
	Default = "Normal",
	Options = {"Normal", "CFrame", "Jump"},
	Callback = function(Value)
		if Value == "CFrame" then
			FlySpeedSlider:Set(50)
		end
		PlayerModule:FlyMethod(Value)
	end    
})

local PlayerBehaviorSection = PlayerTab:AddSection({ Name = "Behavior" })

PlayerBehaviorSection:AddToggle({
	Name = "No Clip",
	Default = false,
	Callback = function(Value)
		PlayerModule:NoClipToggle(Value)
	end    
})

PlayerBehaviorSection:AddSlider({
	Name = "Walk Speed",
	Min = 16,
	Max = 1000,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		PlayerModule:WalkSpeed(Value)
	end    
})

PlayerBehaviorSection:AddSlider({
	Name = "Jump Power",
	Min = 50,
	Max = 150,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		PlayerModule:JumpPower(Value)
	end    
})


SettingsTab:AddButton({
	Name = "Destroy GUI",
	Callback = function()
      	OrionLib:Destroy()
  	end    
})

local StatisticSection = SettingsTab:AddSection({ Name = "Statistics" })

local FpsLabel = StatisticSection:AddLabel("...")
local PingLabel = StatisticSection:AddLabel("...")
local MemoryLabel = StatisticSection:AddLabel("...")

local eva = true
coroutine.wrap(function()
    repeat
        wait(0.4)
		FpsLabel:Set('Average FPS: ' .. UtilsLib.Stats.FPS)
        PingLabel:Set('Average Ping: ' .. UtilsLib.Stats.Ping)
        MemoryLabel:Set('Average Memory Usage: ' .. UtilsLib.Stats.Memory)
    until not eva
end)()

OrionLib:Init()
