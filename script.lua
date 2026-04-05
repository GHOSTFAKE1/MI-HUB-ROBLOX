-- // GHOST FAKE LOGIN + MENU COMPLETO // --

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

-- 🔑 CONFIG
local PASSWORD = "GHOSTFAKE-172816381"
local WA_LINK = "https://whatsapp.com/channel/0029VbCz7YTJkK7FktLjmn2K"

-- SONIDO
local openSound = Instance.new("Sound", SoundService)
openSound.SoundId = "rbxassetid://9118828565"
openSound.Volume = 2

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "GhostFakeUI"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

pcall(function()
    gui.Parent = game.CoreGui
end)
if not gui.Parent then
    gui.Parent = LocalPlayer.PlayerGui
end

-- =========================================
-- 🔐 LOGIN
-- =========================================
local login = Instance.new("Frame", gui)
login.Size = UDim2.new(0,300,0,200)
login.Position = UDim2.new(0.5,-150,0.5,-100)
login.BackgroundColor3 = Color3.fromRGB(0,0,0)
login.BackgroundTransparency = 0.3

local titleL = Instance.new("TextLabel", login)
titleL.Size = UDim2.new(1,0,0,40)
titleL.Text = "🔐 GHOST LOGIN"
titleL.TextColor3 = Color3.fromRGB(0,255,255)
titleL.BackgroundTransparency = 1

local box = Instance.new("TextBox", login)
box.Size = UDim2.new(0.8,0,0,40)
box.Position = UDim2.new(0.1,0,0.3,0)
box.PlaceholderText = "Contraseña..."

local confirm = Instance.new("TextButton", login)
confirm.Size = UDim2.new(0.35,0,0,40)
confirm.Position = UDim2.new(0.1,0,0.65,0)
confirm.Text = "CONFIRMAR"

local wa = Instance.new("TextButton", login)
wa.Size = UDim2.new(0.35,0,0,40)
wa.Position = UDim2.new(0.55,0,0.65,0)
wa.Text = "WHATSAPP"

-- =========================================
-- 💀 MENU (OCULTO HASTA LOGIN)
-- =========================================
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,400,0,550)
main.Position = UDim2.new(0.5,-200,0.5,-275)
main.BackgroundColor3 = Color3.fromRGB(10,10,20)
main.BackgroundTransparency = 0.2
main.Visible = false
main.ClipsDescendants = true

local outline = Instance.new("UIStroke", main)
outline.Thickness = 3
outline.Color = Color3.fromRGB(0,200,255)

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0,15)

-- BOTON FLOTANTE
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0,60,0,60)
toggle.Position = UDim2.new(0,10,0,180)
toggle.Text = "🌑"

local toggleStroke = Instance.new("UIStroke", toggle)
toggleStroke.Color = Color3.fromRGB(0,170,255)

-- ABRIR / CERRAR
local open = false
toggle.MouseButton1Click:Connect(function()
    open = not open
    main.Visible = open
    if open then openSound:Play() end
end)

-- TITULO
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,50)
title.Text = "🌑 GHOST FAKE 🌑"
title.BackgroundTransparency = 0.4
title.TextColor3 = Color3.new(1,1,1)

-- TABS
local tabs = {"COMBAT","VISUAL","INFO","OTROS"}
local frames = {}

for i,v in pairs(tabs) do
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(0.25,0,0,35)
    b.Position = UDim2.new((i-1)*0.25,0,0,50)
    b.Text = v
    
    frames[v] = Instance.new("Frame", main)
    frames[v].Size = UDim2.new(1,0,0.75,0)
    frames[v].Position = UDim2.new(0,0,0,88)
    frames[v].BackgroundTransparency = 1
    frames[v].Visible = false

    b.MouseButton1Click:Connect(function()
        for _,f in pairs(frames) do f.Visible = false end
        frames[v].Visible = true
    end)
end

frames["COMBAT"].Visible = true

-- =========================================
-- 🔘 FUNCIONES LOGIN
-- =========================================

-- CONFIRMAR
confirm.MouseButton1Click:Connect(function()
    if box.Text == PASSWORD then
        
        login.Visible = false
        main.Visible = true
        open = true
        
        openSound:Play()

        pcall(function()
            StarterGui:SetCore("SendNotification",{
                Title="✔ Correcto",
                Text="Bienvenido GHOST",
                Duration=3
            })
        end)

    else
        box.Text = ""
        box.PlaceholderText = "❌ CONTRASEÑA INVALIDA"

        StarterGui:SetCore("SendNotification",{
            Title="❌ Error",
            Text="Contraseña incorrecta",
            Duration=3
        })
    end
end)

-- WHATSAPP
wa.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(WA_LINK)
    elseif toclipboard then
        toclipboard(WA_LINK)
    end

    StarterGui:SetCore("SendNotification",{
        Title="📋 Copiado",
        Text="Copiado correctamente",
        Duration=3
    })
end)
