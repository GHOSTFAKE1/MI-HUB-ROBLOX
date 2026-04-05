-- HUB BASE
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", ScreenGui)
local TopBar = Instance.new("Frame", Main)
local Title = Instance.new("TextLabel", TopBar)

local Tabs = Instance.new("Frame", Main)
local Pages = Instance.new("Frame", Main)

Main.Size = UDim2.new(0,300,0,300)
Main.Position = UDim2.new(0.5,-150,0.5,-150)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.Active = true
Main.Draggable = true

-- TOP
TopBar.Size = UDim2.new(1,0,0,30)
TopBar.BackgroundColor3 = Color3.fromRGB(30,30,30)

Title.Size = UDim2.new(1,0,1,0)
Title.Text = "ABILITY WARS HUB"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0,255,150)

-- TABS
Tabs.Size = UDim2.new(0,90,1,-30)
Tabs.Position = UDim2.new(0,0,0,30)
Tabs.BackgroundColor3 = Color3.fromRGB(25,25,25)

-- PAGES
Pages.Size = UDim2.new(1,-90,1,-30)
Pages.Position = UDim2.new(0,90,0,30)
Pages.BackgroundColor3 = Color3.fromRGB(35,35,35)

-- FUNCION CREAR TAB
function crearTab(nombre)
    local btn = Instance.new("TextButton", Tabs)
    btn.Size = UDim2.new(1,0,0,40)
    btn.Text = nombre

    local page = Instance.new("Frame", Pages)
    page.Size = UDim2.new(1,0,1,0)
    page.Visible = false

    btn.MouseButton1Click:Connect(function()
        for _,v in pairs(Pages:GetChildren()) do
            v.Visible = false
        end
        page.Visible = true
    end)

    return page
end

-- TABS
local MainTab = crearTab("Main")
local PlayerTab = crearTab("Player")
local InfoTab = crearTab("Info")

MainTab.Visible = true

-- ===== MAIN TAB =====
local AutoBtn = Instance.new("TextButton", MainTab)
AutoBtn.Size = UDim2.new(1,0,0,40)
AutoBtn.Text = "Acción Auto"

AutoBtn.MouseButton1Click:Connect(function()
    print("Acción ejecutada")
end)

-- ===== PLAYER TAB =====
local Speed = Instance.new("TextButton", PlayerTab)
Speed.Size = UDim2.new(1,0,0,40)
Speed.Text = "Velocidad x2"

Speed.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
end)

local Jump = Instance.new("TextButton", PlayerTab)
Jump.Size = UDim2.new(1,0,0,40)
Jump.Position = UDim2.new(0,0,0,50)
Jump.Text = "Super Salto"

Jump.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100
end)

-- ===== INFO TAB =====
local PlayersLabel = Instance.new("TextLabel", InfoTab)
PlayersLabel.Size = UDim2.new(1,0,0,40)
PlayersLabel.Text = "Jugadores: 0"
PlayersLabel.BackgroundTransparency = 1

local function actualizar()
    PlayersLabel.Text = "Jugadores: "..#game.Players:GetPlayers()
end

actualizar()
game.Players.PlayerAdded:Connect(actualizar)
game.Players.PlayerRemoving:Connect(actualizar)
