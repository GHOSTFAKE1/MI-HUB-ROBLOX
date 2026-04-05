-- // GHOST FAKE - STYLE CYBER // --

-- NOTIFICACION
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "✓ CARGADO",
        Text = "GHOST FAKE 💀",
        Duration = 3
    })
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

-- SONIDO
local openSound = Instance.new("Sound", SoundService)
openSound.SoundId = "rbxassetid://9118828565"
openSound.Volume = 2

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- BOTON FLOTANTE
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0,55,0,55)
toggle.Position = UDim2.new(0,15,0,200)
toggle.BackgroundColor3 = Color3.fromRGB(10,10,10)
toggle.BackgroundTransparency = 0.2
toggle.Text = "🌑"
toggle.TextScaled = true
toggle.Draggable = true
toggle.Font = Enum.Font.GothamBold

local toggleCorner = Instance.new("UICorner", toggle)
toggleCorner.CornerRadius = UDim.new(0,12)

local toggleStroke = Instance.new("UIStroke", toggle)
toggleStroke.Thickness = 2
toggleStroke.Color = Color3.fromRGB(0,170,255)

-- MENU PRINCIPAL
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,280,0,380)
main.Position = UDim2.new(0.5,-140,0.5,-190)
main.BackgroundColor3 = Color3.fromRGB(15,15,25)
main.BackgroundTransparency = 0.35 -- TRANSPARENCIA
main.Visible = false
main.Draggable = true
main.ClipsDescendants = true

-- BORDE BRILLOSO AZUL
local outline = Instance.new("UIStroke", main)
outline.Thickness = 2.5
outline.Color = Color3.fromRGB(0,200,255)

-- ESQUINAS REDONDEADAS
local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0,12)

-- GRADIENTE DE FONDO
local gradient = Instance.new("UIGradient", main)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
gradient.Rotation = 45
gradient.Transparency = NumberSequence.new(0.85)

-- ABRIR AUTO
task.delay(2,function()
    main.Visible = true
    openSound:Play()
end)

toggle.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
    if main.Visible then openSound:Play() end
end)

-- TITULO
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,0)
title.Text = "🌑 GHOST FAKE 🌑"
title.BackgroundColor3 = Color3.fromRGB(0,0,0)
title.BackgroundTransparency = 0.5
title.TextColor3 = Color3.fromRGB(0,200,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- TABS
local tabs = {"COMBAT","VISUAL","STATS","OTROS"}
local frames = {}

for i,v in pairs(tabs) do
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(0.25,0,0,30)
    b.Position = UDim2.new((i-1)*0.25,0,0,40)
    b.Text = v
    b.BackgroundColor3 = Color3.fromRGB(0,0,0)
    b.BackgroundTransparency = 0.6
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 13

    local tabCorner = Instance.new("UICorner", b)
    tabCorner.CornerRadius = UDim.new(0,5)

    frames[v] = Instance.new("Frame", main)
    frames[v].Size = UDim2.new(1,0,0.70,0)
    frames[v].Position = UDim2.new(0,0,0,72)
    frames[v].BackgroundTransparency = 1
    frames[v].Visible = false

    b.MouseButton1Click:Connect(function()
        for _,f in pairs(frames) do f.Visible=false end
        frames[v].Visible=true
    end)
end

frames["COMBAT"].Visible = true

-- FUNCION BOTON
local function btn(parent,text,y,func)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0.92,0,0,30)
    b.Position = UDim2.new(0.04,0,0,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(0,30,60)
    b.BackgroundTransparency = 0.4
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    local btnCorner = Instance.new("UICorner", b)
    btnCorner.CornerRadius = UDim.new(0,6)
    b.MouseButton1Click:Connect(func)
end

-- VARIABLES
local speed=16
local jump=50
local voice=false
local espEnabled=false

-- ======== COMBAT ========
local y=10

btn(frames["COMBAT"],"⚡ Velocidad +",y,function()
    speed = math.min(speed+5,120)
    if LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.WalkSpeed = speed
    end
end) y=y+35

btn(frames["COMBAT"],"⚡ Velocidad -",y,function()
    speed = math.max(speed-5,16)
    if LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.WalkSpeed = speed
    end
end) y=y+35

btn(frames["COMBAT"],"🦘 Salto +",y,function()
    jump = jump +15
    if LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.JumpPower = jump
    end
end) y=y+35

btn(frames["COMBAT"],"🦘 Salto -",y,function()
    jump = math.max(jump-15,50)
    if LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.JumpPower = jump
    end
end) y=y+35

btn(frames["COMBAT"],"🛡 Anti Caída",y,function()
    task.spawn(function()
        while true do
            task.wait(0.2)
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if LocalPlayer.Character.HumanoidRootPart.Position.Y < -100 then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,100,0)
                end
            end
        end
    end)
end)

