local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local Hub = Material.Load({
    Title = "WextharHub",
    Style = 1,
    SizeX = 240,
    SizeY = 300,
    Theme = "Dark",
    ColorOverrides = {
        MainFrame = Color3.fromRGB(0,0,0)
    }
})

local Farm = Hub.New({
    Title = "Farm"
})

local AutoFarmLine = Farm.Button({
    Text = "Select A Farm Option!",
    Callback = function()
    end
})

local NPCSelected;
local NPCFarm = Farm.Dropdown({
    Text = "NPC's",
    Callback = function(Name)
        NPCSelected = Name
    end,
    Options = 
    {
        "WeakGhost",    
        "EnragedGhost",
        "Crusher",
        "Cult",
        "Dimple",
        "Delin"
        }
})

local AutoFarmState;
local AutoFarm = Farm.Toggle({
    Text = "AutoFarm",
    Callback = function(Enabled)
        AutoFarmState = Enabled
        while AutoFarmState do wait(0.5)
            pcall(function()
                if Enabled == true then
                    for i,gb in next, workspace:GetDescendants() do
                        if gb:IsA("Model") and string.match(gb.Name, NPCSelected) then
                            local TweenSistem = game:GetService("TweenService")
        
                            local PRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
                            local To = {}
                            To.CFrame = gb:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 2.75, -1.5)
                            local TS = TweenInfo.new(1.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
                            local Start = TweenSistem:Create(PRoot, TS, To)
        
                            if gb:FindFirstChild("Humanoid").Health >= 0.1 then
                                Start:Play()
                                return
                            end
                        end
                    end
                end
            end)
        end
    end,
    Enabled = false
})

local AutoAttackState;
local AutoAttack = Farm.Toggle({
    Text = "AutoAttack",
    Callback = function(Enabled)
        AutoAttackState = Enabled
        pcall(function()
            while AutoAttackState do wait(.3)
                if AutoAttackState == true then
                    local AutoClick = game:GetService("VirtualInputManager")
                    AutoClick:SendMouseButtonEvent(800, 380, 0, true, game, 1)
                         wait()
                    AutoClick:SendMouseButtonEvent(800, 380, 0, false, game, 1)
                end 
            end
        end)
    end,
    Enabled = false
})

local TrainingState;
local AutoTraining = Farm.Toggle({
    Text = "AutoTraining",
    Callback = function(State)
        TrainingState = State
        pcall(function()
            while TrainingState do wait()
                if TrainingState == true then
                    local VirtualKey = game:GetService("VirtualInputManager")
                    VirtualKey:SendKeyEvent(true,"T",false,game)
                end
            end
        end)
    end,
    Enabled = false
})

local WeaponPage = Hub.New({
    Title = "Weapon's"
})

local WeaponLine = WeaponPage.Button({
    Text = "Select A Weapon!",
    Callback = function()
    end
})

local Weapon;
local WeaponName = WeaponPage.TextField({
    Text = "Weapon Name",
    Callback = function(Name)
        Weapon = Name
    end
})

local EquipState;
local AutoEquip = WeaponPage.Toggle({
    Text = "AutoEquip",
    Callback = function(State)
        EquipState = State
        pcall(function()
            game:GetService("RunService").Stepped:Connect(function()
                if EquipState == true then
                    local Plr = game:GetService("Players").LocalPlayer
                    local WeaponSelected = Plr.Backpack:FindFirstChild(Weapon)
                    if WeaponSelected then
                        Plr.Character.Humanoid:EquipTool(WeaponSelected)    
                    end
                end
            end)
        end)
    end,
    Enabled = false
})

local QuestPage = Hub.New({
    Title = "Quest's"
})

local QuestLine = QuestPage.Button({
    Text = "Select A Quest!",
    Callback = function()
    end
})

local QuestNPC;
local WeaponName = QuestPage.Dropdown({
    Text = "Quest",
    Callback = function(Name)
        QuestNPC = Name
        local Event = game:GetService("ReplicatedStorage").newQuest
        Event:FireServer()

    end,
    Options = 
    {
        "Reigen",    
        "Shiro",
        "Couple",
        "Mezato",
        "Stranger",
        "Hitoshi"
    }
})

local AutoQuestState;
local AutoQuest = QuestPage.Toggle({
    Text = "AutoQuest",
    Callback = function(State)
        AutoQuestState = State
        pcall(function()
            while AutoQuestState do wait(1)
                if AutoQuestState == true then
                    local Player = game.Players.LocalPlayer
                    for _,VerifyQuest in pairs(Player:GetChildren()) do
                        if VerifyQuest:IsA("StringValue") and VerifyQuest.Name == "TalkedTo" then
                            if VerifyQuest.Value == "" then
                                local A_1 = QuestNPC
                                local Event = game:GetService("ReplicatedStorage").newQuest
                                Event:FireServer(A_1)
                            end
                        end
                    end
                end
            end
        end)
    end,
    Enabled = false
})

local Misc = Hub.New({
    Title = "Misc"
})

local MiscLine = Misc.Button({
    Text = "Misc Options!",
    Callback = function()
    end
})


local HideName;
local HideOverHead = Misc.Toggle({
    Text = "HideName",
    Callback = function(Enabled)
        HideName = Enabled
        while HideName do wait(1.2)
            pcall(function()
                if HideName == true then
                    local Character = game:GetService("Players").LocalPlayer.Character
                    for g, gettag in pairs(Character.Head["HX"]:GetChildren()) do
                        gettag:Destroy()
                    end
                end
            end)
        end
    end,
    Enabled = false
})

local NoClipState;
local NoClip = Misc.Toggle({
    Text = "No-Clip",
    Callback = function(Enabled)
        NoClipState = Enabled
        pcall(function()
            game:GetService("RunService").Stepped:Connect(function()
                if NoClipState == true then
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
                end
            end)
        end)
    end,
    Enabled = false
})
