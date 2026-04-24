--// VARIABLES
local size = 6
local enabled = false
local R,G,B = 255,0,0
local speed = 16
local jump = 50

--// GUI
local gui = Instance.new("ScreenGui", game.CoreGui)

local open = Instance.new("TextButton", gui)
open.Size = UDim2.new(0,100,0,40)
open.Position = UDim2.new(0,20,0,200)
open.Text = "MENU"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,380,0,420)
frame.Position = UDim2.new(0.5,-190,0.5,-210)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.Visible = false
frame.Active = true
frame.Draggable = true

-- NEON
local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
task.spawn(function()
    while true do
        stroke.Color = Color3.fromHSV(tick()%5/5,1,1)
        task.wait(0.05)
    end
end)

-- TABS
local pages = {}
local function createTab(name, x)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0,120,0,30)
    btn.Position = UDim2.new(0,x,0,10)
    btn.Text = name

    local page = Instance.new("Frame", frame)
    page.Size = UDim2.new(1,-20,1,-50)
    page.Position = UDim2.new(0,10,0,50)
    page.Visible = false
    page.BackgroundTransparency = 1

    pages[name] = page

    btn.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible=false end
        page.Visible=true
    end)
end

createTab("Hitbox",10)
createTab("Player",140)
createTab("Visual",270)

pages["Hitbox"].Visible = true

-- FUNC SLIDER
local function createSlider(parent, text, y, min, max, default, callback)
    local label = Instance.new("TextLabel", parent)
    label.Position = UDim2.new(0,10,0,y)
    label.Size = UDim2.new(0,300,0,20)
    label.Text = text..": "..default
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)

    local bar = Instance.new("Frame", parent)
    bar.Position = UDim2.new(0,10,0,y+25)
    bar.Size = UDim2.new(0,300,0,10)
    bar.BackgroundColor3 = Color3.fromRGB(60,60,60)

    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
    fill.BackgroundColor3 = Color3.fromRGB(0,170,255)

    bar.InputBegan:Connect(function(input)
        if input.UserInputType.Name == "MouseButton1" then
            local move
            move = game:GetService("UserInputService").InputChanged:Connect(function(i)
                if i.UserInputType.Name == "MouseMovement" then
                    local pos = (i.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
                    pos = math.clamp(pos,0,1)
                    fill.Size = UDim2.new(pos,0,1,0)
                    local val = math.floor(min + (max-min)*pos)
                    label.Text = text..": "..val
                    callback(val)
                end
            end)
            input.Changed:Connect(function()
                if input.UserInputState.Name == "End" then
                    move:Disconnect()
                end
            end)
        end
    end)
end

-- HITBOX TAB
local toggle = Instance.new("TextButton", pages["Hitbox"])
toggle.Size = UDim2.new(0,200,0,40)
toggle.Position = UDim2.new(0,10,0,10)
toggle.Text = "Activar Hitbox"

createSlider(pages["Hitbox"],"Size",70,2,20,size,function(v) size=v end)

-- RGB sliders
createSlider(pages["Hitbox"],"R",120,0,255,R,function(v) R=v end)
createSlider(pages["Hitbox"],"G",170,0,255,G,function(v) G=v end)
createSlider(pages["Hitbox"],"B",220,0,255,B,function(v) B=v end)

-- PLAYER TAB
createSlider(pages["Player"],"Speed",20,16,100,speed,function(v)
    speed=v
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
end)

createSlider(pages["Player"],"Jump",90,50,150,jump,function(v)
    jump=v
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
    end
end)

-- VISUAL TAB (LISTA)
local list = Instance.new("TextLabel", pages["Visual"])
list.Size = UDim2.new(1,0,1,0)
list.BackgroundTransparency = 1
list.TextXAlignment = Enum.TextXAlignment.Left
list.TextYAlignment = Enum.TextYAlignment.Top

task.spawn(function()
    while true do
        local txt="Jugadores:\n\n"
        for _,v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
                txt = txt..v.Name.."\n"
            end
        end
        list.Text=txt
        task.wait(2)
    end
end)

-- HITBOX LOOP
task.spawn(function()
    while true do
        if enabled then
            for _,v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    
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

                    local hb = hrp:FindFirstChild("HB")
                    hb.Size = Vector3.new(size,size,size)
                    hb.Color = Color3.fromRGB(R,G,B)
                    hb.Position = hrp.Position
                end
            end
        end
        task.wait(0.2)
    end
end)

-- EVENTOS
open.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

toggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    toggle.Text = enabled and "Desactivar Hitbox" or "Activar Hitbox"
end)
