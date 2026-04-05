-- NOTIFICACIÓN AL EJECUTAR
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "EXECUTOR GHOST FAKE",
        Text = "Hub cargado correctamente",
        Duration = 5
    })
end)

-- SERVICIOS
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GhostHub"
ScreenGui.Parent = game.CoreGui

-- MENU
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,250,0,330)
Main.Position = UDim2.new(0.5,-125,0.5,-165)
Main.BackgroundColor3 = Color3.fromRGB(15,15,15)
Main.Active = true
Main.Draggable = true

-- TOP
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1,0,0,30)
Top.BackgroundColor3 = Color3.fromRGB(0,255,150)

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1,0,1,0)
Title.Text = "👻 GHOST HUB"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0,0,0)

-- CERRAR
local Close = Instance.new("TextButton", Top)
Close.Size = UDim2.new(0,30,1,0)
Close.Position = UDim2.new(1,-30,0,0)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(255,0,0)

Close.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

-- ABRIR
local Open = Instance.new("TextButton", ScreenGui)
Open.Size = UDim2.new(0,90,0,30)
Open.Position = UDim2.new(0,10,0,200)
Open.Text = "ABRIR HUB"
Open.BackgroundColor3 = Color3.fromRGB(0,255,150)

Open.MouseButton1Click:Connect(function()
    Main.Visible = true
end)

-- CREAR BOTONES
local Y = 40
local function boton(nombre, func)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(1,0,0,30)
    b.Position = UDim2.new(0,0,0,Y)
    b.Text = nombre
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.MouseButton1Click:Connect(func)
    Y = Y + 35
end

-- FUNCIONES

-- Velocidad
boton("⚡ Velocidad x2", function()
    if LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.WalkSpeed = 50
    end
end)

-- Salto
boton("🦘 Super Salto", function()
    if LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.JumpPower = 100
    end
end)

-- Reset
boton("💀 Resetear", function()
    if LocalPlayer.Character then
        LocalPlayer.Character:BreakJoints()
    end
end)

-- CONTADOR
local label = Instance.new("TextLabel", Main)
label.Size = UDim2.new(1,0,0,30)
label.Position = UDim2.new(0,0,0,Y)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(0,255,150)

local function actualizar()
    label.Text = "👥 Jugadores: "..#Players:GetPlayers()
end

actualizar()
Players.PlayerAdded:Connect(actualizar)
Players.PlayerRemoving:Connect(actualizar)

Y = Y + 35

-- ESP + NOMBRE
local esp = false

boton("👁 ESP Enemigos ON/OFF", function()
    esp = not esp
    
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
            
            if esp then
                -- NOMBRE
                local gui = Instance.new("BillboardGui", plr.Character.Head)
                gui.Name = "ESP_NAME"
                gui.Size = UDim2.new(0,100,0,40)
                gui.AlwaysOnTop = true
                
                local txt = Instance.new("TextLabel", gui)
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.Text = plr.Name
                txt.TextScaled = true
                txt.TextColor3 = Color3.fromRGB(0,255,150)

                -- CAJA
                local box = Instance.new("BoxHandleAdornment")
                box.Name = "ESP_BOX"
                box.Adornee = plr.Character:FindFirstChild("HumanoidRootPart")
                box.Size = Vector3.new(4,6,1)
                box.Color3 = Color3.fromRGB(0,255,0)
                box.AlwaysOnTop = true
                box.Transparency = 0.5
                box.Parent = plr.Character.HumanoidRootPart

            else
                local head = plr.Character.Head
                if head:FindFirstChild("ESP_NAME") then
                    head.ESP_NAME:Destroy()
                end
                
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if hrp and hrp:FindFirstChild("ESP_BOX") then
                    hrp.ESP_BOX:Destroy()
                end
            end
        end
    end
end)
