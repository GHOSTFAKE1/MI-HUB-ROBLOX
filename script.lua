--// GHOST SIMPLE FUNCIONAL 💀

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- GUI SEGURA (SIEMPRE APARECE)
local gui = Instance.new("ScreenGui")
gui.Name = "GhostMenu"
gui.ResetOnSpawn = false

pcall(function()
    gui.Parent = game.CoreGui
end)

-- BOTÓN FLOTANTE
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0,60,0,60)
toggle.Position = UDim2.new(0,20,0,200)
toggle.Text = "💀"
toggle.TextScaled = true
toggle.BackgroundColor3 = Color3.fromRGB(0,0,0)
toggle.TextColor3 = Color3.fromRGB(0,255,255)

-- MENU
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,260,0,350)
frame.Position = UDim2.new(0,100,0,150)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Visible = false

-- TITULO
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.Text = "💀 GHOST MENU"
title.BackgroundColor3 = Color3.fromRGB(0,0,0)
title.TextColor3 = Color3.fromRGB(0,255,255)

-- FUNCION BOTON
local function createBtn(text,y,callback)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(0.9,0,0,35)
    b.Position = UDim2.new(0.05,0,0,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(0,40,80)
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.MouseButton1Click:Connect(callback)
end

-- VARIABLES
local speed = false
local jump = false
local spin = false
local god = false

-- BOTONES
createBtn("⚡ SPEED",50,function()
    speed = not speed
end)

createBtn("🦘 SUPER JUMP",90,function()
    jump = not jump
end)

createBtn("🌀 SPIN",130,function()
    spin = not spin
end)

createBtn("🛡️ GOD MODE",170,function()
    god = not god
end)

createBtn("🔄 RESET",210,function()
    LocalPlayer.Character.Humanoid.Health = 0
end)

createBtn("🌙 NIGHT",250,function()
    game.Lighting.TimeOfDay = "00:00:00"
end)

createBtn("🌞 DAY",290,function()
    game.Lighting.TimeOfDay = "14:00:00"
end)

-- ABRIR MENU
toggle.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- LOOP FUNCIONES
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        
        if speed then
            char.Humanoid.WalkSpeed = 50
        else
            char.Humanoid.WalkSpeed = 16
        end
        
        if jump then
            char.Humanoid.JumpPower = 100
        else
            char.Humanoid.JumpPower = 50
        end
        
        if god then
            char.Humanoid.Health = char.Humanoid.MaxHealth
        end
        
        if spin and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame *= CFrame.Angles(0,math.rad(10),0)
        end
        
    end
end)
