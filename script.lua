local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "GhostPanel"

-- BOTÓN FLOTANTE
local open = Instance.new("TextButton", gui)
open.Size = UDim2.new(0,50,0,50)
open.Position = UDim2.new(0,10,0.5,-25)
open.Text = "≡"
open.BackgroundColor3 = Color3.fromRGB(0,170,255)
open.BackgroundTransparency = 0.2
open.TextColor3 = Color3.fromRGB(0,0,0)

-- PANEL
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,260,0,360)
frame.Position = UDim2.new(0.5,-130,0.5,-180)
frame.BackgroundColor3 = Color3.fromRGB(0,170,255)
frame.BackgroundTransparency = 0.35
frame.BorderSizePixel = 0
frame.Visible = false

-- BOTÓN CERRAR
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(255,50,50)
close.TextColor3 = Color3.fromRGB(255,255,255)

-- TÍTULO
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.Text = "GHOST PANEL"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextScaled = true

-- CREAR BOTONES
local function createBtn(text, y)
	local b = Instance.new("TextButton", frame)
	b.Size = UDim2.new(0,220,0,40)
	b.Position = UDim2.new(0,20,0,y)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(0,120,200)
	b.BackgroundTransparency = 0.2
	b.TextColor3 = Color3.fromRGB(255,255,255)
	return b
end

local btnESP = createBtn("ESP OFF", 60)
local btnJump = createBtn("SUPER JUMP OFF", 110)
local btnSpeed = createBtn("SPEED OFF", 160)
local btnSpin = createBtn("SPIN OFF", 210)

-- INFO ABAJO
local info = Instance.new("TextLabel", frame)
info.Size = UDim2.new(1,0,0,60)
info.Position = UDim2.new(0,0,1,-60)
info.BackgroundTransparency = 1
info.TextColor3 = Color3.fromRGB(255,255,255)
info.TextScaled = true

-- ABRIR / CERRAR
open.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

close.MouseButton1Click:Connect(function()
	frame.Visible = false
end)

-- VARIABLES
local espOn = false
local jumpOn = false
local speedOn = false
local spinOn = false
local highlights = {}

-- ESP
local function addESP(p)
	if p ~= player and p.Character then
		local h = Instance.new("Highlight")
		h.FillColor = Color3.fromRGB(0,170,255)
		h.OutlineColor = Color3.fromRGB(255,255,255)
		h.Parent = p.Character
		highlights[p] = h
	end
end

local function removeESP()
	for _,h in pairs(highlights) do
		if h then h:Destroy() end
	end
	highlights = {}
end

btnESP.MouseButton1Click:Connect(function()
	espOn = not espOn
	btnESP.Text = espOn and "ESP ON" or "ESP OFF"

	if espOn then
		for _,p in pairs(Players:GetPlayers()) do
			addESP(p)
		end
	else
		removeESP()
	end
end)

-- JUMP
btnJump.MouseButton1Click:Connect(function()
	jumpOn = not jumpOn
	btnJump.Text = jumpOn and "SUPER JUMP ON" or "OFF"

	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.JumpPower = jumpOn and 100 or 50
	end
end)

-- SPEED
btnSpeed.MouseButton1Click:Connect(function()
	speedOn = not speedOn
	btnSpeed.Text = speedOn and "SPEED ON" or "OFF"

	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = speedOn and 50 or 16
	end
end)

-- SPIN
btnSpin.MouseButton1Click:Connect(function()
	spinOn = not spinOn
	btnSpin.Text = spinOn and "SPIN ON" or "OFF"
end)

RunService.RenderStepped:Connect(function(dt)
	-- SPIN
	if spinOn and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local hrp = player.Character.HumanoidRootPart
		hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(5), 0)
	end

	-- FPS
	local fps = math.floor(1/dt)

	-- ACTIVOS
	local activos = #Players:GetPlayers()

	info.Text = "👤 "..player.Name.." | FPS: "..fps.." | ACTIVE: "..activos
end)

-- RESPAWN
player.CharacterAdded:Connect(function(char)
	local hum = char:WaitForChild("Humanoid")

	if jumpOn then hum.JumpPower = 100 end
	if speedOn then hum.WalkSpeed = 50 end
end)
