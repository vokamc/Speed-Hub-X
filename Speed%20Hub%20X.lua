local TweenService = game:GetService("TweenService")
local StarterGui  = game:GetService("StarterGui")

--=== 1. Cha mẹ của GUI: ưu tiên gethui() (Krnl/Synapse), fallback CoreGui ===--
local coreParent
if type(gethui) == "function" then
    coreParent = gethui()               -- exploit env
elseif game:GetService("CoreGui") then
    coreParent = game:GetService("CoreGui")
else
    coreParent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
end

-- Ẩn CoreGui thông thường (PC)
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

--=== 2. Tạo màn hình loading FULLSCREEN dưới CoreGui ===--
local gui = Instance.new("ScreenGui")
gui.Name             = "SpeedHubX_Loading"
gui.ResetOnSpawn     = false
gui.IgnoreGuiInset   = true
gui.ZIndexBehavior   = Enum.ZIndexBehavior.Global
gui.Parent           = coreParent

-- Nền đen FULL màn hình
local bg = Instance.new("Frame", gui)
bg.Size             = UDim2.new(1,0,1,0)
bg.Position         = UDim2.new(0,0,0,0)
bg.BackgroundColor3 = Color3.new(0,0,0)
bg.ZIndex           = 10^6

-- Title đỏ
local title = Instance.new("TextLabel", bg)
title.Size             = UDim2.new(1,0,0,100)
title.Position         = UDim2.new(0,0,0.35,0)
title.BackgroundTransparency = 1
title.Text             = "SPEED HUB X"
title.TextColor3       = Color3.fromRGB(255,0,0)
title.TextStrokeTransparency = 0.5
title.TextStrokeColor3 = Color3.fromRGB(0,0,0)
title.Font             = Enum.Font.GothamBlack
title.TextScaled       = true
title.ZIndex           = 10^6

-- Loading % text
local loadingText = Instance.new("TextLabel", bg)
loadingText.Size             = UDim2.new(1,0,0,50)
loadingText.Position         = UDim2.new(0,0,0.55,0)
loadingText.BackgroundTransparency = 1
loadingText.Text             = "Loading... 0%"
loadingText.TextColor3       = Color3.new(1,1,1)
loadingText.Font             = Enum.Font.Gotham
loadingText.TextScaled       = true
loadingText.ZIndex           = 10^6

--=== 3. Chạy progress và fade-out ===--
task.spawn(function()
    for i = 1, 100 do
        loadingText.Text = "Loading... "..i.."%"
        task.wait(15/100)
    end

    local ti = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    TweenService:Create(bg, ti, {BackgroundTransparency = 1}):Play()
    TweenService:Create(title, ti, {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
    TweenService:Create(loadingText, ti, {TextTransparency = 1}):Play()
    task.wait(1)

    gui:Destroy()
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)

    -- Load script chính
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
end)
