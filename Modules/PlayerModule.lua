if PlayerModule_LOADED then
	return
end

pcall(function() getgenv().PlayerModule_LOADED = true end)

local PlayerModule = {}

-- // Variables
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local IYMouse = Players.LocalPlayer:GetMouse()

if getgenv().PlayerModule == nil then
	getgenv().PlayerModule = {
		WalkSpeed = 16,
		JumpPower = 50,
		NoClip = {
			Enabled = false
		},
		Flying = {
			Enabled = false,
			Method = "Normal",
			Speed = 1
		}
	}
end

local ss = getgenv().PlayerModule

function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

local Noclipping = nil
function PlayerModule:NoClipToggle(Value)
	if Value then
		Clip = false
		wait(0.1)
		local function NoclipLoop()
			if Clip == false and Players.LocalPlayer.Character ~= nil then
				for _, child in pairs(Players.LocalPlayer.Character:GetDescendants()) do
					if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
								child.CanCollide = false
					end
				end
			end
		end
		Noclipping = game:GetService('RunService').Stepped:Connect(NoclipLoop)
	else
		if Noclipping then
			Noclipping:Disconnect()
		end
		Clip = true
	end
end
local floatName = randomString()


function PlayerModule:JumpPower(Value)
	if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').UseJumpPower then
		Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').JumpPower = Value or ss.JumpPower
	else
		Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').JumpHeight  = Value or ss.JumpPower
	end
end

function PlayerModule:WalkSpeed(Value)
	Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').WalkSpeed = Value or ss.WalkSpeed
end

FLYING = false
QEfly = true
iyflyspeed = ss.Flying.Speed
vehicleflyspeed = 1
function sFLY(vfly)
	repeat wait() until Players.LocalPlayer and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	repeat wait() until IYMouse
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

	local T = getRoot(Players.LocalPlayer.Character)
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0
	
	local function FLY()
		FLYING = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		task.spawn(function()
			repeat wait()
				if not vfly and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
					Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
			until not FLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
				Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
		end)
	end
	flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 's' then
			CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'a' then
			CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'd' then 
			CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
		elseif QEfly and KEY:lower() == 'e' then
			CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
		elseif QEfly and KEY:lower() == 'q' then
			CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
	flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		elseif KEY:lower() == 'e' then
			CONTROL.Q = 0
		elseif KEY:lower() == 'q' then
			CONTROL.E = 0
		end
	end)
	FLY()
end

function NOFLY()
	FLYING = false
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
		Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

CFspeed = ss.Flying.Speed
function cFLY(speaker)
	speaker.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
	local Head = speaker.Character:WaitForChild("Head")
	Head.Anchored = true
	CFloop = RunService.Heartbeat:Connect(function(deltaTime)
		local moveDirection = speaker.Character:FindFirstChildOfClass('Humanoid').MoveDirection * (CFspeed * deltaTime)
		local headCFrame = Head.CFrame
		local cameraCFrame = workspace.CurrentCamera.CFrame
		local cameraOffset = headCFrame:ToObjectSpace(cameraCFrame).Position
		cameraCFrame = cameraCFrame * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
		local cameraPosition = cameraCFrame.Position
		local headPosition = headCFrame.Position

		local objectSpaceVelocity = CFrame.new(cameraPosition, Vector3.new(headPosition.X, cameraPosition.Y, headPosition.Z)):VectorToObjectSpace(moveDirection)
		Head.CFrame = CFrame.new(headPosition) * (cameraCFrame - cameraPosition) * CFrame.new(objectSpaceVelocity)
	end)
end

function cNOFLY()
	if CFloop then
		CFloop:Disconnect()
		Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
		local Head = Players.LocalPlayer.Character:WaitForChild("Head")
		Head.Anchored = false
	end
end

local flyjump
function jFLY()
	if flyjump then flyjump:Disconnect() end
	flyjump = UserInputService.JumpRequest:Connect(function(Jump)
		Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
	end)
end

function jNOFLY()
	if flyjump then flyjump:Disconnect() end
end

FlyStatus = nil
FlyMethod = "Normal"
function PlayerModule:FlyToggle(Value)
	if Value then
		FlyStatus = true
		if FlyMethod == "Normal" then
			NOFLY()
			wait()
			sFLY()
		elseif FlyMethod == "CFrame" then
			cFLY(Players.LocalPlayer)
		elseif FlyMethod == "Jump" then
			jFLY()
		end
	else
		FlyStatus = false
		if FlyMethod == "Normal" then
			NOFLY()
		elseif FlyMethod == "CFrame" then
			cNOFLY()
		elseif FlyMethod == "Jump" then
			jNOFLY()
		end
	end
end

function PlayerModule:FlyMethod(method)
	if FlyStatus ~= nil and FlyStatus == true then
		PlayerModule:FlyToggle(false)
		if method == "Normal" then
			FlyMethod = method
		elseif method == "CFrame" then
			FlyMethod = method
		elseif method == "Jump" then
			FlyMethod = method
		end
		wait(0.4)
		PlayerModule:FlyToggle(true)
	end
	if method == "Normal" then
		FlyMethod = method
	elseif method == "CFrame" then
		FlyMethod = method
	elseif method == "Jump" then
		FlyMethod = method
	end
end

function PlayerModule:FlySpeed(Value)
	iyflyspeed = Value
	CFspeed = Value
end

PlayerModule.Functions = {}

function PlayerModule.Functions:Get()
	if type == "Other" then
		return ss[option]
	end
	return ss[type][option]
end

function PlayerModule.Functions:Set(type, option, value)
	if type == "Other" then
		ss[option] = value
	end
	ss[type][option] = value
end

return PlayerModule