-- COORDENADAS
local coords = Instance.new("TextLabel", frames["COMBAT"])
coords.Position = UDim2.new(0.04,0,0,y+40)
coords.Size = UDim2.new(0.92,0,0,25)
coords.BackgroundTransparency = 1
coords.TextColor3 = Color3.fromRGB(150,220,255)
coords.Font = Enum.Font.GothamBold
coords.Text = "📍 Cargando..."

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character then
        local p = LocalPlayer.Character.HumanoidRootPart.Position
        coords.Text = "📍 X:"..math.floor(p.X).." Y:"..math.floor(p.Y).." Z:"..math.floor(p.Z)
    end
end)

-- ======== VISUAL ========
btn(frames["VISUAL"],"👁 Activar ESP",10,function()
    espEnabled = not espEnabled
    if espEnabled then
        game.StarterGui:SetCore("SendNotification", {Text = "ESP ACTIVADO", Duration = 1})
    end
end)

btn(frames["VISUAL"],"💡 Modo Nocturno",45,function()
    game.Lighting.Brightness = 0.2
    game.Lighting.FogEnd = 10000
end)

btn(frames["VISUAL"],"☀️ Modo Diurno",80,function()
    game.Lighting.Brightness = 2
    game.Lighting.TimeOfDay = 14
end)

-- ======== STATS ========
local lblPlayers = Instance.new("TextLabel", frames["STATS"])
lblPlayers.Size = UDim2.new(0.9,0,0,30)
lblPlayers.Position = UDim2.new(0.05,0,0,10)
lblPlayers.BackgroundTransparency = 1
lblPlayers.TextColor3 = Color3.new(1,1,1)
lblPlayers.Font = Enum.Font.GothamBold
lblPlayers.Text = "👥 Jugadores: Cargando..."

local lblFPS = Instance.new("TextLabel", frames["STATS"])
lblFPS.Size = UDim2.new(0.9,0,0,30)
lblFPS.Position = UDim2.new(0.05,0,0,50)
lblFPS.BackgroundTransparency = 1
lblFPS.TextColor3 = Color3.new(1,1,1)
lblFPS.Font = Enum.Font.GothamBold
lblFPS.Text = "⚡ FPS: --"

-- ACTUALIZAR STATS
spawn(function()
    while wait(1) do
        lblPlayers.Text = "👥 Jugadores: "..#Players:GetPlayers()
    end
end)

local fps=0
RunService.RenderStepped:Connect(function()
    fps=fps+1
end)

while wait(1) do
    lblFPS.Text = "⚡ FPS: "..fps
    fps=0
end

-- ======== OTROS ========
btn(frames["OTROS"],"🔊 Efecto de Voz",10,function()
    local s = Instance.new("Sound", SoundService)
    s.SoundId = "rbxassetid://9120289495"
    s.Volume = 3
    s:Play()
end)

btn(frames["OTROS"],"🚪 Ir al Spawn",45,function()
    if LocalPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,50,0)
    end
end)

print("✅ GHOST FAKE CARGADO - ESTILO AZUL")
