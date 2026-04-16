-- ==============================================
-- 🚀 MENU PRINCIPAL CON HACKS
-- (Continuación y Expansión)
-- ==============================================
function CargarMenuPrincipal()
    local Gui = Instance.new("ScreenGui")
    Gui.Name = "GhostFakeMain"
    Gui.Parent = game.CoreGui
    Gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

    local Main = Instance.new("Frame", Gui)
    Main.Size = UDim2.new(0,450,0,620)
    Main.Position = UDim2.new(0.5,-225,0.5,-310)
    Main.BackgroundColor3 = Color3.fromRGB(0,0,0)
    Main.BackgroundTransparency = 0.1

    local Border = Instance.new("UIStroke", Main)
    Border.Thickness = 5
    Border.Color = Color3.new(1,1,1)
    local Corner = Instance.new("UICorner", Main)
    Corner.CornerRadius = UDim.new(0,25)

    -- Título del Menú
    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1,0,0,50)
    Title.Position = UDim2.new(0,0,0,0)
    Title.BackgroundTransparency = 1
    Title.Text = "💜 PULSE HUB 💜"
    Title.TextColor3 = Color3.fromRGB(200,50,255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 30

    -- ScrollingFrame para los botones de funcionalidades
    local FeaturesFrame = Instance.new("ScrollingFrame", Main)
    FeaturesFrame.Size = UDim2.new(1, -20, 1, -70) -- Ajusta el tamaño para dejar espacio al título y bordes
    FeaturesFrame.Position = UDim2.new(0, 10, 0, 60) -- Posición debajo del título
    FeaturesFrame.BackgroundTransparency = 1
    FeaturesFrame.ScrollBarThickness = 8
    FeaturesFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Se ajustará dinámicamente

    local UIGrid = Instance.new("UIGridLayout", FeaturesFrame)
    UIGrid.CellSize = UDim2.new(0, 200, 0, 50) -- Tamaño de cada botón
    UIGrid.CellPadding = UDim2.new(0, 10, 0, 10) -- Espacio entre botones
    UIGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIGrid.VerticalAlignment = Enum.VerticalAlignment.Top
    UIGrid.StartCorner = Enum.StartCorner.TopLeft

    -- Variables para el estado de los hacks (ejemplo)
    local HitboxExpanderActive = false
    local WalkSpeedActive = false
    local JumpPowerActive = false
    local AntiVoidActive = false
    local KillAuraActive = false

    -- Función genérica para crear botones de toggle
    local function CreateToggleButton(parent, text, initialState, toggleCallback)
        local btn = Instance.new("TextButton", parent)
        btn.Size = UDim2.new(0, 200, 0, 50)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.BackgroundTransparency = 0.2
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 18
        btn.Text = text .. " " .. (initialState and "✅" or "❌")

        local corn = Instance.new("UICorner", btn)
        corn.CornerRadius = UDim.new(0, 8)

        btn.MouseButton1Click:Connect(function()
            initialState = not initialState
            btn.Text = text .. " " .. (initialState and "✅" or "❌")
            toggleCallback(initialState)
        end)
        return btn, initialState
    end

    -- FUNCIONES PARA LOS HACKS (EJEMPLO - AQUÍ IRÍA LA LÓGICA REAL)
    local function ToggleHitboxExpander(active)
        HitboxExpanderActive = active
        print("Hitbox Expander: " .. (active and "Activado" or "Desactivado"))
        -- Aquí iría la lógica real para activar/desactivar el hitbox expander
    end

    local function ToggleWalkSpeed(active)
        WalkSpeedActive = active
        print("WalkSpeed: " .. (active and "Activado" or "Desactivado"))
        -- Aquí iría la lógica real para activar/desactivar el walkspeed
    end
    
    local function ToggleJumpPower(active)
        JumpPowerActive = active
        print("JumpPower: " .. (active and "Activado" or "Desactivado"))
        -- Aquí iría la lógica real para activar/desactivar el jump power
    end

    local function ToggleAntiVoid(active)
        AntiVoidActive = active
        print("Anti Void / Anti Fall: " .. (active and "Activado" or "Desactivado"))
        -- Aquí iría la lógica real para activar/desactivar el anti void
    end

    local function ToggleKillAura(active)
        KillAuraActive = active
        print("Kill Aura: " .. (active and "Activado" or "Desactivado"))
        -- Aquí iría la lógica real para activar/desactivar el kill aura
    end

    -- Creando los botones de funcionalidades
    local btnHitbox, _ = CreateToggleButton(FeaturesFrame, "Hitbox Expander", HitboxExpanderActive, ToggleHitboxExpander)
    local btnWalkSpeed, _ = CreateToggleButton(FeaturesFrame, "WalkSpeed", WalkSpeedActive, ToggleWalkSpeed)
    local btnJumpPower, _ = CreateToggleButton(FeaturesFrame, "JumpPower", JumpPowerActive, ToggleJumpPower)
    local btnAntiVoid, _ = CreateToggleButton(FeaturesFrame, "Anti Void", AntiVoidActive, ToggleAntiVoid)
    local btnKillAura, _ = CreateToggleButton(FeaturesFrame, "Kill Aura", KillAuraActive, ToggleKillAura)
    
    -- Ajustar el CanvasSize del ScrollingFrame
    FeaturesFrame.CanvasSize = UDim2.new(0, 0, 0, UIGrid.AbsoluteContentSize.Y)


    -- Bucle para la animación del borde (si quieres mantenerlo)
    spawn(function()
        while wait(0.05) do
            for i=0,1,0.01 do
                Border.Color = Color3.fromHSV(i,1,1)
                wait()
            end
            -- Puedes añadir un bucle inverso para que vaya y venga si quieres un efecto "pulsante"
            for i=1,0,-0.01 do
                 Border.Color = Color3.fromHSV(i,1,1)
                 wait()
            end
        end
    end)
    
    -- El resto de tu script de login (la parte inicial)
    -- ...
end
