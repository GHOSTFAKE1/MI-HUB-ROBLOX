-- HUB GOD v1
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- GUI principal
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 350, 0, 400)
Main.Position = UDim2.new(0.5, -175, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(15,15,15)
Main.Active = true
Main.Draggable = true

-- TopBar
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1,0,0,30)
TopBar.BackgroundColor3 = Color3.fromRGB(0,255,150)
local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1,0,1,0)
Title.Text = "HUB GOD"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0,0,0)

-- Botón cerrar
local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0,40,1,0)
CloseBtn.Position = UDim2.new(1,-40,0,0)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

-- Botón abrir
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0,100,0,40)
OpenBtn.Position = UDim2.new(0,10,0,200)
OpenBtn.Text = "ABRIR"
OpenBtn.BackgroundColor3 = Color3.fromRGB(0,255,150)
OpenBtn.MouseButton1Click:Connect(function() Main.Visible = true end)

-- TABS
local Tabs = Instance.new("Frame", Main)
Tabs.Size = UDim2.new(0,100,1,-30)
Tabs.Position = UDim2.new(0,0,0,30)
Tabs.BackgroundColor3 = Color3.fromRGB(25,25,25)

local Pages = Instance.new("Frame", Main)
Pages.Size = UDim2.new(1,-100,1,-30)
Pages.Position = UDim2.new(0,100,0,30)
Pages.BackgroundColor3 = Color3.fromRGB(35,35,35)

-- Función para crear tabs
local function crearTab(nombre)
    local btn = Instance.new("TextButton", Tabs)
    btn.Size = UDim2.new(1,0,0,50)
    btn.Text = nombre
    btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    btn.TextColor3 = Color3.fromRGB(255,255,255)

    local page = Instance.new("Frame", Pages)
    page.Size = UDim2.new(1,0,1,0)
    page.Visible = false
    page.BackgroundTransparency = 1

    btn.MouseButton1Click:Connect(function()
        for _,v in pairs(Pages:GetChildren()) do
            v.Visible = false
        end
        page.Visible = true
    end)
    return page
end

-- Crear tabs
local MainTab = crearTab("Main")
local PlayerTab = crearTab("Player")
local InfoTab = crearTab("Info")
MainTab.Visible = true

-- ===== MainTab =====
local function crearBoton(frame, texto, func)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1,0,0,40)
    btn.Position = UDim2.new(0,0,0,40*#frame:GetChildren())
    btn.Text = texto
    btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.MouseButton1Click:Connect(func)
end

crearBoton(MainTab, "Acción General", function()
    print("Acción ejecutada")
end)

-- ===== PlayerTab =====
crearBoton(PlayerTab, "Velocidad x2", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 50
    end
end)

crearBoton(PlayerTab, "Super Salto", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 100
    end
end)

crearBoton(PlayerTab, "Resetear Personaje", function()
    if LocalPlayer.Character then
        LocalPlayer.Character:BreakJoints()
    end
end)

-- ===== InfoTab =====
-- Contador jugadores
local PlayersLabel = Instance.new("TextLabel", InfoTab)
PlayersLabel.Size = UDim2.new(1,0,0,40)
PlayersLabel.Position = UDim2.new(0,0,0,0)
PlayersLabel.BackgroundTransparency = 1
PlayersLabel.TextColor3 = Color3.fromRGB(0,255,150)

local function actualizar()
    PlayersLabel.Text = "Jugadores: "..#Players:GetPlayers()
end
actualizar()
Players.PlayerAdded:Connect(actualizar)
Players.PlayerRemoving:Connect(actualizar)

-- Barra de vida de enemigos
local function crearBarraVida(enemy)
    local Billboard = Instance.new("BillboardGui", enemy:WaitForChild("HumanoidRootPart"))
    Billboard.Size = UDim2.new(4,0,1,0)
    Billboard.Adornee = enemy:WaitForChild("HumanoidRootPart")
    Billboard.AlwaysOnTop = true

    local Bar = Instance.new("Frame", Billboard)
    Bar.Size = UDim2.new(1,0,0,20)
    Bar.Position = UDim2.new(0,0,0,0)
    Bar.BackgroundColor3 = Color3.fromRGB(255,0,0)

    RunService.RenderStepped:Connect(function()
        if enemy:FindFirstChild("Humanoid") then
            Bar.Size = UDim2.new(enemy.Humanoid.Health/enemy.Humanoid.MaxHealth,0,0,20)
        end
    end)
end

for _,plr in pairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        crearBarraVida(plr.Character)
    end
end

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(char)
        crearBarraVida(char)
    end)
end)
