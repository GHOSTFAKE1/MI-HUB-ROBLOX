-- HUB GOD ESP COMPACTO
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- GUI principal
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,250,0,350)  -- más pequeño
Main.Position = UDim2.new(0.5,-125,0.5,-175)
Main.BackgroundColor3 = Color3.fromRGB(15,15,15)
Main.Active = true
Main.Draggable = true

-- TopBar
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1,0,0,25)
TopBar.BackgroundColor3 = Color3.fromRGB(0,255,150)
local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1,-25,1,0)
Title.Text = "HUB GOD ESP"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0,0,0)

-- Botón cerrar
local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0,25,1,0)
CloseBtn.Position = UDim2.new(1,-25,0,0)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

-- Botón abrir
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0,80,0,30)
OpenBtn.Position = UDim2.new(0,10,0,200)
OpenBtn.Text = "ABRIR"
OpenBtn.BackgroundColor3 = Color3.fromRGB(0,255,150)
OpenBtn.MouseButton1Click:Connect(function() Main.Visible = true end)

-- Posición inicial botones
local Y = 30

-- Función para crear botones en el menú
local function crearBoton(nombre, accion)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(1,0,0,30)
    btn.Position = UDim2.new(0,0,0,Y)
    btn.Text = nombre
    btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.MouseButton1Click:Connect(accion)
    Y = Y + 35
end

-- BOTONES ACTIVABLES
crearBoton("Velocidad x2", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 50
    end
end)

crearBoton("Super Salto", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 100
    end
end)

crearBoton("Resetear Personaje", function()
    if LocalPlayer.Character then
        LocalPlayer.Character:BreakJoints()
    end
end)

-- ESP enemigos con botón
local espActivado = false
crearBoton("Activar ESP Enemigos", function()
    espActivado = not espActivado
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            if espActivado then
                -- Caja ESP
                local Box = Instance.new("BoxHandleAdornment")
                Box.Adornee = plr.Character:WaitForChild("HumanoidRootPart")
                Box.Size = Vector3.new(4,6,1)
                Box.Color3 = Color3.fromRGB(0,255,0)
                Box.Transparency = 0.5
                Box.AlwaysOnTop = true
                Box.Name = "ESPBox"
                Box.Parent = plr.Character:WaitForChild("HumanoidRootPart")
                
                -- Nombre mini
                local Billboard = Instance.new("BillboardGui", plr.Character:WaitForChild("HumanoidRootPart"))
                Billboard.Size = UDim2.new(2,0,0.5,0)
                Billboard.Adornee = plr.Character:HumanoidRootPart
                Billboard.AlwaysOnTop = true
                Billboard.Name = "ESPName"
                local NameLabel = Instance.new("TextLabel", Billboard)
                NameLabel.Size = UDim2.new(1,0,1,0)
                NameLabel.BackgroundTransparency = 1
                NameLabel.TextColor3 = Color3.fromRGB(0,255,150)
                NameLabel.TextScaled = true
                NameLabel.Text = plr.Name
            else
                if plr.Character then
                    local HRP = plr.Character:FindFirstChild("HumanoidRootPart")
                    if HRP then
                        local box = HRP:FindFirstChild("ESPBox")
                        if box then box:Destroy() end
                        local name = HRP:FindFirstChild("ESPName")
                        if name then name:Destroy() end
                    end
                end
            end
        end
    end
end)

-- Contador jugadores
local PlayersLabel = Instance.new("TextLabel", Main)
PlayersLabel.Size = UDim2.new(1,0,0,30)
PlayersLabel.Position = UDim2.new(0,0,0,Y)
PlayersLabel.BackgroundTransparency = 1
PlayersLabel.TextColor3 = Color3.fromRGB(0,255,150)

local function actualizar()
    PlayersLabel.Text = "Jugadores: "..#Players:GetPlayers()
end
actualizar()
Players.PlayerAdded:Connect(actualizar)
Players.PlayerRemoving:Connect(actualizar)
