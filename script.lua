-- // GHOST FAKE - SCRIPT COMPLETO ABILITY WARS //
-- // INICIO + MENU FULL HACKS //

-- SERVICIOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ==============================================
-- VARIABLES
-- ==============================================
local CorrectPassword = "GHOSTFAKE-172816381"
local WhatsAppLink = "https://whatsapp.com/channel/0029VbBIZ1D4Y9lgE0Z7yU2O"

_G.Speed = 16
_G.JumpPower = 50
_G.HitboxSize = 5
_G.ESPEnabled = false
_G.KillAura = false
_G.Fly = false
_G.AutoPunch = false
_G.NoCooldown = false
_G.GodMode = false
_G.AutoFarm = false
_G.Reach = 5

-- ==============================================
-- 🏠 PANTALLA DE INICIO (LOGIN)
-- ==============================================

local LoginGui = Instance.new("ScreenGui")
LoginGui.Name = "GhostFakeLogin"
LoginGui.Parent = game.CoreGui
LoginGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- MARCO LOGIN
local LoginFrame = Instance.new("Frame")
LoginFrame.Size = UDim2.new(0, 380, 0, 420)
LoginFrame.Position = UDim2.new(0.5, -190, 0.5, -210)
LoginFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LoginFrame.BackgroundTransparency = 0.1
LoginFrame.Parent = LoginGui

local LoginBorder = Instance.new("UIStroke", LoginFrame)
LoginBorder.Thickness = 4
LoginBorder.Color = Color3.fromRGB(255, 0, 0)

local LoginCorner = Instance.new("UICorner", LoginFrame)
LoginCorner.CornerRadius = UDim.new(0, 20)

-- TITULO ROJO
local TitleLogin = Instance.new("TextLabel", LoginFrame)
TitleLogin.Size = UDim2.new(1,0,0,80)
TitleLogin.Position = UDim2.new(0,0,0,20)
TitleLogin.BackgroundTransparency = 1
TitleLogin.Text = "🔥 GHOST FAKE 🔥"
TitleLogin.TextColor3 = Color3.fromRGB(255,0,0)
TitleLogin.Font = Enum.Font.GothamBold
TitleLogin.TextSize = 36

-- SUBTITULO
local SubLogin = Instance.new("TextLabel", LoginFrame)
SubLogin.Size = UDim2.new(1,0,0,30)
SubLogin.Position = UDim2.new(0,0,0,100)
SubLogin.BackgroundTransparency = 1
SubLogin.Text = "INGRESE LA CONTRASEÑA"
SubLogin.TextColor3 = Color3.new(1,1,1)
SubLogin.Font = Enum.Font.GothamBold

-- INPUT CONTRASEÑA
local PassInput = Instance.new("TextBox", LoginFrame)
PassInput.Size = UDim2.new(0.8,0,0,50)
PassInput.Position = UDim2.new(0.1,0,0,150)
PassInput.BackgroundColor3 = Color3.fromRGB(10,10,10)
PassInput.BackgroundTransparency = 0.2
PassInput.PlaceholderText = "Escriba aquí..."
PassInput.Text = ""
PassInput.TextColor3 = Color3.new(1,1,1)
PassInput.Font = Enum.Font.GothamBold
PassInput.TextSize = 16

local InputBorder = Instance.new("UIStroke", PassInput)
InputBorder.Thickness = 2
InputBorder.Color = Color3.fromRGB(0,150,255)
local InputCorner = Instance.new("UICorner", PassInput)
InputCorner.CornerRadius = UDim.new(0,10)

-- TEXTO ESTADO
local StatusText = Instance.new("TextLabel", LoginFrame)
StatusText.Size = UDim2.new(1,0,0,30)
StatusText.Position = UDim2.new(0,0,0,210)
StatusText.BackgroundTransparency = 1
StatusText.Text = ""
StatusText.TextColor3 = Color3.fromRGB(255,50,50)
StatusText.Font = Enum.Font.GothamBold

-- BOTONES
local BtnConfirm = Instance.new("TextButton", LoginFrame)
BtnConfirm.Size = UDim2.new(0.38,0,0,50)
BtnConfirm.Position = UDim2.new(0.08,0,0,250)
BtnConfirm.BackgroundColor3 = Color3.fromRGB(0,100,200)
BtnConfirm.BackgroundTransparency = 0.2
BtnConfirm.Text = "CONFIRMAR"
BtnConfirm.TextColor3 = Color3.new(1,1,1)
BtnConfirm.Font = Enum.Font.GothamBold

