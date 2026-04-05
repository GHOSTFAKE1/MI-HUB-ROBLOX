-- // GHOST FAKE - LOGIN + MENU ULTRA //

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- =========================================
-- 🔐 LOGIN (TU DISEÑO)
-- =========================================

local gui = Instance.new("ScreenGui")
gui.Name = "GhostFakeLogin"
gui.Parent = game.CoreGui

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 350, 0, 400)
main.Position = UDim2.new(0.5, -175, 0.5, -200)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BackgroundTransparency = 0.1

local border = Instance.new("UIStroke", main)
border.Thickness = 3
border.Color = Color3.fromRGB(255, 0, 0)

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,80)
title.Text = "GHOST FAKE"
title.TextColor3 = Color3.fromRGB(255,0,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 35

local passBox = Instance.new("TextBox", main)
passBox.Size = UDim2.new(0.8,0,0,45)
passBox.Position = UDim2.new(0.1,0,0,150)
passBox.PlaceholderText = "Contraseña..."

local status = Instance.new("TextLabel", main)
status.Size = UDim2.new(1,0,0,25)
status.Position = UDim2.new(0,0,0,200)
status.BackgroundTransparency = 1

local btn = Instance.new("TextButton", main)
btn.Size = UDim2.new(0.8,0,0,45)
btn.Position = UDim2.new(0.1,0,0,250)
btn.Text = "CONFIRMAR"

local correctPass = "GHOSTFAKE-172816381"

-- =========================================
-- 💀 FUNCION QUE CREA EL MENU
-- =========================================

local function AbrirMenu()

    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")

    local LocalPlayer = Players.LocalPlayer

    local Gui = Instance.new("ScreenGui")
    Gui.Name = "GhostFakeUI"
    Gui.Parent = game.CoreGui

    local Main = Instance.new("Frame", Gui)
    Main.Size = UDim2.new(0, 450, 0, 620)
    Main.Position = UDim2.new(0.5, -225, 0.5, -310)
    Main.BackgroundColor3 = Color3.fromRGB(0,0,0)
    Main.BackgroundTransparency = 0.1
    Main.Active = true
    Main.Draggable = true

    local Border = Instance.new("UIStroke", Main)
    Border.Thickness = 5

    Instance.new("UICorner", Main).CornerRadius = UDim.new(0,25)

    -- TITULO
    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1,0,0,60)
    Title.Text = "🔥 GHOST FAKE 🔥"
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 28

    -- TABS
    local tabs = {"COMBAT","VISUAL","HABILIDADES","EXTRAS"}
    local frames = {}

    for i,v in pairs(tabs) do
        local b = Instance.new("TextButton", Main)
        b.Size = UDim2.new(0.25,0,0,40)
        b.Position = UDim2.new((i-1)*0.25,0,0,70)
        b.Text = v

        frames[v] = Instance.new("Frame", Main)
        frames[v].Size = UDim2.new(1,0,0.7,0)
        frames[v].Position = UDim2.new(0,0,0,120)
        frames[v].Visible = false

        b.MouseButton1Click:Connect(function()
            for _,f in pairs(frames) do f.Visible = false end
            frames[v].Visible = true
        end)
    end

    frames["COMBAT"].Visible = true

    -- EJEMPLO BOTONES
    local function AddBtn(tab, txt)
        local b = Instance.new("TextButton", frames[tab])
        b.Size = UDim2.new(0.8,0,0,40)
        b.Position = UDim2.new(0.1,0,0, (#frames[tab]:GetChildren()*45))
        b.Text = txt
    end

    AddBtn("COMBAT","💥 AUTO PUNCH")
    AddBtn("COMBAT","🛡️ GOD MODE")
    AddBtn("VISUAL","📦 ESP")
    AddBtn("VISUAL","🚀 FLY")

end

-- =========================================
-- 🔘 LOGIN LOGICA
-- =========================================

btn.MouseButton1Click:Connect(function()
    if passBox.Text == correctPass then
        
        status.Text = "✅ ACCESO PERMITIDO"
        status.TextColor3 = Color3.fromRGB(0,255,0)

        local tween = TweenService:Create(main, TweenInfo.new(0.5), {
            Position = UDim2.new(0.5, -175, 1, 0),
            BackgroundTransparency = 1
        })
        tween:Play()

        tween.Completed:Connect(function()
            gui:Destroy()
            AbrirMenu() -- 🔥 AQUI SE ABRE TU MENU
        end)

    else
        status.Text = "❌ CONTRASEÑA INVALIDA"
        status.TextColor3 = Color3.fromRGB(255,0,0)
    end
end)
