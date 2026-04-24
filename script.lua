--// VARIABLES
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local plr = Players.LocalPlayer

-- CONFIG
local config = {
    size = 6,
    speed = 16,
    jump = 50,
    R = 0,
    G = 170,
    B = 255,
    hitbox = false
}

--// GUI
local gui = Instance.new("ScreenGui", game.CoreGui)

-- BOTÓN BURBUJA
local bubble = Instance.new("TextButton", gui)
bubble.Size = UDim2.new(0,60,0,60)
bubble.Position = UDim2.new(0,20,0,200)
bubble.Text = "●"
bubble.BackgroundColor3 = Color3.fromRGB(0,170,255)
bubble.TextScaled = true
bubble.Active = true
bubble.Draggable = true

-- FRAME
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,360,0,420)
frame.Position = UDim2.new(0.5,-180,0.5,-210)
frame.BackgroundColor3 = Color3.fromRGB(0,0,20)
frame.BackgroundTransparency = 0.2
frame.Visible = false

-- ANIMACIÓN iOS (fade)
local function showUI(state)
    frame.Visible = true
    local goal = {BackgroundTransparency = state and 0.2 or 1}
    TweenService:Create(frame, TweenInfo.new(0.3), goal):Play()
    if not state then
        task.wait(0.3)
        frame.Visible = false
    end
end

bubble.MouseButton1Click:Connect(function()
    showUI(not frame.Visible)
end)

-- NEÓN
local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0,170,255)

-- SLIDER PRO
local function slider(parent,text,y,min,max,key)
    local val = config[key]

    local label = Instance.new("TextLabel", parent)
    label.Position = UDim2.new(0,20,0,y)
    label.Size = UDim2.new(0,300,0,20)
    label.Text = text..": "..val
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)

    local bar = Instance.new("Frame", parent)
    bar.Position = UDim2.new(0,20,0,y+25)
    bar.Size = UDim2.new(0,300,0,8)
    bar.BackgroundColor3 = Color3.fromRGB(40,40,70)

    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new((val-min)/(max-min),0,1,0)
    fill.BackgroundColor3 = Color3.fromRGB(0,170,255)

    local knob = Instance.new("Frame", bar)
    knob.Size = UDim2.new(0,14,0,14)
    knob.Position = UDim2.new(fill.Size.X.Scale,-7,0.5,-7)
    knob.BackgroundColor3 = Color3.fromRGB(0,200,255)

    local dragging = false

    local function update(input)
        local pos = (input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
        pos = math.clamp(pos,0,1)

        fill.Size = UDim2.new(pos,0,1,0)
        knob.Position = UDim2.new(pos,-7,0.5,-7)

        local v = math.floor(min + (max-min)*pos)
        config[key] = v
        label.Text = text..": "..v

        if key=="speed" and plr.Character then
            plr.Character.Humanoid.WalkSpeed = v
        end
        if key=="jump" and plr.Character then
            plr.Character.Humanoid.JumpPower = v
        end
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType.Name=="MouseButton1" or input.UserInputType.Name=="Touch" then
            dragging = true
            update(input)
        end
    end)

    bar.InputEnded:Connect(function()
        dragging = false
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging then
            update(input)
        end
    end)
end

-- BOTÓN HITBOX
local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0,200,0,40)
btn.Position = UDim2.new(0,80,0,20)
btn.Text = "Activar Hitbox"

btn.MouseButton1Click:Connect(function()
    config.hitbox = not config.hitbox
    btn.Text = config.hitbox and "Desactivar Hitbox" or "Activar Hitbox"
end)

-- SLIDERS
slider(frame,"Size",80,2,20,"size")
slider(frame,"Speed",140,16,100,"speed")
slider(frame,"Jump",200,50,150,"jump")
slider(frame,"R",260,0,255,"R")
slider(frame,"G",310,0,255,"G")
slider(frame,"B",360,0,255,"B")

-- GUARDAR CONFIG
local save = Instance.new("TextButton", frame)
save.Size = UDim2.new(0,200,0,30)
save.Position = UDim2.new(0,80,0,390)
save.Text = "Guardar Config"

save.MouseButton1Click:Connect(function()
    if writefile then
        writefile("config_hitbox.txt", game:GetService("HttpService"):JSONEncode(config))
    end
end)

-- CARGAR CONFIG
if readfile and isfile and isfile("config_hitbox.txt") then
    config = game:GetService("HttpService"):JSONDecode(readfile("config_hitbox.txt"))
end

-- HITBOX VISUAL
task.spawn(function()
    while true do
        if config.hitbox then
            for _,v in pairs(Players:GetPlayers()) do
                if v~=plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = v.Character.HumanoidRootPart

                    if not hrp:FindFirstChild("HB") then
                        local p = Instance.new("Part")
                        p.Name="HB"
                        p.CanCollide=false
                        p.Transparency=0.5
                        p.Material=Enum.Material.ForceField

                        local w = Instance.new("WeldConstraint")
                        w.Part0=p
                        w.Part1=hrp
                        w.Parent=p

                        p.Parent=hrp
                    end

                    local hb = hrp.HB
                    hb.Size = Vector3.new(config.size,config.size,config.size)
                    hb.Color = Color3.fromRGB(config.R,config.G,config.B)
                    hb.Position = hrp.Position
                end
            end
        end
        task.wait(0.2)
    end
end)