local BtnWpp = Instance.new("TextButton", LoginFrame)
BtnWpp.Size = UDim2.new(0.38,0,0,50)
BtnWpp.Position = UDim2.new(0.54,0,0,250)
BtnWpp.BackgroundColor3 = Color3.fromRGB(20,150,50)
BtnWpp.BackgroundTransparency = 0.2
BtnWpp.Text = "WHATSAPP"
BtnWpp.TextColor3 = Color3.new(1,1,1)
BtnWpp.Font = Enum.Font.GothamBold

local Corn1 = Instance.new("UICorner", BtnConfirm)
local Corn2 = Instance.new("UICorner", BtnWpp)
Corn1.CornerRadius = UDim.new(0,10)
Corn2.CornerRadius = UDim.new(0,10)

-- LOGICA BOTONES
BtnConfirm.MouseButton1Click:Connect(function()
    if PassInput.Text == CorrectPassword then
        StatusText.Text = "✅ ACCESO PERMITIDO"
        StatusText.TextColor3 = Color3.fromRGB(0,255,0)
        LoginBorder.Color = Color3.fromRGB(0,255,0)
        
        local tween = TweenService:Create(LoginFrame, TweenInfo.new(0.5), {
            Position = UDim2.new(0.5, -190, -1, 0),
            BackgroundTransparency = 1
        })
        tween:Play()
        tween.Completed:Connect(function()
            LoginGui:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ghostfake/main/menu/main.lua"))() -- O AQUÍ CARGA EL MENÚ
            CargarMenuPrincipal() -- LLAMA AL MENÚ
        end)
    else
        StatusText.Text = "❌ CONTRASEÑA INVALIDA"
        StatusText.TextColor3 = Color3.fromRGB(255,0,0)
        -- ANIMACION DE ERROR
        local orig = LoginFrame.Position
        TweenService:Create(LoginFrame, TweenInfo.new(0.1):Play(LoginFrame, {Position = UDim2.new(0.5,-180,0.5,-210)}))
        wait(0.1)
        TweenService:Create(LoginFrame, TweenInfo.new(0.1):Play(LoginFrame, {Position = UDim2.new(0.5,-200,0.5,-210)}))
        wait(0.1)
        LoginFrame.Position = orig
    end
end)

BtnWpp.MouseButton1Click:Connect(function()
    setclipboard(WhatsAppLink)
    StatusText.Text = "✅ ENLACE COPIADO CORRECTAMENTE"
    StatusText.TextColor3 = Color3.fromRGB(0,255,100)
end)

-- ==============================================
-- 🚀 MENU PRINCIPAL CON HACKS
-- ==============================================

function CargarMenuPrincipal()

local Gui = Instance.new("ScreenGui")
Gui.Name = "GhostFakeMain"
Gui.Parent = game.CoreGui
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- BOTON ABRIR/CERRAR
local ToggleBtn = Instance.new("TextButton", Gui)
ToggleBtn.Size = UDim2.new(0,60,0,60)
ToggleBtn.Position = UDim2.new(0,10,0,180)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
ToggleBtn.BackgroundTransparency = 0.2
ToggleBtn.Text = "👻"
ToggleBtn.TextColor3 = Color3.fromRGB(0,255,100)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 28

local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Thickness = 2
ToggleStroke.Color = Color3.fromRGB(0,255,100)
local ToggleCorner = Instance.new("UICorner", ToggleBtn)
ToggleCorner.CornerRadius = UDim.new(0,15)

-- MENU PRINCIPAL
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0,450,0,620)
Main.Position = UDim2.new(0.5,-225,0.5,-310)
Main.BackgroundColor3 = Color3.fromRGB(0,0,0)
Main.BackgroundTransparency = 0.1
Main.Visible = false

-- BORDE DE COLORES ARCOIRIS
local Border = Instance.new("UIStroke", Main)
Border.Thickness = 5
Border.Color = Color3.new(1,1,1)
local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0,25)

-- ANIMACION DE COLORES
spawn(function()
    while wait(0.05) do
        for i=0,1,0.01 do
            Border.Color = Color3.fromHSV(i,1,1)
            wait()
        end
    end
end)

-- TITULO
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,70)
Title.Position = UDim2.new(0,0,0,5)
Title.BackgroundTransparency = 1
Title.Text = "🔥 GHOST FAKE 🔥"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 32

-- TABS
local Tabs = {}
local Frames = {}
local TabNames = {"COMBAT", "VISUAL", "HABILIDADES", "EXTRAS"}

