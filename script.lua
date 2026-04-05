-- MENSAJE DE ENTRADA
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "ENTRADA",
        Text = "GHOST FAKE 💀",
        Duration = 3
    })
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

-- SONIDOS
local openSound = Instance.new("Sound", SoundService)
openSound.SoundId = "rbxassetid://9118828565" -- sonido pro
openSound.Volume = 3

local voiceOn = false

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)

-- BOTON FLOTANTE
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0,60,0,60)
toggle.Position = UDim2.new(0,20,0,200)
toggle.BackgroundColor3 = Color3.fromRGB(0,0,0)
toggle.Text = "💀"
toggle.TextScaled = true
toggle.Active = true
toggle.Draggable = true

-- MENU
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,300,0,400)
main.Position = UDim2.new(0.5,-150,0.5,-200)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
main.Visible = false
main.Active = true
main.Draggable = true

-- ABRIR AUTOMATICO
task.delay(3, function()
    main.Visible = true
    openSound:Play()
end)

toggle.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
    if main.Visible then
        openSound:Play()
    end
end)

-- TITULO
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.Text = "GHOST FAKE 💀"
title.BackgroundColor3 = Color3.fromRGB(0,0,0)
title.TextColor3 = Color3.fromRGB(255,0,0)

-- TABS
local tabs = {"COMBAT","ESP","LEP","INFO","TEMA"}
local frames = {}

for i,v in pairs(tabs) do
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(0.2,0,0,30)
    b.Position = UDim2.new((i-1)*0.2,0,0.1,0)
    b.Text = v

    frames[v] = Instance.new("Frame", main)
    frames[v].Size = UDim2.new(1,0,0.75,0)
    frames[v].Position = UDim2.new(0,0,0.2,0)
    frames[v].Visible = false

    b.MouseButton1Click:Connect(function()
        for _,f in pairs(frames) do f.Visible=false end
        frames[v].Visible=true
    end)
end

frames["COMBAT"].Visible = true

-- FUNC BOTON
local function btn(parent,text,y,func)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1,0,0,30)
    b.Position = UDim2.new(0,0,0,y)
    b.Text = text
    b.MouseButton1Click:Connect(func)
end

-- COMBAT
local y=10

btn(frames["COMBAT"],"⚡ Velocidad",y,function()
    if LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.WalkSpeed = 50
    end
end) y=y+35

btn(frames["COMBAT"],"🦘 Salto",y,function()
    if LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.JumpPower = 100
    end
end) y=y+35

btn(frames["COMBAT"],"🛡 Anti Caida",y,function()
    RunService.Stepped:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart.Position.Y < -50 then
            LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.SpawnLocation.CFrame
        end
    end)
end) y=y+35

-- VOZ MUJER
btn(frames["COMBAT"],"👩 Voz Mujer ON/OFF",y,function()
    voiceOn = not voiceOn
    if voiceOn then
        local voice = Instance.new("Sound", SoundService)
        voice.SoundId = "rbxassetid://9120289495" -- voz mujer
        voice.Volume = 3
        voice:Play()
    end
end) y=y+35

-- COORDS
local coords = Instance.new("TextLabel", frames["COMBAT"])
coords.Size = UDim2.new(1,0,0,30)
coords.Position = UDim2.new(0,0,0,y)

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character then
        local p = LocalPlayer.Character.HumanoidRootPart.Position
        coords.Text = "X:"..math.floor(p.X).." Y:"..math.floor(p.Y).." Z:"..math.floor(p.Z)
    end
end)

-- ESP
local esp=false
btn(frames["ESP"],"👁 ESP ON/OFF",10,function()
    esp=not esp
    for _,plr in pairs(Players:GetPlayers()) do
        if plr~=LocalPlayer and plr.Character then
            local hrp=plr.Character:FindFirstChild("HumanoidRootPart")
            local hum=plr.Character:FindFirstChild("Humanoid")
            if hrp then
                if esp then
                    local box=Instance.new("BoxHandleAdornment",hrp)
                    box.Size=Vector3.new(4,6,1)
                    box.AlwaysOnTop=true
                    box.Color3=Color3.fromRGB(0,255,0)
                    box.Name="box"

                    local gui=Instance.new("BillboardGui",hrp)
                    gui.Size=UDim2.new(2,0,0.5,0)
                    gui.StudsOffset=Vector3.new(0,3,0)
                    gui.Name="hp"

                    local bar=Instance.new("Frame",gui)
                    bar.Size=UDim2.new(1,0,1,0)
                    bar.BackgroundColor3=Color3.fromRGB(255,0,0)

                    local hp=Instance.new("Frame",bar)
                    hp.Size=UDim2.new(1,0,1,0)
                    hp.BackgroundColor3=Color3.fromRGB(0,255,0)

                    RunService.RenderStepped:Connect(function()
                        if hum then
                            hp.Size=UDim2.new(hum.Health/hum.MaxHealth,0,1,0)
                        end
                    end)
                else
                    if hrp:FindFirstChild("box") then hrp.box:Destroy() end
                    if hrp:FindFirstChild("hp") then hrp.hp:Destroy() end
                end
            end
        end
    end
end)

-- LEP
local l1=Instance.new("TextLabel",frames["LEP"])
l1.Size=UDim2.new(1,0,0,30)

RunService.RenderStepped:Connect(function()
    l1.Text="👥 Jugadores: "..#Players:GetPlayers()
end)

local l2=Instance.new("TextLabel",frames["LEP"])
l2.Position=UDim2.new(0,0,0,30)

local fps=0
RunService.RenderStepped:Connect(function()
    fps=fps+1
    task.wait(1)
    l2.Text="⚡ FPS: "..fps
    fps=0
end)

local l3=Instance.new("TextLabel",frames["LEP"])
l3.Position=UDim2.new(0,0,0,60)

RunService.RenderStepped:Connect(function()
    l3.Text="⏰ "..os.date("%H:%M:%S")
end)

-- INFO
btn(frames["INFO"],"📢 IR AL CANAL",10,function()
    setclipboard("https://whatsapp.com/channel/0029VbBIZ1D4Y9lgE0Z7yU2O")
end)

-- TEMA
btn(frames["TEMA"],"🟢 Verde",10,function()
    main.BackgroundColor3=Color3.fromRGB(0,255,150)
end)

btn(frames["TEMA"],"🟣 Morado",50,function()
    main.BackgroundColor3=Color3.fromRGB(150,0,255)
end)

btn(frames["TEMA"],"🔵 Azul",90,function()
    main.BackgroundColor3=Color3.fromRGB(0,150,255)
end)
