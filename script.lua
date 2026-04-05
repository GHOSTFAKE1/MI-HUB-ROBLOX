local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

--------------------------------------------------
-- CONFIG
--------------------------------------------------

local aimbot = false
local esp = false
local follow = false
local fov = 60

--------------------------------------------------
-- GUI
--------------------------------------------------

local gui = Instance.new("ScreenGui", game.CoreGui)

-- BOTON LATERAL 💀
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0,60,0,60)
toggle.Position = UDim2.new(0,10,0.5,-30) -- LADO IZQUIERDO CENTRO
toggle.BackgroundColor3 = Color3.fromRGB(0,0,0)
toggle.Text = "💀"
toggle.TextScaled = true
toggle.Draggable = true

-- MENU GRANDE
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,450,0,420)
main.Position = UDim2.new(0.5,-225,0.5,-210)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
main.Visible = false

-- ANIMACION
local function openMenu()
	main.Visible = true
	main.Size = UDim2.new(0,0,0,0)
	TweenService:Create(main,TweenInfo.new(0.3),{Size=UDim2.new(0,450,0,420)}):Play()
end

local function closeMenu()
	local t = TweenService:Create(main,TweenInfo.new(0.3),{Size=UDim2.new(0,0,0,0)})
	t:Play()
	t.Completed:Wait()
	main.Visible = false
end

toggle.MouseButton1Click:Connect(function()
	if main.Visible then closeMenu() else openMenu() end
end)

--------------------------------------------------
-- TITULO
--------------------------------------------------

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,50)
title.Text = "GHOST FAKE 💀"
title.BackgroundColor3 = Color3.fromRGB(0,0,0)
title.TextColor3 = Color3.fromRGB(0,255,150)
title.TextScaled = true

--------------------------------------------------
-- TABS
--------------------------------------------------

local tabs = {"MAIN","ESP","INFO"}
local frames = {}

for i,v in pairs(tabs) do
	local b = Instance.new("TextButton", main)
	b.Size = UDim2.new(0.33,0,0,40)
	b.Position = UDim2.new((i-1)*0.33,0,0.12,0)
	b.Text = v
	b.BackgroundColor3 = Color3.fromRGB(30,30,30)

	frames[v] = Instance.new("Frame", main)
	frames[v].Size = UDim2.new(1,0,0.7,0)
	frames[v].Position = UDim2.new(0,0,0.25,0)
	frames[v].Visible = false

	b.MouseButton1Click:Connect(function()
		for _,f in pairs(frames) do f.Visible=false end
		frames[v].Visible=true
	end)
end

frames["MAIN"].Visible = true

--------------------------------------------------
-- FUNCION BOTON
--------------------------------------------------

local function btn(parent,text,y,callback)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.new(0.9,0,0,35)
	b.Position = UDim2.new(0.05,0,0,y)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(40,40,40)
	b.TextColor3 = Color3.fromRGB(0,255,150)
	b.MouseButton1Click:Connect(callback)
end

--------------------------------------------------
-- MAIN TAB
--------------------------------------------------

local y = 10

btn(frames["MAIN"],"🎯 AIMBOT NPC",y,function()
	aimbot = not aimbot
end)
y=y+45

btn(frames["MAIN"],"🧲 AUTO FOLLOW",y,function()
	follow = not follow
end)
y=y+45

--------------------------------------------------
-- ESP TAB
--------------------------------------------------

btn(frames["ESP"],"🧿 ESP ON/OFF",10,function()
	esp = not esp
end)

--------------------------------------------------
-- INFO TAB
--------------------------------------------------

local info = Instance.new("TextLabel", frames["INFO"])
info.Size = UDim2.new(1,0,0,40)

--------------------------------------------------
-- SLIDER FOV
--------------------------------------------------

local label = Instance.new("TextLabel", frames["MAIN"])
label.Position = UDim2.new(0,0,0,120)
label.Size = UDim2.new(1,0,0,20)
label.Text = "FOV: "..fov

local bar = Instance.new("Frame", frames["MAIN"])
bar.Position = UDim2.new(0.05,0,0,150)
bar.Size = UDim2.new(0.9,0,0,10)
bar.BackgroundColor3 = Color3.fromRGB(60,60,60)

local fill = Instance.new("Frame", bar)
fill.Size = UDim2.new(0.3,0,1,0)
fill.BackgroundColor3 = Color3.fromRGB(0,255,150)

local dragging = false

bar.InputBegan:Connect(function(i)
	if i.UserInputType.Name=="MouseButton1" then dragging=true end
end)

bar.InputEnded:Connect(function()
	dragging=false
end)

--------------------------------------------------
-- SISTEMA
--------------------------------------------------

RunService.RenderStepped:Connect(function()

	local char = LocalPlayer.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end

	-- FOV slider
	if dragging then
		local m = LocalPlayer:GetMouse()
		local pos = math.clamp((m.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
		fill.Size = UDim2.new(pos,0,1,0)
		fov = math.floor(10 + (200-10)*pos)
		label.Text = "FOV: "..fov
	end

	-- INFO
	local pos = char.HumanoidRootPart.Position
	info.Text = "Players: "..#Players:GetPlayers()..
	" | X:"..math.floor(pos.X).." Y:"..math.floor(pos.Y)

	local closest = nil
	local dist = fov

	for _,v in pairs(workspace:GetChildren()) do
		if v.Name=="Dummy" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then

			local mag = (v.HumanoidRootPart.Position - pos).Magnitude

			if mag < dist then
				dist = mag
				closest = v
			end

			-- ESP
			if esp and not v:FindFirstChild("ESP") then
				local bill = Instance.new("BillboardGui", v)
				bill.Name = "ESP"
				bill.Size = UDim2.new(0,100,0,40)
				bill.AlwaysOnTop = true

				local txt = Instance.new("TextLabel", bill)
				txt.Size = UDim2.new(1,0,1,0)
				txt.Text = v.Name
				txt.TextColor3 = Color3.fromRGB(255,0,0)
				txt.BackgroundTransparency = 1
			end
		end
	end

	-- AIMBOT
	if aimbot and closest then
		local cam = workspace.CurrentCamera
		cam.CFrame = CFrame.new(cam.CFrame.Position, closest.HumanoidRootPart.Position)
	end

	-- FOLLOW
	if follow and closest then
		char.HumanoidRootPart.CFrame =
		closest.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
	end

end)