for i,v in pairs(TabNames) do
    local Btn = Instance.new("TextButton", Main)
    Btn.Size = UDim2.new(0.25,0,0,40)
    Btn.Position = UDim2.new((i-1)*0.25,0,0,80)
    Btn.Text = v
    Btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Btn.BackgroundTransparency = 0.2
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.Font = Enum.Font.GothamBold
    
    local BtnCorner = Instance.new("UICorner", Btn)
    BtnCorner.CornerRadius = UDim.new(0,10)
    
    local Frame = Instance.new("ScrollingFrame", Main)
    Frame.Size = UDim2.new(1,0,0.75,0)
    Frame.Position = UDim2.new(0,0,0,125)
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.ScrollBarThickness = 4
    Frame.Visible = false
    
    table.insert(Tabs, Btn)
    table.insert(Frames, Frame)
    
    Btn.MouseButton1Click:Connect(function()
        for _,F in pairs(Frames) do F.Visible = false end
        Frame.Visible = true
    end)
end
Frames[1].Visible = true

-- FUNCIONES
local function AddButton(TabIndex, Text, Color, Func)
    local Btn = Instance.new("TextButton", Frames[TabIndex])
    Btn.Size = UDim2.new(0.9,0,0,45)
    Btn.Position = UDim2.new(0.05,0,0,#Frames[TabIndex]:GetChildren()*50)
    Btn.Text = Text
    Btn.BackgroundColor3 = Color
    Btn.BackgroundTransparency = 0.2
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.Font = Enum.Font.GothamBold
    local Corn = Instance.new("UICorner", Btn)
    Corn.CornerRadius = UDim.new(0,10)
    Btn.MouseButton1Click:Connect(Func)
end

local function AddSlider(TabIndex, Text, Min, Max, Default, Func)
    local Cont = Instance.new("Frame", Frames[TabIndex])
    Cont.Size = UDim2.new(0.9,0,0,50)
    Cont.Position = UDim2.new(0.05,0,0,#Frames[TabIndex]:GetChildren()*50)
    Cont.BackgroundTransparency = 1
    
    local Lbl = Instance.new("TextLabel", Cont)
    Lbl.Size = UDim2.new(1,0,0,20)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = Text..": "..Default
    Lbl.TextColor3 = Color3.new(1,1,1)
    Lbl.Font = Enum.Font.GothamBold
    
    local Slider = Instance.new("TextButton", Cont)
    Slider.Size = UDim2.new(1,0,0,15)
    Slider.Position = UDim2.new(0,0,0,25)
    Slider.BackgroundColor3 = Color3.fromRGB(30,30,30)
    
    local Fill = Instance.new("Frame", Slider)
    Fill.Size = UDim2.new((Default-Min)/(Max-Min),0,1,0)
    Fill.BackgroundColor3 = Color3.fromRGB(0,255,100)
    local Corn = Instance.new("UICorner", Fill)
    Corn.CornerRadius = UDim.new(0,5)
    
    local Drag = false
    Slider.MouseButton1Down:Connect(function() Drag=true end)
    UserInputService.InputEnded:Connect(function() Drag=false end)
    
    RunService.RenderStepped:Connect(function()
        if Drag then
            local Pos = math.clamp(Mouse.X - Slider.AbsolutePosition.X, 0, Slider.AbsoluteSize.X)
            local Per = Pos/Slider.AbsoluteSize.X
            Fill.Size = UDim2.new(Per,0,1,0)
            local Val = math.floor(Min+(Max-Min)*Per)
            Lbl.Text = Text..": "..Val
            Func(Val)
        end
    end)
end

-- ==============================================
-- 🛠️ HACKS DENTRO DEL MENU
-- ==============================================

-- COMBAT
AddSlider(1, "⚡ VELOCIDAD", 16, 300, _G.Speed, function(v)
    if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = v end
end)
AddSlider(1, "🦘 SALTO", 50, 300, _G.JumpPower, function(v)
    if LocalPlayer.Character then LocalPlayer.Character.Humanoid.JumpPower = v end
end)
AddSlider(1, "🎯 HITBOX", 1, 50, _G.HitboxSize, function(v) _G.HitboxSize=v end)
AddSlider(1, "🔫 ALCANCE", 1, 100, _G.Reach, function(v) _G.Reach=v end)

AddButton(1, "💥 AUTO PUNCH", Color3.fromRGB(150,0,0), function()
    _G.AutoPunch = not _G.AutoPunch
end)
AddButton(1, "🔋 SIN COOLDOWN", Color3.fromRGB(0,100,150), function()
    _G.NoCooldown = not _G.NoCooldown
end)
AddButton(1, "🛡️ MODO DIOS", Color3.fromRGB(200,150,0), function()
    _G.GodMode = not _G.GodMode
            
