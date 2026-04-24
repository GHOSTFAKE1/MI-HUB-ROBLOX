--// CONFIG DEFAULT
local hitboxSize = 6
local hitboxColor = Color3.fromRGB(255,0,0)
local enabled = false

--// GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "HitboxMenu"

-- BOTÓN ABRIR/CERRAR
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0,100,0,40)
toggleBtn.Position = UDim2.new(0,20,0,200)
toggleBtn.Text = "MENU"
toggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
toggleBtn.TextColor3 = Color3.new(1,1,1)

-- FRAME PRINCIPAL
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,250,0,250)
frame.Position = UDim2.new(0,20,0,250)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Visible = false

-- BOTÓN ACTIVAR HITBOX
local hitboxBtn = Instance.new("TextButton", frame)
hitboxBtn.Size = UDim2.new(0,200,0,40)
hitboxBtn.Position = UDim2.new(0,25,0,20)
hitboxBtn.Text = "Activar Hitbox"
hitboxBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
hitboxBtn.TextColor3 = Color3.new(1,1,1)

-- BOTÓN CAMBIAR COLOR
local colorBtn = Instance.new("TextButton", frame)
colorBtn.Size = UDim2.new(0,200,0,40)
colorBtn.Position = UDim2.new(0,25,0,70)
colorBtn.Text = "Cambiar Color"
colorBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
colorBtn.TextColor3 = Color3.new(1,1,1)

-- BOTÓN AUMENTAR TAMAÑO
local sizeUp = Instance.new("TextButton", frame)
sizeUp.Size = UDim2.new(0,95,0,40)
sizeUp.Position = UDim2.new(0,25,0,120)
sizeUp.Text = "+ Tamaño"

-- BOTÓN DISMINUIR TAMAÑO
local sizeDown = Instance.new("TextButton", frame)
sizeDown.Size = UDim2.new(0,95,0,40)
sizeDown.Position = UDim2.new(0,130,0,120)
sizeDown.Text = "- Tamaño"

-- TEXTO INFO
local info = Instance.new("TextLabel", frame)
info.Size = UDim2.new(0,200,0,40)
info.Position = UDim2.new(0,25,0,170)
info.Text = "Size: "..hitboxSize
info.TextColor3 = Color3.new(1,1,1)
info.BackgroundTransparency = 1

--// FUNCION HITBOX
function applyHitbox()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            
            if v.Character:FindFirstChild("FakeHitbox") then
                v.Character.FakeHitbox:Destroy()
            end

            if enabled then
                local p = Instance.new("Part")
                p.Name = "FakeHitbox"
                p.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                p.Color = hitboxColor
                p.Transparency = 0.5
                p.Material = Enum.Material.ForceField
                p.CanCollide = false

                local weld = Instance.new("WeldConstraint")
                weld.Part0 = p
                weld.Part1 = v.Character.HumanoidRootPart
                weld.Parent = p

                p.Parent = v.Character
                p.Position = v.Character.HumanoidRootPart.Position
            end
        end
    end
end

--// EVENTOS

-- abrir/cerrar menú
toggleBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- activar hitbox
hitboxBtn.MouseButton1Click:Connect(function()
    enabled = not enabled
    hitboxBtn.Text = enabled and "Desactivar Hitbox" or "Activar Hitbox"
    applyHitbox()
end)

-- cambiar color (random pro)
colorBtn.MouseButton1Click:Connect(function()
    hitboxColor = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
    applyHitbox()
end)

-- tamaño +
sizeUp.MouseButton1Click:Connect(function()
    hitboxSize = hitboxSize + 1
    info.Text = "Size: "..hitboxSize
    applyHitbox()
end)

-- tamaño -
sizeDown.MouseButton1Click:Connect(function()
    if hitboxSize > 2 then
        hitboxSize = hitboxSize - 1
        info.Text = "Size: "..hitboxSize
        applyHitbox()
    end
end)
