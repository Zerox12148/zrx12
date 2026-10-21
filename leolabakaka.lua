--[[
    LEOLABAKAKA
    Full merge of ZRX Project v3 Rivals Edition + ZeyProject v1.1
    Forced wallbang · Arrow navigation · Enemy/Ally ESP split · 3000+ lines
]]

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UIS              = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Debris           = game:GetService("Debris")
local StarterGui       = game:GetService("StarterGui")
local ReplicatedStorage= game:GetService("ReplicatedStorage")
local Lighting         = game:GetService("Lighting")
local SoundService     = game:GetService("SoundService")
local VirtualUser      = game:GetService("VirtualUser")
local HttpService      = game:GetService("HttpService")
local TeleportService  = game:GetService("TeleportService")
local PathfindingService = game:GetService("PathfindingService")
local CollectionService= game:GetService("CollectionService")
local TextService      = game:GetService("TextService")
local GuiService       = game:GetService("GuiService")
local UserInputService = UIS

local LP  = Players.LocalPlayer
local PG  = LP:WaitForChild("PlayerGui")
local CAM = workspace.CurrentCamera

local EXECUTOR = "Unknown"
pcall(function() EXECUTOR = identifyexecutor() end)

local HAS_DRAWING = pcall(function() return Drawing.new("Square") end)
local HAS_META    = pcall(function() return getrawmetatable(game) end)
local HAS_NEWC    = pcall(function() return newcclosure end)
local HAS_SETRO   = pcall(function() return setreadonly end)
local HAS_GETNAME = pcall(function() return getnamecallmethod end)
local HAS_HOOK    = pcall(function() return hookfunction end)
local HAS_GETUPV  = pcall(function() return getupvalue end)
local HAS_SETUPV  = pcall(function() return setupvalue end)
local HAS_GETCONST= pcall(function() return getconstants end)
local HAS_SETCONST= pcall(function() return setconstant end)
local HAS_CHECKCALLER = pcall(function() return checkcaller end)
local HAS_ISLUA   = pcall(function() return islclosure end)
local HAS_HOOKMETAMETHOD = pcall(function() return hookmetamethod end)

local function new(cls, props)
    local i = Instance.new(cls)
    for k, v in pairs(props or {}) do i[k] = v end
    return i
end

local P = {
    Accent     = Color3.fromRGB(0, 229, 255),
    Accent2    = Color3.fromRGB(120, 100, 255),
    Accent3    = Color3.fromRGB(255, 90, 180),
    Success    = Color3.fromRGB(80, 240, 160),
    Danger     = Color3.fromRGB(255, 85, 110),
    Warn       = Color3.fromRGB(255, 200, 90),
    BgDeep     = Color3.fromRGB(6, 8, 14),
    BgBase     = Color3.fromRGB(12, 14, 22),
    BgSide     = Color3.fromRGB(16, 18, 28),
    BgCard     = Color3.fromRGB(20, 23, 34),
    BgCardHi   = Color3.fromRGB(26, 30, 44),
    BgInput    = Color3.fromRGB(18, 21, 32),
    BgHover    = Color3.fromRGB(30, 30, 44),
    Border     = Color3.fromRGB(45, 52, 72),
    BorderSoft = Color3.fromRGB(32, 38, 55),
    Text       = Color3.fromRGB(235, 240, 252),
    TextDim    = Color3.fromRGB(150, 158, 180),
    TextFaint  = Color3.fromRGB(95, 102, 125),
    EnemyESP   = Color3.fromRGB(255, 70, 90),
    AllyESP    = Color3.fromRGB(70, 230, 140),
    NeutralESP = Color3.fromRGB(200, 200, 210),
}

local function corner(p, r)
    return new("UICorner", {CornerRadius = UDim.new(0, r or 8), Parent = p})
end

local function stroke(p, c, t, tr)
    return new("UIStroke", {
        Color = c or P.Border,
        Thickness = t or 1,
        Transparency = tr or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = p,
    })
end

local function grad(p, stops, rot)
    local keys = {}
    for _, s in ipairs(stops) do
        keys[#keys + 1] = ColorSequenceKeypoint.new(s[1], s[2])
    end
    return new("UIGradient", {
        Color = ColorSequence.new(keys),
        Rotation = rot or 90,
        Parent = p,
    })
end

----------------------------------------------------------------------
-- STATE TABLES
----------------------------------------------------------------------

local S = {
    Gui          = nil,
    Main         = nil,
    Pages        = {},
    CurrentPage  = "Combat",
    NavButtons   = {},
    Visible      = true,
    NavItems     = {},
    NavOrder     = {},
    PageOrder    = {},
    SelectedIndex= 1,
    PageIndex    = 1,
    SnowLayer    = nil,
    ToastHolder  = nil,
    StatusBar    = nil,
}

local C = {
    -- Aimbot
    Aimbot            = true,
    AimbotKey         = true,
    AimbotMaster      = true,
    AimbotSmooth      = 1,
    AimbotFOV         = 158.1,
    AimbotWallCheck   = false,   -- forced off for wallbang
    AimbotVisCheck    = false,
    AimbotPrediction  = 0.22,
    AimbotBone        = "Head",
    AimbotTeamCheck   = true,
    AimbotLockFull    = true,
    AimbotFOVCircle   = true,
    AimbotLockedTarget= nil,
    AimbotStickyRange = 9999,
    AimbotTrackSpeed  = 1,

    -- Silent
    SilentAim         = true,
    SilentAimFOV      = 900,
    SilentAimWallCheck= false,   -- forced off
    SilentAimVisCheck = false,
    SilentAimHitPart  = "Head",
    SilentAimBone     = "Head",

    -- Magic Bullet / Wallbang forced
    MagicBullet           = true,
    MagicBulletFOV        = 1200,
    MagicBulletWall       = true,  -- ALWAYS ON
    MagicBulletMultiAngle = true,
    MagicBulletAngleSpoof = true,
    MagicBulletVelocityLead = 0.18,
    MagicBulletAntiReject = true,
    MagicBulletRetryCount = 3,
    MagicBulletOcclusion  = 2.5,
    InstantHit            = true,
    Wallbang              = true,  -- always on

    -- Weapons
    NoRecoil      = true,
    NoSpread      = true,
    NoReload      = true,
    RapidFire     = true,
    RapidFireMulti= 5,
    InfiniteAmmo  = true,

    -- Auto
    AutoShoot       = true,
    AutoShootDelay  = 0.05,
    TriggerBot      = false,
    TriggerBotDelay = 0.03,
    TriggerBotFOV   = 40,
    TriggerBotHitChance = 100,
    AimAssist       = false,
    AimAssistStrength = 0.4,
    AimAssistFOV    = 150,

    -- Hitbox
    HitboxExpander     = true,
    HitboxSize         = 6,
    HitboxTransparency = 0.6,
    HitboxMega         = true,
    HitboxMegaSize     = 12,
    HitboxMegaInvisible= true,
    HitboxMegaMultiPart= true,

    -- ESP
    ESP           = true,
    ESPBox        = true,
    ESPName       = true,
    ESPHealth     = true,
    ESPDistance   = true,
    ESPTracer     = true,
    ESPSkeleton   = true,
    ESPChams      = true,
    ESPHeadDot    = true,
    ESPTeamCheck  = true,
    ESPEnemyColor = true,   -- distinct enemy color
    ESPAllyColor  = true,   -- distinct ally color
    ESPRainbow    = true,
    Radar         = true,

    -- Survival
    AutoDodge         = true,
    AutoDodgeRange    = 80,
    AutoDodgeStrength = 28,
    AutoHeal          = true,
    AutoHealThreshold = 65,
    AutoHealCooldown  = 0.4,
    ForcefieldLocal   = true,
    ForcefieldRefresh = 0.6,
    AdonisBypass      = true,
    AntiKatana        = true,
    NoKillcam         = true,
    NoFlash           = true,
    NoFog             = true,

    -- Feedback
    HitSound      = true,
    HitSoundId    = "rbxassetid://9125402735",
    HitSoundVol   = 0.5,
    KillSound     = true,
    KillSoundId   = "rbxassetid://9114653326",
    KillSoundVol  = 0.6,
    HitMarker     = true,
    DamageIndicator = true,
    KillEffect    = true,

    -- Movement / Misc
    ThirdPerson   = false,
    ThirdPersonDist = 8,
    AutoReload    = true,
    AutoPickup    = true,
    AntiAFK       = true,
    AntiVoid      = false,
    AntiVoidY     = -50,
    BunnyHop      = false,
    BhopPower     = 50,
    SilentWalk    = false,
    AutoEquipBest = false,
    BestWeaponKeyword = "gun",
    FPSUnlocker   = true,
    FPSLimit      = 240,
    FOVChanger    = false,
    FOVValue      = 90,
    SpeedHack     = false,
    SpeedValue    = 30,
    InfJump       = true,
    Noclip        = false,
    Invisible     = false,
    SpeedBoost    = false,
    FallPlayer    = false,
    FallDistance  = 6,
    SelectActive  = false,
    SnowEnabled   = true,
    SavedOutfit   = nil,
    CurrentOutfit = "default",
}

local RIV = {
    ESPObjs       = {},
    RadarGui      = nil,
    MegaHitboxes  = {},
    Hitboxes      = {},
    CameraHooked  = false,
    FireCandidates= {},
    FireRemote    = nil,
    RemoteScanned = false,
    FOVCircle     = nil,
    SkeletonCache = {},
    ChamsCache    = {},
    HitSound      = nil,
    KillSound     = nil,
    AdonisHooks   = {},
    AutoHealLast  = 0,
    ForcefieldObj = nil,
    DodgeDir      = 0,
    DodgeLast     = 0,
    MagicHits     = 0,
    LastHealth    = {},
    OriginalFOV   = 70,
}

local RIV_TARGET     = nil
local RIV_SILENT_POS = nil
local RIV_MAGIC_POS  = nil

local NEWCFG = {
    INVIS_POSITION = Vector3.new(-25.95, 84, 3537.55),
    BOOSTED_SPEED  = 48,
    SOUND_ID       = "rbxassetid://942127495",
}

local InvisState = {
    isInvisible   = false,
    isSpeedBoosted= false,
    originalSpeed = 16,
    invisChair    = nil,
    sound         = nil,
}

local FallState = {
    active      = false,
    target      = nil,
    generation  = 0,
    loopRunning = false,
    override    = false,
    currentSide = 1,
    lastSide    = 0,
    sideTimer   = 0,
    cachedWeapon= nil,
    lastError   = 0,
    orbitAngle  = 0,
}

local SelectState = {
    active    = false,
    allies    = {},
    alliesIds = {},
    scannedAt = 0,
}

----------------------------------------------------------------------
-- UTILITY HELPERS
----------------------------------------------------------------------

local function getHRP(p)
    local c = (p or LP).Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function getHum(p)
    local c = (p or LP).Character
    return c and c:FindFirstChildOfClass("Humanoid")
end

local function getHead(p)
    local c = (p or LP).Character
    return c and (c:FindFirstChild("Head") or c:FindFirstChild("head"))
end

local function isAlive(p)
    local h = getHum(p)
    return h and h.Health > 0
end

local function isRival(p)
    if not p or p == LP or not p.Character then return false end
    local h = p.Character:FindFirstChildOfClass("Humanoid")
    if not h or h.Health <= 0 then return false end
    return p.Character:FindFirstChild("HumanoidRootPart") ~= nil
end

local function sameTeam(a, b)
    if not (a and b) then return false end
    if a.Team and b.Team then return a.Team == b.Team end
    return false
end

local function isPartner(t)
    if not t then return false end
    if LP.Team and t.Team and LP.Team == t.Team then return true end
    local a = LP:GetAttribute("Team") or LP:GetAttribute("team")
    local b = t:GetAttribute("Team") or t:GetAttribute("team")
    return a and b and a == b
end

local function isAlly(p)
    if not p then return false end
    if p == LP then return true end
    if SelectState.allies[p.Name] then return true end
    if SelectState.alliesIds[p.UserId] then return true end
    return false
end

local function getBone(p, bone)
    local c = p and p.Character
    if not c then return nil end
    bone = bone or "Head"
    local b = c:FindFirstChild(bone)
    if b and b:IsA("BasePart") then return b end
    local map = {
        Head = {"Head", "head"},
        Torso = {"Torso", "UpperTorso", "Chest"},
        HumanoidRootPart = {"HumanoidRootPart", "RootPart"},
    }
    for _, n in ipairs(map[bone] or {bone}) do
        local x = c:FindFirstChild(n)
        if x and x:IsA("BasePart") then return x end
    end
    return getHRP(p)
end

-- Wall check always returns true when wallbang forced
local function hasLOS(target, wall)
    if not wall then return true end
    if C.MagicBulletWall or C.Wallbang then return true end
    local a, b = getHRP(LP), getHRP(target)
    if not (a and b) then return false end
    local pr = RaycastParams.new()
    pr.FilterType = Enum.RaycastFilterType.Exclude
    pr.FilterDescendantsInstances = {LP.Character, target.Character}
    return workspace:Raycast(a.Position, b.Position - a.Position, pr) == nil
end

local function worldToScreen(pos)
    local sp, on = CAM:WorldToViewportPoint(pos)
    if not on then return nil end
    return Vector2.new(sp.X, sp.Y), sp.Z
end

local function pushToast(title, text, color)
    if not S.ToastHolder then return end
    color = color or P.Accent
    local card = new("Frame", {
        Size = UDim2.new(0, 280, 0, 50),
        BackgroundColor3 = P.BgCard,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        LayoutOrder = 0,
        Parent = S.ToastHolder,
    })
    corner(card, 10)
    stroke(card, color, 1.2, 0.3)
    new("TextLabel", {
        Size = UDim2.new(1, -20, 0, 18),
        Position = UDim2.new(0, 14, 0, 6),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = P.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = card,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -20, 0, 20),
        Position = UDim2.new(0, 14, 0, 24),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = P.TextDim,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Parent = card,
    })
    card.Position = UDim2.new(1, 320, 0, 0)
    TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Back), {
        Position = UDim2.new(1, -300, 0, 0),
    }):Play()
    task.delay(3, function()
        if card and card.Parent then
            local tw = TweenService:Create(card, TweenInfo.new(0.3), {
                Position = UDim2.new(1, 320, 0, 0),
                BackgroundTransparency = 1,
            })
            tw:Play()
            tw.Completed:Connect(function() card:Destroy() end)
        end
    end)
end

----------------------------------------------------------------------
-- MAGIC BULLET / FIRE HOOK (WALLBANG FORCED)
----------------------------------------------------------------------

local FIRE_KW = {
    "fire", "shoot", "hit", "damage", "attack", "bullet", "spell",
    "cast", "gun", "weapon", "projectile", "ray", "beam", "shot",
    "hitmarker", "fireweapon", "weaponfire", "gunfire", "firegun",
}

local FIRE_REMOTE_NAMES = {
    "Fire", "Shoot", "FireWeapon", "WeaponFire", "GunFire",
    "FireGun", "Attack", "Hit", "Damage", "Bullet",
    "FireServer", "ShootServer", "RemoteFire", "Weapon",
}

local function scoreRemote(r)
    local s = 0
    local n = r.Name:lower()
    for _, k in ipairs(FIRE_KW) do
        if n:find(k, 1, true) then s = s + 10 end
    end
    if r:IsA("RemoteEvent") then s = s + 5 end
    if r:IsA("RemoteFunction") then s = s + 3 end
    return s
end

local function scanFireRemotes()
    RIV.FireCandidates = {}
    RIV.RemoteScanned = true
    local function scan(p, d)
        if d > 5 then return end
        for _, c in ipairs(p:GetChildren()) do
            if c:IsA("RemoteEvent") or c:IsA("RemoteFunction") then
                local s = scoreRemote(c)
                if s > 0 then
                    table.insert(RIV.FireCandidates, {remote = c, score = s})
                end
                local n = c.Name:lower()
                for _, key in ipairs(FIRE_REMOTE_NAMES) do
                    if n:find(key:lower()) then
                        if not RIV.FireRemote then RIV.FireRemote = c end
                        break
                    end
                end
            end
            pcall(scan, c, d + 1)
        end
    end
    pcall(scan, ReplicatedStorage, 0)
    pcall(scan, workspace, 0)
    pcall(scan, LP, 0)
    table.sort(RIV.FireCandidates, function(a, b) return a.score > b.score end)
    if #RIV.FireCandidates > 0 and not RIV.FireRemote then
        RIV.FireRemote = RIV.FireCandidates[1].remote
    end
end

local function getMultiAngle(target)
    if not target or not target.Character then return {} end
    local ch = target.Character
    local list = {}
    for _, n in ipairs({"Head", "UpperTorso", "Torso", "HumanoidRootPart", "LowerTorso"}) do
        local x = ch:FindFirstChild(n)
        if x and x:IsA("BasePart") then table.insert(list, x) end
    end
    return list
end

local function spoofOrigin(origin, tp, off)
    off = off or C.MagicBulletOcclusion or 2.5
    return origin + (tp - origin).Unit * off
end

local function computeLead(target, basePos)
    if not target or not target.Character then return basePos end
    local hrp = target.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return basePos end
    return basePos + hrp.AssemblyLinearVelocity * (C.MagicBulletVelocityLead or 0.18)
end

local function redirectArgs(args, target)
    if not target then return args end
    local cands = getMultiAngle(target)
    if #cands == 0 then return args end
    local mouse = UIS:GetMouseLocation()
    local best, bd = nil, math.huge
    for _, c in ipairs(cands) do
        local sp, on = CAM:WorldToViewportPoint(c.Position)
        if on then
            local d = (Vector2.new(sp.X, sp.Y) - mouse).Magnitude
            if d < bd then best, bd = c, d end
        end
    end
    best = best or cands[1]
    local tp = computeLead(target, best.Position)
    local oi, di
    for i, a in ipairs(args) do
        if typeof(a) == "Vector3" then
            if oi == nil then oi = i
            elseif di == nil then di = i; break end
        end
    end
    if not oi then return args end
    local origin = args[oi]
    -- Always wallbang: force origin near target
    if C.MagicBulletWall or C.Wallbang then
        args[oi] = tp - Vector3.new(0, 1.5, 0)
        if di then
            args[di] = Vector3.new(0, 1, 0) * 5000
        elseif args[oi + 1] and typeof(args[oi + 1]) == "Vector3" then
            args[oi + 1] = Vector3.new(0, 0, 0.01)
        end
    else
        if C.MagicBulletAngleSpoof and C.MagicBulletOcclusion > 0 then
            origin = spoofOrigin(origin, tp, C.MagicBulletOcclusion)
            args[oi] = origin
        end
        if di and typeof(args[di]) == "Vector3" then
            local m = args[di].Magnitude
            if m < 1 then m = 5000 end
            args[di] = (tp - origin).Unit * m
        elseif args[oi + 1] and typeof(args[oi + 1]) == "Vector3" then
            args[oi + 1] = (tp - origin).Unit * 5000
        else
            args[oi] = tp
        end
    end
    return args
end

local function installFireHook()
    if not (HAS_META and HAS_SETRO and HAS_NEWC and HAS_GETNAME) then return end
    if #RIV.FireCandidates == 0 then scanFireRemotes() end
    local ok, mt = pcall(getrawmetatable, game)
    if not ok or not mt then return end
    local old = mt.__namecall
    if not old then return end
    pcall(setreadonly, mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local m = getnamecallmethod()
        if m == "FireServer" or m == "InvokeServer" then
            for _, e in ipairs(RIV.FireCandidates) do
                if e.remote == self then
                    local args = {...}
                    if C.MagicBullet and RIV_MAGIC_POS and RIV_TARGET then
                        args = redirectArgs(args, RIV_TARGET)
                        RIV.MagicHits = RIV.MagicHits + 1
                        if C.MagicBulletAntiReject then
                            task.spawn(function()
                                for i = 1, C.MagicBulletRetryCount do
                                    task.wait(0.02)
                                    pcall(function() old(self, unpack(args)) end)
                                end
                            end)
                        end
                    elseif (C.SilentAim and RIV_SILENT_POS) or (C.MagicBullet and RIV_MAGIC_POS) then
                        local targetPos = RIV_MAGIC_POS or RIV_SILENT_POS
                        local originIdx, dirIdx
                        for i, a in ipairs(args) do
                            if typeof(a) == "Vector3" then
                                if originIdx == nil then originIdx = i
                                elseif dirIdx == nil then dirIdx = i; break end
                            end
                        end
                        if originIdx and dirIdx and targetPos then
                            if C.MagicBulletWall or C.Wallbang then
                                args[originIdx] = targetPos - Vector3.new(0, 2, 0)
                                args[dirIdx] = Vector3.new(0, 1, 0)
                            else
                                local origin = args[originIdx]
                                local mag = args[dirIdx].Magnitude
                                if mag < 1 then mag = 1000 end
                                args[dirIdx] = (targetPos - origin).Unit * mag
                            end
                        elseif originIdx and targetPos then
                            args[originIdx] = targetPos
                            if args[originIdx + 1] and typeof(args[originIdx + 1]) == "Vector3" then
                                args[originIdx + 1] = Vector3.new(0, 0, 0.01)
                            end
                        end
                    end
                    return old(self, unpack(args))
                end
            end
            -- also catch single FireRemote
            if RIV.FireRemote and self == RIV.FireRemote then
                local args = {...}
                local useMagic = C.MagicBullet and RIV_MAGIC_POS
                local useSilent = C.SilentAim and RIV_SILENT_POS
                local targetPos = useMagic and RIV_MAGIC_POS or (useSilent and RIV_SILENT_POS)
                if targetPos then
                    local originIdx, dirIdx
                    for i, a in ipairs(args) do
                        if typeof(a) == "Vector3" then
                            if originIdx == nil then originIdx = i
                            elseif dirIdx == nil then dirIdx = i; break end
                        end
                    end
                    if originIdx and dirIdx then
                        if C.MagicBulletWall or C.Wallbang then
                            args[originIdx] = targetPos - Vector3.new(0, 2, 0)
                            args[dirIdx] = Vector3.new(0, 1, 0)
                        else
                            local origin = args[originIdx]
                            local mag = args[dirIdx].Magnitude
                            if mag < 1 then mag = 1000 end
                            args[dirIdx] = (targetPos - origin).Unit * mag
                        end
                    elseif originIdx then
                        args[originIdx] = targetPos
                    end
                    return old(self, unpack(args))
                end
            end
        end
        return old(self, ...)
    end)
    pcall(setreadonly, mt, true)
end

local function installCameraHook()
    if RIV.CameraHooked then return end
    RIV.CameraHooked = true
    if not (HAS_META and HAS_SETRO and HAS_NEWC) then return end
    local ok, mt = pcall(getrawmetatable, CAM)
    if not ok or not mt then return end
    local old = mt.__index
    if not old then return end
    pcall(setreadonly, mt, false)
    mt.__index = newcclosure(function(self, k)
        local v = old(self, k)
        if k == "CFrame" then
            if FallState.active and FallState.target and FallState.override then
                local h = getBone(FallState.target, "Head")
                if h then return CFrame.new(v.Position, h.Position) end
            end
            if C.Aimbot and C.AimbotMaster and C.AimbotLockedTarget
                and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                local h = getBone(C.AimbotLockedTarget, C.AimbotBone)
                if h then
                    local tp = h.Position
                    if C.AimbotPrediction > 0 then
                        local hrp = getHRP(C.AimbotLockedTarget)
                        if hrp then tp = tp + hrp.AssemblyLinearVelocity * C.AimbotPrediction end
                    end
                    return CFrame.new(v.Position, tp)
                end
            end
        end
        return v
    end)
    pcall(setreadonly, mt, true)
end

----------------------------------------------------------------------
-- AIMBOT
----------------------------------------------------------------------

local function findBestTarget()
    local mouse = UIS:GetMouseLocation()
    local best, bs = nil, C.AimbotFOV
    for _, p in ipairs(Players:GetPlayers()) do
        if isRival(p) and not isPartner(p) and not sameTeam(LP, p) and not isAlly(p) then
            local part = getBone(p, C.AimbotBone)
            if part then
                local sp, on = CAM:WorldToViewportPoint(part.Position)
                if on then
                    local d = (Vector2.new(sp.X, sp.Y) - mouse).Magnitude
                    if d < bs then
                        -- wall check forced off when wallbang on
                        if not C.AimbotWallCheck or hasLOS(p, true) then
                            best, bs = p, d
                        end
                    end
                end
            end
        end
    end
    return best
end

local function getClosest(maxFOV, wc, bone)
    if C.AimbotLockedTarget and isRival(C.AimbotLockedTarget) and not isAlly(C.AimbotLockedTarget) then
        return C.AimbotLockedTarget, 0
    end
    maxFOV = maxFOV or math.huge
    local mouse = UIS:GetMouseLocation()
    local best, bs = nil, maxFOV
    for _, p in ipairs(Players:GetPlayers()) do
        if isRival(p) and not isPartner(p) and not sameTeam(LP, p) and not isAlly(p) then
            local part = getBone(p, bone)
            if part then
                local sp, on = CAM:WorldToViewportPoint(part.Position)
                if on then
                    local d = (Vector2.new(sp.X, sp.Y) - mouse).Magnitude
                    if d < bs then
                        if wc and not hasLOS(p, true) then
                            -- skip
                        else
                            best, bs = p, d
                        end
                    end
                end
            end
        end
    end
    return best, bs
end

local function getClosestToCursor(maxFOV, wallCheck, visCheck, bone)
    if FallState.active and FallState.target and FallState.override then
        local t = FallState.target
        if isRival(t) and not isAlly(t) then return t, 0 end
        return nil, math.huge
    end
    if C.AimbotLockedTarget and isRival(C.AimbotLockedTarget) and not isAlly(C.AimbotLockedTarget) then
        return C.AimbotLockedTarget, 0
    end
    maxFOV = maxFOV or math.huge
    local mouse = UIS:GetMouseLocation()
    local best, bestScore = nil, maxFOV
    for _, p in ipairs(Players:GetPlayers()) do
        if isRival(p) and not isPartner(p) and not sameTeam(LP, p) and not isAlly(p) then
            local part = getBone(p, bone)
            if part then
                local sp = worldToScreen(part.Position)
                if sp then
                    local d = (sp - mouse).Magnitude
                    if d < bestScore then
                        if wallCheck and not hasLOS(p, true) then continue end
                        if visCheck and not hasLOS(p, true) then continue end
                        best, bestScore = p, d
                    end
                end
            end
        end
    end
    return best, bestScore
end

local function aimbotStep()
    if FallState.active and FallState.target and FallState.override then
        local l = FallState.target
        if isRival(l) and not isAlly(l) then
            local h = getBone(l, "Head") or getHRP(l)
            if h then
                local tp = h.Position
                if C.AimbotPrediction > 0 then
                    local hrp = getHRP(l)
                    if hrp then tp = tp + hrp.AssemblyLinearVelocity * C.AimbotPrediction end
                end
                CAM.CFrame = CAM.CFrame:Lerp(CFrame.new(CAM.CFrame.Position, tp), 1)
                C.AimbotLockedTarget = l
                RIV_TARGET = l
                return
            end
        end
        return
    end
    if not C.AimbotMaster then
        RIV_TARGET = nil
        C.AimbotLockedTarget = nil
        return
    end
    if not C.Aimbot then
        C.AimbotLockedTarget = nil
        return
    end
    if C.AimbotKey and not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        RIV_TARGET = nil
        C.AimbotLockedTarget = nil
        return
    end
    if C.AimbotLockedTarget and (not isRival(C.AimbotLockedTarget) or isAlly(C.AimbotLockedTarget)) then
        C.AimbotLockedTarget = nil
    end
    if not C.AimbotLockedTarget or not isRival(C.AimbotLockedTarget) then
        local t = findBestTarget()
        if not t then RIV_TARGET = nil; return end
        if isPartner(t) or sameTeam(LP, t) or isAlly(t) then RIV_TARGET = nil; return end
        C.AimbotLockedTarget = t
    end
    local l = C.AimbotLockedTarget
    if not l or not isRival(l) or isAlly(l) then
        C.AimbotLockedTarget = nil
        RIV_TARGET = nil
        return
    end
    RIV_TARGET = l
    local h = getBone(l, C.AimbotBone) or getHRP(l)
    if not h then
        C.AimbotLockedTarget = nil
        RIV_TARGET = nil
        return
    end
    local goal = CFrame.new(CAM.CFrame.Position, computeLead(l, h.Position))
    if C.AimbotLockFull then
        CAM.CFrame = goal
    else
        CAM.CFrame = CAM.CFrame:Lerp(goal, math.clamp(C.AimbotSmooth, 0.01, 1))
    end
end

pcall(function()
    RunService:UnbindFromRenderStep("LEOLABAKAKA_Aimbot")
    RunService:BindToRenderStep("LEOLABAKAKA_Aimbot", Enum.RenderPriority.Camera.Value + 1, aimbotStep)
end)

----------------------------------------------------------------------
-- INVIS / SPEED / SELECT / FALL
----------------------------------------------------------------------

local function playToggleSound()
    if not InvisState.sound then
        InvisState.sound = new("Sound", {
            SoundId = NEWCFG.SOUND_ID,
            Volume = 0.5,
            Parent = PG,
        })
    end
    pcall(function() InvisState.sound:Play() end)
end

local function setCharTransparency(ch, t)
    for _, d in ipairs(ch:GetDescendants()) do
        if d:IsA("BasePart") or d:IsA("Decal") then
            pcall(function() d.Transparency = t end)
        end
    end
end

local function doSetInvisibility(state)
    if not LP.Character or state == InvisState.isInvisible then return end
    InvisState.isInvisible = state
    playToggleSound()
    if state then
        local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local saved = hrp.CFrame
        LP.Character:MoveTo(NEWCFG.INVIS_POSITION)
        task.wait(0.15)
        local seat = new("Seat", {
            Name = "invischair",
            Anchored = false,
            CanCollide = false,
            Transparency = 1,
            Position = NEWCFG.INVIS_POSITION,
            Parent = workspace,
        })
        local torso = LP.Character:FindFirstChild("Torso") or LP.Character:FindFirstChild("UpperTorso")
        if torso then
            new("Weld", {Part0 = seat, Part1 = torso, Parent = seat})
        end
        task.wait()
        seat.CFrame = saved
        InvisState.invisChair = seat
        setCharTransparency(LP.Character, 0.5)
        pushToast("Invisibilité", "ON", P.Success)
    else
        if InvisState.invisChair then pcall(function() InvisState.invisChair:Destroy() end) end
        InvisState.invisChair = nil
        local c = workspace:FindFirstChild("invischair")
        if c then pcall(function() c:Destroy() end) end
        if LP.Character then setCharTransparency(LP.Character, 0) end
        pushToast("Invisibilité", "OFF", P.Warn)
    end
end

local function doSetSpeedBoost(state)
    local h = getHum(LP)
    if not h then return end
    if state and not InvisState.isSpeedBoosted then
        InvisState.originalSpeed = h.WalkSpeed
        h.WalkSpeed = NEWCFG.BOOSTED_SPEED
        InvisState.isSpeedBoosted = true
        playToggleSound()
        pushToast("Speed Boost", "ON · " .. NEWCFG.BOOSTED_SPEED, P.Success)
    elseif not state and InvisState.isSpeedBoosted then
        h.WalkSpeed = InvisState.originalSpeed
        InvisState.isSpeedBoosted = false
        playToggleSound()
        pushToast("Speed Boost", "OFF", P.Warn)
    end
end

local function scanAllies()
    SelectState.allies = {}
    SelectState.alliesIds = {}
    local myHRP = getHRP(LP)
    if not myHRP then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            local h = getHRP(p)
            if h and (h.Position - myHRP.Position).Magnitude <= 5 then
                SelectState.allies[p.Name] = true
                SelectState.alliesIds[p.UserId] = true
            end
        end
    end
    SelectState.scannedAt = tick()
end

local function setSelect(state)
    if state == SelectState.active then return end
    C.SelectActive = state
    if state then
        SelectState.active = true
        scanAllies()
        if not (FallState.active and FallState.override) then
            RIV_TARGET = nil
            C.AimbotLockedTarget = nil
        end
        local n = 0
        for _ in pairs(SelectState.allies) do n = n + 1 end
        pushToast("Select ON", n .. " allié(s)", P.Success)
    else
        SelectState.active = false
        SelectState.allies = {}
        SelectState.alliesIds = {}
        if not (FallState.active and FallState.override) then
            RIV_TARGET = nil
            C.AimbotLockedTarget = nil
        end
        pushToast("Select OFF", "Reset", P.Warn)
    end
end

local function isPlayerAlive(p)
    if not p or not p.Parent or not p.Character then return false end
    local h = p.Character:FindFirstChildOfClass("Humanoid")
    if not h or h.Health <= 0 then return false end
    return p.Character:FindFirstChild("HumanoidRootPart") ~= nil
end

local function equipWeapon()
    local ch = LP.Character
    if not ch then return end
    local t = ch:FindFirstChildOfClass("Tool")
    if t then
        FallState.cachedWeapon = t
        return t
    end
    local h = ch:FindFirstChildOfClass("Humanoid")
    local bp = LP:FindFirstChild("Backpack")
    if bp then
        for _, x in ipairs(bp:GetChildren()) do
            if x:IsA("Tool") then
                pcall(function() h:EquipTool(x) end)
                FallState.cachedWeapon = x
                return x
            end
        end
    end
end

local function getFallTarget()
    local myHRP = getHRP(LP)
    if not myHRP then return nil end
    local best, bd = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and not isAlly(p) and isPlayerAlive(p) then
            local h = getHRP(p)
            if h then
                local d = (h.Position - myHRP.Position).Magnitude
                if d < bd then best, bd = p, d end
            end
        end
    end
    return best
end

local function randomSide()
    local s = math.random(1, 3)
    local a = 0
    while s == FallState.lastSide and a < 5 do
        s = math.random(1, 3)
        a = a + 1
    end
    FallState.lastSide = s
    return s
end

local function getSideOffset(side, dist, tHRP)
    local r = tHRP.CFrame.RightVector
    local l = tHRP.CFrame.LookVector
    if side == 1 then return r * -dist
    elseif side == 2 then return r * dist
    else return l * -dist end
end

local fallConn
local function stopFall()
    if fallConn then pcall(function() fallConn:Disconnect() end); fallConn = nil end
    FallState.loopRunning = false
    FallState.override = false
    FallState.active = false
    FallState.target = nil
    C.AimbotLockedTarget = nil
    RIV_TARGET = nil
end

local function fallLoop()
    if fallConn then pcall(function() fallConn:Disconnect() end) end
    FallState.generation = FallState.generation + 1
    local g = FallState.generation
    FallState.loopRunning = true
    FallState.active = true
    fallConn = RunService.RenderStepped:Connect(function(dt)
        if FallState.generation ~= g then stopFall(); return end
        if not C.FallPlayer or not FallState.active then stopFall(); return end
        pcall(function()
            local myHRP = getHRP(LP)
            if not myHRP then FallState.override = false; return end
            if FallState.target and (not FallState.target.Parent or not isPlayerAlive(FallState.target) or isAlly(FallState.target)) then
                FallState.target = nil
                FallState.override = false
            end
            if not FallState.target then
                FallState.target = getFallTarget()
                FallState.currentSide = randomSide()
                FallState.sideTimer = 0
            end
            local t = FallState.target
            if not t or not t.Parent then FallState.override = false; return end
            local tHRP = getHRP(t)
            local tHead = getBone(t, "Head")
            if not tHRP then FallState.target = nil; FallState.override = false; return end
            equipWeapon()
            FallState.override = true
            FallState.sideTimer = FallState.sideTimer + dt
            if FallState.sideTimer >= 0.08 then
                FallState.currentSide = randomSide()
                FallState.sideTimer = 0
            end
            local d = C.FallDistance or 6
            local off = getSideOffset(FallState.currentSide, d, tHRP)
            local face = tHead or tHRP
            local pred = tHRP.Position + tHRP.AssemblyLinearVelocity * 0.04
            local tp = pred + off
            tp = Vector3.new(tp.X, tHRP.Position.Y + 1, tp.Z)
            pcall(function() myHRP.CFrame = CFrame.new(tp, face.Position) end)
            if CAM then pcall(function() CAM.CFrame = CFrame.new(CAM.CFrame.Position, face.Position) end) end
            C.AimbotLockedTarget = t
            RIV_TARGET = t
        end)
    end)
end

local function forceResetFall()
    FallState.generation = FallState.generation + 1
    FallState.lastSide = 0
    FallState.currentSide = 1
    FallState.sideTimer = 0
    stopFall()
    C.FallPlayer = false
    C.AimbotLockedTarget = nil
    RIV_TARGET = nil
    pushToast("Fall Player", "RESET", P.Warn)
end

local function setFall(state)
    state = state and true or false
    if state == C.FallPlayer and state == FallState.active then return end
    C.FallPlayer = state
    if state then
        FallState.generation = FallState.generation + 1
        FallState.active = true
        FallState.target = nil
        FallState.loopRunning = false
        FallState.override = false
        FallState.lastSide = 0
        FallState.currentSide = randomSide()
        FallState.sideTimer = 0
        fallLoop()
        pushToast("Fall Player", "ACTIVÉ", P.Success)
    else
        FallState.generation = FallState.generation + 1
        stopFall()
        pushToast("Fall Player", "DÉSACTIVÉ", P.Warn)
    end
end

scanFireRemotes()
installFireHook()
installCameraHook()

----------------------------------------------------------------------
-- FOV CIRCLE
----------------------------------------------------------------------

if HAS_DRAWING then
    RIV.FOVCircle = Drawing.new("Circle")
    RIV.FOVCircle.Thickness = 1.5
    RIV.FOVCircle.Color = P.Accent
    RIV.FOVCircle.Filled = false
    RIV.FOVCircle.NumSides = 60
    RIV.FOVCircle.Radius = C.AimbotFOV
    RIV.FOVCircle.Visible = false
    RunService.RenderStepped:Connect(function()
        if not RIV.FOVCircle then return end
        local show = false
        if not (FallState.active and FallState.override) then
            if C.Aimbot and C.AimbotMaster and C.AimbotFOVCircle then show = true end
        end
        if show then
            RIV.FOVCircle.Visible = true
            RIV.FOVCircle.Position = Vector2.new(CAM.ViewportSize.X / 2, CAM.ViewportSize.Y / 2)
            RIV.FOVCircle.Radius = C.AimbotFOV
            RIV.FOVCircle.Color = P.Accent
        else
            RIV.FOVCircle.Visible = false
        end
    end)
end

----------------------------------------------------------------------
-- AUTO SHOOT / TRIGGER / ASSIST / SILENT / MAGIC LOOPS
----------------------------------------------------------------------

task.spawn(function()
    while true do
        task.wait(C.AutoShootDelay)
        if not C.AutoShoot or not C.AimbotMaster then continue end
        local t = getClosest(C.AimbotFOV, C.AimbotWallCheck, C.AimbotBone)
        if not t then continue end
        local tool = LP.Character and LP.Character:FindFirstChildOfClass("Tool")
        if tool then pcall(function() tool:Activate() end) end
    end
end)

task.spawn(function()
    while true do
        task.wait(C.TriggerBotDelay)
        if not C.TriggerBot then continue end
        if math.random(100) > C.TriggerBotHitChance then continue end
        local t = getClosest(C.TriggerBotFOV, false, "Head")
        if not t then continue end
        local tool = LP.Character and LP.Character:FindFirstChildOfClass("Tool")
        if tool then pcall(function() tool:Activate() end) end
    end
end)

RunService.RenderStepped:Connect(function()
    if not C.AimAssist then return end
    local t = getClosest(C.AimAssistFOV, false, "Head")
    if not t then return end
    local h = getBone(t, "Head")
    if not h then return end
    CAM.CFrame = CAM.CFrame:Lerp(CFrame.new(CAM.CFrame.Position, h.Position), C.AimAssistStrength * 0.15)
end)

RunService.RenderStepped:Connect(function()
    if not C.SilentAim then RIV_SILENT_POS = nil; return end
    local t = getClosest(C.SilentAimFOV, C.SilentAimWallCheck, C.SilentAimHitPart)
    if t then
        local h = getBone(t, C.SilentAimHitPart)
        if h then RIV_SILENT_POS = h.Position end
    else
        RIV_SILENT_POS = nil
    end
end)

RunService.RenderStepped:Connect(function()
    if not C.MagicBullet then RIV_MAGIC_POS = nil; return end
    local t = getClosest(C.MagicBulletFOV, false, "Head")
    if t then
        local h = getBone(t, "Head")
        if h then RIV_MAGIC_POS = h.Position end
    else
        RIV_MAGIC_POS = nil
    end
end)

----------------------------------------------------------------------
-- FORCEFIELD / AUTO HEAL / AUTO DODGE / ANTI KATANA
----------------------------------------------------------------------

task.spawn(function()
    while true do
        task.wait(C.ForcefieldRefresh)
        if C.ForcefieldLocal and LP.Character then
            if not (RIV.ForcefieldObj and RIV.ForcefieldObj.Parent == LP.Character) then
                RIV.ForcefieldObj = new("ForceField", {
                    Name = "LEOLABAKAKA_FF",
                    Visible = false,
                    Parent = LP.Character,
                })
            end
        elseif RIV.ForcefieldObj and RIV.ForcefieldObj.Parent then
            RIV.ForcefieldObj:Destroy()
            RIV.ForcefieldObj = nil
        end
    end
end)

local HEAL_KW = {"heal", "med", "bandage", "health", "potion", "kit", "revive", "syringe", "injector"}

local function findHealTool()
    local ch = LP.Character
    if ch then
        for _, t in ipairs(ch:GetChildren()) do
            if t:IsA("Tool") then
                local n = t.Name:lower()
                for _, k in ipairs(HEAL_KW) do
                    if n:find(k, 1, true) then return t end
                end
            end
        end
    end
    local bp = LP:FindFirstChild("Backpack")
    if bp then
        for _, t in ipairs(bp:GetChildren()) do
            if t:IsA("Tool") then
                local n = t.Name:lower()
                for _, k in ipairs(HEAL_KW) do
                    if n:find(k, 1, true) then return t end
                end
            end
        end
    end
end

task.spawn(function()
    while true do
        task.wait(0.1)
        if not C.AutoHeal then continue end
        local h = getHum()
        if not h or h.Health <= 0 then continue end
        if h.Health / h.MaxHealth * 100 > C.AutoHealThreshold then continue end
        if tick() - RIV.AutoHealLast < C.AutoHealCooldown then continue end
        local tool = findHealTool()
        if tool then
            if tool.Parent ~= LP.Character then
                pcall(function() h:EquipTool(tool) end)
                task.wait(0.08)
            end
            pcall(function() tool:Activate() end)
            RIV.AutoHealLast = tick()
        end
    end
end)

local function detectThreat()
    local myHRP = getHRP(LP)
    if not myHRP then return nil end
    local myPos = myHRP.Position
    local best, bd = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if isRival(p) and not isPartner(p) and not sameTeam(LP, p) and not isAlly(p) then
            local hrp = getHRP(p)
            if hrp then
                local d = (hrp.Position - myPos).Magnitude
                if d <= C.AutoDodgeRange and d < bd then
                    local dot = hrp.CFrame.LookVector:Dot((myPos - hrp.Position).Unit)
                    if dot > 0.85 then best, bd = p, d end
                end
            end
        end
    end
    return best
end

task.spawn(function()
    while true do
        task.wait(0.08)
        if not C.AutoDodge then continue end
        local threat = detectThreat()
        if not threat then continue end
        local h = getHum()
        local myHRP = getHRP(LP)
        local tHRP = getHRP(threat)
        if not (h and myHRP and tHRP) then continue end
        if tick() - RIV.DodgeLast > 0.15 then
            RIV.DodgeDir = (math.random() > 0.5) and 1 or -1
            RIV.DodgeLast = tick()
        end
        local right = tHRP.CFrame.RightVector * RIV.DodgeDir
        pcall(function() h:Move(right * C.AutoDodgeStrength, false) end)
    end
end)

local function hasKatana(p)
    if not p or not p.Character then return false end
    for _, t in ipairs(p.Character:GetChildren()) do
        if t:IsA("Tool") and (t.Name:lower():find("katana") or t.Name:lower():find("sword")
            or t.Name:lower():find("blade") or t.Name:lower():find("saber")) then
            return true
        end
    end
    local bp = p:FindFirstChild("Backpack")
    if bp then
        for _, t in ipairs(bp:GetChildren()) do
            if t:IsA("Tool") and (t.Name:lower():find("katana") or t.Name:lower():find("blade")) then
                return true
            end
        end
    end
    return false
end

task.spawn(function()
    while true do
        task.wait(0.1)
        if not C.AntiKatana then continue end
        if RIV_TARGET and hasKatana(RIV_TARGET) then
            if C.AimbotLockedTarget == RIV_TARGET then C.AimbotLockedTarget = nil end
            RIV_SILENT_POS = nil
            RIV_MAGIC_POS = nil
        end
    end
end)

----------------------------------------------------------------------
-- ADONIS BYPASS
----------------------------------------------------------------------

local ADONIS_KW = {
    "adonis", "anticheat", "detected", "kick", "ban", "exploit",
    "cheat", "suspicious", "report", "flag", "watchdog", "sentry",
}

local function isAdonisRemote(name)
    local n = name:lower()
    for _, k in ipairs(ADONIS_KW) do
        if n:find(k, 1, true) then return true end
    end
    return false
end

local function installAdonis()
    if not (HAS_META and HAS_SETRO and HAS_NEWC and HAS_GETNAME) then return end
    RIV.AdonisHooks = {}
    local function scan(p, d)
        if d > 5 then return end
        for _, c in ipairs(p:GetChildren()) do
            if (c:IsA("RemoteEvent") or c:IsA("RemoteFunction")) and isAdonisRemote(c.Name) then
                table.insert(RIV.AdonisHooks, c)
            end
            pcall(scan, c, d + 1)
        end
    end
    pcall(scan, ReplicatedStorage, 0)
    pcall(scan, workspace, 0)
    local ok, mt = pcall(getrawmetatable, game)
    if not ok or not mt then return end
    local old = mt.__namecall
    if not old then return end
    pcall(setreadonly, mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local m = getnamecallmethod()
        if m == "FireServer" or m == "InvokeServer" then
            for _, r in ipairs(RIV.AdonisHooks) do
                if r == self then return nil end
            end
        end
        return old(self, ...)
    end)
    pcall(setreadonly, mt, true)
    pcall(function()
        if _G.Adonis then
            if _G.Adonis.Detected then _G.Adonis.Detected = function() end end
            if _G.Adonis.Kick then _G.Adonis.Kick = function() end end
        end
        if _G.AdonisAC then
            if _G.AdonisAC.Detected then _G.AdonisAC.Detected = function() end end
            if _G.AdonisAC.Kick then _G.AdonisAC.Kick = function() end end
        end
    end)
    pushToast("Anti-Cheat", #RIV.AdonisHooks .. " remotes bypass", P.Success)
end

task.spawn(installAdonis)

----------------------------------------------------------------------
-- HIT / KILL SOUNDS + MARKERS + DAMAGE INDICATOR
----------------------------------------------------------------------

if not RIV.HitSound then
    RIV.HitSound = new("Sound", {
        SoundId = C.HitSoundId,
        Volume = C.HitSoundVol,
        Parent = SoundService,
    })
end
if not RIV.KillSound then
    RIV.KillSound = new("Sound", {
        SoundId = C.KillSoundId,
        Volume = C.KillSoundVol,
        Parent = SoundService,
    })
end

local hmHolder = new("ScreenGui", {
    Name = "LEOLABAKAKA_HitMarkers",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 9999,
    Parent = PG,
})

local function spawnHitMarker()
    if not C.HitMarker then return end
    local m = new("Frame", {
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(0.5, -12, 0.5, -12),
        BackgroundTransparency = 1,
        Parent = hmHolder,
    })
    for i = 1, 4 do
        local a = math.rad((i - 1) * 90 + 45)
        local l = new("Frame", {
            Size = UDim2.new(0, 2, 0, 8),
            BackgroundColor3 = P.Danger,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, math.cos(a) * 8, 0.5, math.sin(a) * 8),
            Parent = m,
        })
        TweenService:Create(l, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            Position = UDim2.new(0.5, math.cos(a) * 14, 0.5, math.sin(a) * 14),
            BackgroundTransparency = 1,
        }):Play()
    end
    task.delay(0.2, function() if m and m.Parent then m:Destroy() end end)
end

local function spawnDmgLabel(amount, pos)
    if not C.DamageIndicator or not pos then return end
    local lbl = new("TextLabel", {
        Size = UDim2.new(0, 60, 0, 24),
        Position = UDim2.new(0, pos.X - 30, 0, pos.Y - 20),
        BackgroundTransparency = 1,
        Text = tostring(math.floor(amount)),
        TextColor3 = P.Warn,
        Font = Enum.Font.GothamBlack,
        TextSize = 18,
        TextStrokeTransparency = 0,
        TextStrokeColor3 = Color3.new(0, 0, 0),
        Parent = hmHolder,
    })
    TweenService:Create(lbl, TweenInfo.new(0.8), {
        Position = UDim2.new(0, pos.X - 30, 0, pos.Y - 60),
        TextTransparency = 1,
        TextStrokeTransparency = 1,
    }):Play()
    task.delay(0.9, function() if lbl and lbl.Parent then lbl:Destroy() end end)
end

task.spawn(function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            local h = getHum(p)
            if h then RIV.LastHealth[p] = h.Health end
        end
    end
end)

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(ch)
        task.wait(0.5)
        local h = ch:FindFirstChildOfClass("Humanoid")
        if h then RIV.LastHealth[p] = h.Health end
    end)
end)

task.spawn(function()
    while true do
        task.wait(0.05)
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and isRival(p) then
                local h = getHum(p)
                if h then
                    local last = RIV.LastHealth[p] or h.Health
                    if h.Health < last - 1 then
                        local dmg = last - h.Health
                        if C.HitSound and RIV.HitSound then
                            RIV.HitSound.SoundId = C.HitSoundId
                            RIV.HitSound.Volume = C.HitSoundVol
                            pcall(function() RIV.HitSound:Play() end)
                        end
                        spawnHitMarker()
                        local head = getBone(p, "Head")
                        if head then
                            local sp, on = CAM:WorldToViewportPoint(head.Position)
                            if on then spawnDmgLabel(dmg, Vector2.new(sp.X, sp.Y)) end
                        end
                    end
                    if h.Health <= 0 and last > 0 then
                        if C.KillSound and RIV.KillSound then
                            RIV.KillSound.SoundId = C.KillSoundId
                            RIV.KillSound.Volume = C.KillSoundVol
                            pcall(function() RIV.KillSound:Play() end)
                        end
                        if C.KillEffect then
                            local hrp = getHRP(p)
                            if hrp then
                                pcall(function()
                                    local att = new("Attachment", {Parent = hrp})
                                    local em = new("ParticleEmitter", {
                                        Parent = att,
                                        Rate = 0,
                                        Lifetime = NumberRange.new(0.5, 1),
                                        Speed = NumberRange.new(15, 25),
                                        SpreadAngle = Vector2.new(180, 180),
                                        Color = ColorSequence.new(P.Danger, P.Accent3),
                                        Size = NumberSequence.new(0.4, 0),
                                        Transparency = NumberSequence.new(0, 1),
                                        LightEmission = 1,
                                    })
                                    em:Emit(30)
                                    Debris:AddItem(att, 2)
                                end)
                            end
                        end
                    end
                    RIV.LastHealth[p] = h.Health
                end
            end
        end
    end
end)

----------------------------------------------------------------------
-- ANTI AFK / ANTI VOID / BHOP / SILENTWALK / INF JUMP
----------------------------------------------------------------------

LP.Idled:Connect(function()
    if not C.AntiAFK then return end
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

task.spawn(function()
    while true do
        task.wait(0.3)
        if not C.AntiVoid then continue end
        local myHRP = getHRP(LP)
        if not myHRP then continue end
        if myHRP.Position.Y < C.AntiVoidY then
            local sp = workspace:FindFirstChildOfClass("SpawnLocation")
            if sp then pcall(function() myHRP.CFrame = sp.CFrame + Vector3.new(0, 5, 0) end) end
        end
    end
end)

UIS.JumpRequest:Connect(function()
    if C.InfJump then
        local h = getHum()
        if h then pcall(function() h:ChangeState(Enum.HumanoidStateType.Jumping) end) end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.05)
        if not C.BunnyHop then continue end
        local h = getHum()
        local hrp = getHRP(LP)
        if h and hrp then
            local st = h:GetState()
            if st == Enum.HumanoidStateType.Landed or st == Enum.HumanoidStateType.Running then
                pcall(function() h.JumpPower = C.BhopPower end)
                pcall(function() h:ChangeState(Enum.HumanoidStateType.Jumping) end)
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        if not C.SilentWalk then continue end
        if LP.Character then
            for _, d in ipairs(LP.Character:GetDescendants()) do
                if d:IsA("Sound") and (d.Name:lower():find("step") or d.Name:lower():find("walk")) then
                    d.Volume = 0
                end
            end
        end
    end
end)

----------------------------------------------------------------------
-- AUTO PICKUP / RELOAD / EQUIP
----------------------------------------------------------------------

task.spawn(function()
    while true do
        task.wait(0.4)
        if not C.AutoPickup then continue end
        local myHRP = getHRP(LP)
        if not myHRP then continue end
        for _, d in ipairs(workspace:GetDescendants()) do
            if d:IsA("BasePart") and (d.Name:lower():find("pickup") or d.Name:lower():find("loot")) then
                if (d.Position - myHRP.Position).Magnitude < 8 then
                    pcall(function()
                        firetouchinterest(myHRP, d, 0)
                        firetouchinterest(myHRP, d, 1)
                    end)
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.15)
        if not C.AutoReload then continue end
        local ch = LP.Character
        if not ch then continue end
        local tool = ch:FindFirstChildOfClass("Tool")
        if tool then
            for _, prop in ipairs({"Ammo", "CurrentAmmo", "Clip", "Magazine"}) do
                local v = tool[prop]
                if type(v) == "number" and v <= 1 then
                    pcall(function()
                        if tool.Reload then tool.Reload() end
                        tool:Activate()
                    end)
                    break
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1.5)
        if not C.AutoEquipBest then continue end
        local h = getHum()
        if not h then continue end
        local ch = LP.Character
        local cur = ch and ch:FindFirstChildOfClass("Tool")
        local kw = C.BestWeaponKeyword:lower()
        local bp = LP:FindFirstChild("Backpack")
        if bp then
            for _, t in ipairs(bp:GetChildren()) do
                if t:IsA("Tool") and t.Name:lower():find(kw, 1, true) then
                    if not cur or cur.Name ~= t.Name then
                        pcall(function() h:EquipTool(t) end)
                    end
                    break
                end
            end
        end
    end
end)

----------------------------------------------------------------------
-- THIRD PERSON / LIGHTING / FPS
----------------------------------------------------------------------

task.spawn(function()
    while true do
        task.wait(0.1)
        if not C.ThirdPerson then continue end
        local myHRP = getHRP(LP)
        if not myHRP then continue end
        CAM.CameraSubject = myHRP
        LP.CameraMaxZoomDistance = 500
        LP.CameraMinZoomDistance = C.ThirdPersonDist
        pcall(function() LP.CameraMode = Enum.CameraMode.Classic end)
    end
end)

local function applyLighting()
    if C.NoFlash then
        pcall(function() Lighting.Brightness = math.min(Lighting.Brightness, 2) end)
        pcall(function() Lighting.ExposureCompensation = math.clamp(Lighting.ExposureCompensation, -1, 0) end)
    end
    if C.NoFog then
        pcall(function()
            Lighting.FogEnd = 1e6
            Lighting.FogStart = 0
        end)
        for _, e in ipairs(Lighting:GetChildren()) do
            if e:IsA("Atmosphere") then e.Density = 0 end
        end
    end
end

task.spawn(function()
    while true do
        task.wait(2)
        applyLighting()
    end
end)

if C.FPSUnlocker then
    pcall(function()
        if setfpscap then setfpscap(C.FPSLimit) end
    end)
end

----------------------------------------------------------------------
-- WEAPON HOOKS
----------------------------------------------------------------------

local hookedWeapons = {}

local function hookWeapon(w)
    if hookedWeapons[w] then return end
    hookedWeapons[w] = true
    local function apply()
        for _, prop in ipairs({
            "Recoil", "RecoilX", "RecoilY", "Spread", "SpreadX", "SpreadY",
            "CameraShake", "Shake", "Kick", "Kickback",
        }) do
            pcall(function()
                if w[prop] ~= nil and (C.NoRecoil or C.NoSpread) then
                    w[prop] = 0
                end
            end)
        end
        for _, prop in ipairs({"ReloadTime", "ReloadSpeed", "ReloadDuration"}) do
            pcall(function()
                if w[prop] ~= nil and C.NoReload then w[prop] = 0 end
            end)
        end
        for _, prop in ipairs({"FireRate", "FireDelay", "Cooldown", "Debounce"}) do
            pcall(function()
                if w[prop] ~= nil and C.RapidFire then
                    w[prop] = w[prop] / math.max(1, C.RapidFireMulti)
                end
            end)
        end
        for _, prop in ipairs({"Ammo", "MaxAmmo", "ClipSize", "Magazine", "CurrentAmmo"}) do
            pcall(function()
                if w[prop] ~= nil and C.InfiniteAmmo then w[prop] = 9999 end
            end)
        end
    end
    apply()
    pcall(function()
        w.ChildAdded:Connect(function() task.wait(0.05); apply() end)
        w:GetPropertyChangedSignal("Parent"):Connect(function() task.wait(0.05); apply() end)
    end)
end

local function scanWeapons()
    pcall(function()
        for _, c in ipairs(CAM:GetChildren()) do
            if c.Name:lower():find("weapon") or c.Name:lower():find("gun")
                or c.Name:lower():find("tool") or c.Name:lower():find("viewmodel") then
                hookWeapon(c)
                for _, d in ipairs(c:GetDescendants()) do
                    if d:IsA("Model") or d:IsA("Folder") then hookWeapon(d) end
                end
            end
        end
    end)
    pcall(function()
        local ch = LP.Character
        if ch then
            for _, t in ipairs(ch:GetChildren()) do
                if t:IsA("Tool") then hookWeapon(t) end
            end
        end
    end)
    pcall(function()
        local bp = LP:FindFirstChild("Backpack")
        if bp then
            for _, t in ipairs(bp:GetChildren()) do
                if t:IsA("Tool") then hookWeapon(t) end
            end
        end
    end)
end

task.spawn(function()
    while true do
        task.wait(1)
        scanWeapons()
    end
end)

----------------------------------------------------------------------
-- HITBOX EXPANDER + MEGA
----------------------------------------------------------------------

task.spawn(function()
    while true do
        task.wait(0.2)
        if C.HitboxExpander then
            for _, p in ipairs(Players:GetPlayers()) do
                if isRival(p) and not isPartner(p) and not sameTeam(LP, p) and not isAlly(p) then
                    local ch = p.Character
                    if ch then
                        for _, part in ipairs(ch:GetChildren()) do
                            if part:IsA("BasePart")
                                and (part.Name == "Head" or part.Name == "Torso"
                                or part.Name == "UpperTorso" or part.Name == "HumanoidRootPart") then
                                if not RIV.Hitboxes[part] then
                                    RIV.Hitboxes[part] = {
                                        Size = part.Size,
                                        Transparency = part.Transparency,
                                        CanCollide = part.CanCollide,
                                        Massless = part.Massless,
                                    }
                                end
                                pcall(function()
                                    part.Size = Vector3.new(C.HitboxSize, C.HitboxSize, C.HitboxSize)
                                    part.Transparency = C.HitboxTransparency
                                    part.CanCollide = false
                                    part.Massless = true
                                end)
                            end
                        end
                    end
                end
            end
        else
            for part, d in pairs(RIV.Hitboxes) do
                if part and part.Parent then
                    pcall(function()
                        part.Size = d.Size
                        part.Transparency = d.Transparency
                        part.CanCollide = d.CanCollide
                        part.Massless = d.Massless
                    end)
                end
                RIV.Hitboxes[part] = nil
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.25)
        if C.HitboxMega then
            for _, p in ipairs(Players:GetPlayers()) do
                if isRival(p) and not isPartner(p) and not sameTeam(LP, p) and not isAlly(p) then
                    local ch = p.Character
                    if ch then
                        local parts = C.HitboxMegaMultiPart
                            and {"Head", "UpperTorso", "Torso", "HumanoidRootPart", "LowerTorso"}
                            or {"HumanoidRootPart"}
                        for _, n in ipairs(parts) do
                            local part = ch:FindFirstChild(n)
                            if part and part:IsA("BasePart") then
                                if not RIV.MegaHitboxes[part] then
                                    RIV.MegaHitboxes[part] = {
                                        Size = part.Size,
                                        Transparency = part.Transparency,
                                        CanCollide = part.CanCollide,
                                        Massless = part.Massless,
                                    }
                                end
                                pcall(function()
                                    part.Size = Vector3.new(C.HitboxMegaSize, C.HitboxMegaSize, C.HitboxMegaSize)
                                    part.Transparency = C.HitboxMegaInvisible and 1 or 0.5
                                    part.CanCollide = false
                                    part.Massless = true
                                end)
                            end
                        end
                    end
                end
            end
        else
            for part, d in pairs(RIV.MegaHitboxes) do
                if part and part.Parent then
                    pcall(function()
                        part.Size = d.Size
                        part.Transparency = d.Transparency
                        part.CanCollide = d.CanCollide
                        part.Massless = d.Massless
                    end)
                end
                RIV.MegaHitboxes[part] = nil
            end
        end
    end
end)

----------------------------------------------------------------------
-- MISC LOOPS (FOV / SPEED / NOCLIP)
----------------------------------------------------------------------

task.spawn(function()
    while true do
        task.wait(0.1)
        if C.FOVChanger then CAM.FieldOfView = C.FOVValue end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if C.SpeedHack then
            local h = getHum()
            if h and h.WalkSpeed ~= C.SpeedValue then h.WalkSpeed = C.SpeedValue end
        end
    end
end)

RunService.Stepped:Connect(function()
    if not C.Noclip then return end
    local ch = LP.Character
    if not ch then return end
    for _, p in ipairs(ch:GetDescendants()) do
        if p:IsA("BasePart") then
            p.CanCollide = false
            p.CanTouch = false
            p.CanQuery = false
        end
    end
end)

----------------------------------------------------------------------
-- ESP — ENEMY vs ALLY DISTINCT
----------------------------------------------------------------------

local function createESP(plr)
    if plr == LP or RIV.ESPObjs[plr] then return end
    if not HAS_DRAWING then return end
    local box = Drawing.new("Square")
    box.Thickness = 2; box.Filled = false; box.Visible = false
    local bg = Drawing.new("Square")
    bg.Thickness = 4; bg.Filled = false; bg.Visible = false; bg.Transparency = 0.85
    local nameBg = Drawing.new("Square")
    nameBg.Thickness = 1; nameBg.Filled = true; nameBg.Visible = false
    nameBg.Color = Color3.new(0, 0, 0); nameBg.Transparency = 0.4
    local name = Drawing.new("Text")
    name.Center = true; name.Outline = true; name.Size = 15; name.Visible = false; name.Font = 2
    local dist = Drawing.new("Text")
    dist.Center = true; dist.Outline = true; dist.Size = 13; dist.Visible = false; dist.Font = 2
    local hbBg = Drawing.new("Square")
    hbBg.Thickness = 1; hbBg.Filled = true; hbBg.Visible = false
    hbBg.Color = Color3.fromRGB(20, 20, 30); hbBg.Transparency = 0.15
    local hb = Drawing.new("Square")
    hb.Thickness = 1; hb.Filled = true; hb.Visible = false
    local tr = Drawing.new("Line")
    tr.Thickness = 1.5; tr.Visible = false
    local hd = Drawing.new("Circle")
    hd.Thickness = 2; hd.Filled = true; hd.NumSides = 16; hd.Radius = 5; hd.Visible = false
    local chams = Drawing.new("Square")
    chams.Thickness = 1; chams.Filled = true
    chams.Color = P.Accent; chams.Transparency = 0.78; chams.Visible = false
    local c1 = Drawing.new("Line"); c1.Thickness = 2; c1.Visible = false
    local c2 = Drawing.new("Line"); c2.Thickness = 2; c2.Visible = false
    local c3 = Drawing.new("Line"); c3.Thickness = 2; c3.Visible = false
    local c4 = Drawing.new("Line"); c4.Thickness = 2; c4.Visible = false
    -- Ally specific
    local allyTag = Drawing.new("Text")
    allyTag.Center = true; allyTag.Outline = true; allyTag.Size = 12; allyTag.Visible = false; allyTag.Font = 2
    RIV.ESPObjs[plr] = {
        Box = box, BoxGlow = bg, NameBg = nameBg, Name = name, Dist = dist,
        HPBarBg = hbBg, HPBar = hb, Tracer = tr, HeadDot = hd, Chams = chams,
        Corner1 = c1, Corner2 = c2, Corner3 = c3, Corner4 = c4,
        AllyTag = allyTag,
    }
end

local function removeESP(plr)
    local e = RIV.ESPObjs[plr]
    if e then
        for _, d in pairs(e) do pcall(function() d:Remove() end) end
    end
    RIV.ESPObjs[plr] = nil
end

local function hideESP(e)
    pcall(function()
        e.Box.Visible = false; e.BoxGlow.Visible = false; e.NameBg.Visible = false
        e.Name.Visible = false; e.Dist.Visible = false; e.HPBarBg.Visible = false
        e.HPBar.Visible = false; e.Tracer.Visible = false; e.HeadDot.Visible = false
        e.Chams.Visible = false; e.Corner1.Visible = false; e.Corner2.Visible = false
        e.Corner3.Visible = false; e.Corner4.Visible = false
        if e.AllyTag then e.AllyTag.Visible = false end
    end)
end

for _, p in ipairs(Players:GetPlayers()) do createESP(p) end
Players.PlayerAdded:Connect(function(p)
    task.wait(1)
    if p and p.Parent then createESP(p) end
end)
Players.PlayerRemoving:Connect(function(p) removeESP(p) end)

RunService.RenderStepped:Connect(function()
    if not HAS_DRAWING then return end
    if not C.ESP then
        for _, e in pairs(RIV.ESPObjs) do hideESP(e) end
        return
    end
    local cam = workspace.CurrentCamera
    if not cam then return end
    local myHRP = getHRP(LP)
    local myPos = myHRP and myHRP.Position

    for plr, e in pairs(RIV.ESPObjs) do
        local ok = pcall(function() return e.Box.Visible end)
        if not ok then RIV.ESPObjs[plr] = nil; continue end

        local ally = isAlly(plr) or isPartner(plr) or sameTeam(LP, plr)
        local rival = isRival(plr)

        if not rival and not ally then
            hideESP(e)
            continue
        end

        -- Team check: hide allies only if ESPTeamCheck and not ally-color mode
        if C.ESPTeamCheck and ally and not C.ESPAllyColor then
            hideESP(e)
            continue
        end

        local ch = plr.Character
        local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
        local head = ch and ch:FindFirstChild("Head")
        local hum = ch and ch:FindFirstChildOfClass("Humanoid")
        if not (hrp and head and hum and hum.Health > 0) then
            hideESP(e)
            continue
        end

        local hp, hon = cam:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
        local fp, fon = cam:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
        if not (hon or fon) then
            hideESP(e)
            continue
        end

        local h = math.abs(hp.Y - fp.Y)
        local w = h / 2
        local boxX = hp.X - w / 2
        local boxY = hp.Y

        -- Distinct colors
        local col
        if ally then
            col = C.ESPAllyColor and P.AllyESP or P.NeutralESP
        else
            col = C.ESPEnemyColor and P.EnemyESP or P.Danger
        end

        if C.ESPChams then
            pcall(function()
                e.Chams.Size = Vector2.new(w + 8, h + 8)
                e.Chams.Position = Vector2.new(boxX - 4, boxY - 4)
                if ally then
                    e.Chams.Color = P.AllyESP
                elseif C.ESPRainbow then
                    e.Chams.Color = Color3.fromHSV((tick() * 0.3) % 1, 0.6, 1)
                else
                    e.Chams.Color = col
                end
                e.Chams.Visible = true
            end)
        else
            pcall(function() e.Chams.Visible = false end)
        end

        if C.ESPBox then
            pcall(function()
                e.BoxGlow.Size = Vector2.new(w + 4, h + 4)
                e.BoxGlow.Position = Vector2.new(boxX - 2, boxY - 2)
                e.BoxGlow.Color = ally and P.AllyESP or (C.ESPRainbow and Color3.fromHSV((tick() * 0.4) % 1, 1, 1) or col)
                e.BoxGlow.Visible = true
                e.Box.Size = Vector2.new(w, h)
                e.Box.Position = Vector2.new(boxX, boxY)
                e.Box.Color = col
                e.Box.Visible = true
            end)
            local cLen = w * 0.25
            pcall(function()
                e.Corner1.From = Vector2.new(boxX, boxY)
                e.Corner1.To = Vector2.new(boxX + cLen, boxY)
                e.Corner1.Color = col; e.Corner1.Visible = true
                e.Corner2.From = Vector2.new(boxX, boxY)
                e.Corner2.To = Vector2.new(boxX, boxY + cLen)
                e.Corner2.Color = col; e.Corner2.Visible = true
                e.Corner3.From = Vector2.new(boxX + w, boxY + h)
                e.Corner3.To = Vector2.new(boxX + w - cLen, boxY + h)
                e.Corner3.Color = col; e.Corner3.Visible = true
                e.Corner4.From = Vector2.new(boxX + w, boxY + h)
                e.Corner4.To = Vector2.new(boxX + w, boxY + h - cLen)
                e.Corner4.Color = col; e.Corner4.Visible = true
            end)
        else
            pcall(function()
                e.Box.Visible = false; e.BoxGlow.Visible = false
                e.Corner1.Visible = false; e.Corner2.Visible = false
                e.Corner3.Visible = false; e.Corner4.Visible = false
            end)
        end

        if C.ESPName then
            pcall(function()
                e.Name.Text = plr.Name
                e.Name.Position = Vector2.new(hp.X, boxY - 22)
                e.Name.Color = ally and P.AllyESP or P.Text
                e.Name.Visible = true
                e.NameBg.Size = Vector2.new(w + 30, 18)
                e.NameBg.Position = Vector2.new(hp.X - (w + 30) / 2, boxY - 28)
                e.NameBg.Visible = true
            end)
        else
            pcall(function() e.Name.Visible = false; e.NameBg.Visible = false end)
        end

        if ally and e.AllyTag then
            pcall(function()
                e.AllyTag.Text = "[ALLY]"
                e.AllyTag.Position = Vector2.new(hp.X, boxY - 38)
                e.AllyTag.Color = P.AllyESP
                e.AllyTag.Visible = true
            end)
        elseif e.AllyTag then
            pcall(function() e.AllyTag.Visible = false end)
        end

        if C.ESPHealth then
            local ratio = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
            pcall(function()
                e.HPBarBg.Size = Vector2.new(6, h + 2)
                e.HPBarBg.Position = Vector2.new(boxX - 9, boxY - 1)
                e.HPBarBg.Visible = true
                e.HPBar.Size = Vector2.new(4, h * ratio)
                e.HPBar.Position = Vector2.new(boxX - 8, boxY + h * (1 - ratio))
                if ally then
                    e.HPBar.Color = P.AllyESP
                elseif ratio > 0.6 then
                    e.HPBar.Color = Color3.fromRGB(120, 230, 160)
                elseif ratio > 0.3 then
                    e.HPBar.Color = Color3.fromRGB(255, 200, 110)
                else
                    e.HPBar.Color = Color3.fromRGB(255, 100, 120)
                end
                e.HPBar.Visible = true
            end)
        else
            pcall(function() e.HPBar.Visible = false; e.HPBarBg.Visible = false end)
        end

        if C.ESPDistance and myPos then
            pcall(function()
                local d = (hrp.Position - myPos).Magnitude
                e.Dist.Text = string.format("[%.0fm]", d)
                e.Dist.Position = Vector2.new(hp.X, boxY + h + 4)
                e.Dist.Color = ally and P.AllyESP or P.TextDim
                e.Dist.Visible = true
            end)
        else
            pcall(function() e.Dist.Visible = false end)
        end

        if C.ESPTracer and not ally then
            pcall(function()
                e.Tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                e.Tracer.To = Vector2.new(hp.X, hp.Y)
                e.Tracer.Color = col
                e.Tracer.Visible = true
            end)
        else
            pcall(function() e.Tracer.Visible = false end)
        end

        if C.ESPHeadDot then
            pcall(function()
                e.HeadDot.Position = Vector2.new(hp.X, hp.Y)
                e.HeadDot.Color = ally and P.AllyESP or P.Warn
                e.HeadDot.Visible = true
            end)
        else
            pcall(function() e.HeadDot.Visible = false end)
        end
    end
end)

----------------------------------------------------------------------
-- SKELETON ESP
----------------------------------------------------------------------

local SK_BONES = {
    {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"},
    {"LeftLowerArm", "LeftHand"}, {"UpperTorso", "RightUpperArm"},
    {"RightUpperArm", "RightLowerArm"}, {"RightLowerArm", "RightHand"},
    {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"},
    {"LeftLowerLeg", "LeftFoot"}, {"LowerTorso", "RightUpperLeg"},
    {"RightUpperLeg", "RightLowerLeg"}, {"RightLowerLeg", "RightFoot"},
}

local skLines = {}

local function ensureSk(plr)
    if skLines[plr] then return skLines[plr] end
    if not HAS_DRAWING then return nil end
    local lines = {}
    for i = 1, #SK_BONES do
        local l = Drawing.new("Line")
        l.Thickness = 1.5
        l.Visible = false
        l.Color = P.Accent
        lines[i] = l
    end
    skLines[plr] = lines
    return lines
end

RunService.RenderStepped:Connect(function()
    if not HAS_DRAWING then return end
    if not (C.ESP and C.ESPSkeleton) then
        for _, lines in pairs(skLines) do
            for _, l in ipairs(lines) do pcall(function() l.Visible = false end) end
        end
        return
    end
    local cam = workspace.CurrentCamera
    if not cam then return end
    for plr, _ in pairs(RIV.ESPObjs) do
        local ally = isAlly(plr) or isPartner(plr) or sameTeam(LP, plr)
        if isRival(plr) or ally then
            local lines = ensureSk(plr)
            if lines then
                local ch = plr.Character
                for i, pair in ipairs(SK_BONES) do
                    local a = ch and ch:FindFirstChild(pair[1])
                    local b = ch and ch:FindFirstChild(pair[2])
                    if a and b and a:IsA("BasePart") and b:IsA("BasePart") then
                        local ap, aon = cam:WorldToViewportPoint(a.Position)
                        local bp, bon = cam:WorldToViewportPoint(b.Position)
                        if aon and bon then
                            pcall(function()
                                lines[i].From = Vector2.new(ap.X, ap.Y)
                                lines[i].To = Vector2.new(bp.X, bp.Y)
                                if ally then
                                    lines[i].Color = P.AllyESP
                                else
                                    lines[i].Color = Color3.fromHSV((tick() * 0.3 + i * 0.05) % 1, 0.7, 1)
                                end
                                lines[i].Visible = true
                            end)
                        else
                            pcall(function() lines[i].Visible = false end)
                        end
                    else
                        pcall(function() lines[i].Visible = false end)
                    end
                end
            end
        else
            local lines = skLines[plr]
            if lines then
                for _, l in ipairs(lines) do pcall(function() l.Visible = false end) end
            end
        end
    end
end)

----------------------------------------------------------------------
-- RADAR
----------------------------------------------------------------------

local function buildRadar()
    if RIV.RadarGui and RIV.RadarGui.Parent then return end
    local g = new("ScreenGui", {
        Name = "LEOLABAKAKA_Radar",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 998,
        Parent = PG,
    })
    RIV.RadarGui = g
    local frame = new("Frame", {
        Size = UDim2.new(0, 200, 0, 200),
        Position = UDim2.new(1, -220, 0, 20),
        BackgroundColor3 = P.BgBase,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        Parent = g,
    })
    corner(frame, 14)
    stroke(frame, P.Border, 1, 0.3)
    grad(frame, {{0, P.BgBase}, {1, P.BgDeep}}, 135)
    new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 22),
        Position = UDim2.new(0, 0, 0, 6),
        BackgroundTransparency = 1,
        Text = "RADAR",
        TextColor3 = P.Accent,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        Parent = frame,
    })
    local center = new("Frame", {
        Size = UDim2.new(0, 6, 0, 6),
        Position = UDim2.new(0.5, -3, 0.5, -3),
        BackgroundColor3 = P.Accent,
        BorderSizePixel = 0,
        Parent = frame,
    })
    corner(center, 3)
    stroke(center, P.Accent2, 1, 0)
    task.spawn(function()
        while g.Parent do
            task.wait(0.1)
            for _, c in ipairs(frame:GetChildren()) do
                if c:IsA("Frame") and c ~= center then c:Destroy() end
            end
            if C.Radar then
                local myHRP = getHRP(LP)
                if myHRP then
                    for _, p in ipairs(Players:GetPlayers()) do
                        if isRival(p) and not isPartner(p) and not sameTeam(LP, p) and not isAlly(p) then
                            local hrp = getHRP(p)
                            if hrp then
                                local rel = hrp.Position - myHRP.Position
                                local scale = 180 / 300
                                local x = math.clamp(100 + rel.X * scale, 6, 194)
                                local z = math.clamp(100 + rel.Z * scale, 26, 194)
                                local dot = new("Frame", {
                                    Size = UDim2.new(0, 6, 0, 6),
                                    Position = UDim2.new(0, x, 0, z),
                                    BackgroundColor3 = P.Danger,
                                    BorderSizePixel = 0,
                                    Parent = frame,
                                })
                                corner(dot, 3)
                                stroke(dot, P.Danger, 1, 0.5)
                            end
                        elseif isAlly(p) then
                            local hrp = getHRP(p)
                            if hrp then
                                local rel = hrp.Position - myHRP.Position
                                local scale = 180 / 300
                                local x = math.clamp(100 + rel.X * scale, 6, 194)
                                local z = math.clamp(100 + rel.Z * scale, 26, 194)
                                local dot = new("Frame", {
                                    Size = UDim2.new(0, 6, 0, 6),
                                    Position = UDim2.new(0, x, 0, z),
                                    BackgroundColor3 = P.AllyESP,
                                    BorderSizePixel = 0,
                                    Parent = frame,
                                })
                                corner(dot, 3)
                                stroke(dot, P.AllyESP, 1, 0.5)
                            end
                        end
                    end
                end
            end
        end
    end)
end

----------------------------------------------------------------------
-- OUTFITS
----------------------------------------------------------------------

local OUTFITS = {
    {name = "Default", userId = 1},
    {name = "Noob", userId = 261},
    {name = "Builderman", userId = 156},
    {name = "Shedletsky", userId = 261},
    {name = "Pink Girl", userId = 124322466},
    {name = "Red Ninja", userId = 19578790},
    {name = "Black Suit", userId = 7},
}

local function applyOutfit(uid)
    pcall(function()
        local d = Players:GetHumanoidDescriptionFromUserId(uid)
        local h = getHum(LP)
        if h and d then h:ApplyDescription(d) end
    end)
end

local function resetOutfit()
    pcall(function()
        local d = Players:GetHumanoidDescriptionFromUserId(LP.UserId)
        local h = getHum(LP)
        if h and d then h:ApplyDescription(d) end
    end)
end

local function saveOutfit()
    pcall(function()
        local h = getHum(LP)
        if h then C.SavedOutfit = h:GetAppliedDescription() end
    end)
end

local function loadOutfit()
    if not C.SavedOutfit then return end
    pcall(function()
        local h = getHum(LP)
        if h then h:ApplyDescription(C.SavedOutfit) end
    end)
end

----------------------------------------------------------------------
-- UI COMPONENTS
----------------------------------------------------------------------

local function makeNavItem(parent, label, pageId, order)
    local btn = new("TextButton", {
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = P.BgCard,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = order,
        Parent = parent,
    })
    corner(btn, 10)
    local bar = new("Frame", {
        Size = UDim2.new(0, 3, 0, 0),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = P.Accent,
        BorderSizePixel = 0,
        Parent = btn,
    })
    corner(bar, 2)
    local lbl = new("TextLabel", {
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3 = P.TextDim,
        Font = Enum.Font.GothamMedium,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = btn,
    })
    local function setActive(active)
        if active then
            TweenService:Create(btn, TweenInfo.new(0.25), {BackgroundTransparency = 0.7}):Play()
            TweenService:Create(bar, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 3, 0, 22)}):Play()
            TweenService:Create(lbl, TweenInfo.new(0.2), {TextColor3 = P.Accent}):Play()
        else
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            TweenService:Create(bar, TweenInfo.new(0.2), {Size = UDim2.new(0, 3, 0, 0)}):Play()
            TweenService:Create(lbl, TweenInfo.new(0.2), {TextColor3 = P.TextDim}):Play()
        end
    end
    btn.MouseEnter:Connect(function()
        if S.CurrentPage ~= pageId then
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.85}):Play()
            TweenService:Create(lbl, TweenInfo.new(0.15), {TextColor3 = P.Text}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if S.CurrentPage ~= pageId then
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
            TweenService:Create(lbl, TweenInfo.new(0.15), {TextColor3 = P.TextDim}):Play()
        end
    end)
    btn.MouseButton1Click:Connect(function()
        S.CurrentPage = pageId
        for id, fn in pairs(S.NavButtons) do fn(id == pageId) end
        for name, pg in pairs(S.Pages) do pg.frame.Visible = (name == pageId) end
        S.SelectedIndex = 1
    end)
    S.NavButtons[pageId] = setActive
    S.NavOrder[#S.NavOrder + 1] = {btn = btn, page = pageId}
    return btn
end

local function makeSection(parent, order, text)
    local h = new("Frame", {
        Size = UDim2.new(1, 0, 0, 26),
        BackgroundTransparency = 1,
        LayoutOrder = order,
        Parent = parent,
    })
    local dot = new("Frame", {
        Size = UDim2.new(0, 6, 0, 6),
        Position = UDim2.new(0, 2, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = P.Accent,
        BorderSizePixel = 0,
        Parent = h,
    })
    corner(dot, 3)
    stroke(dot, P.Accent2, 1, 0)
    new("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        BackgroundTransparency = 1,
        Text = string.upper(text),
        TextColor3 = P.TextFaint,
        Font = Enum.Font.GothamBold,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = h,
    })
    new("Frame", {
        Size = UDim2.new(1, -20, 0, 1),
        Position = UDim2.new(0, 16, 1, -1),
        BackgroundColor3 = P.BorderSoft,
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        Parent = h,
    })
end

local function makeToggle(parent, order, label, desc, getter, setter)
    local card = new("TextButton", {
        Size = UDim2.new(1, 0, 0, 52),
        BackgroundColor3 = P.BgCard,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = order,
        Parent = parent,
    })
    corner(card, 12)
    stroke(card, P.BorderSoft, 1, 0.3)
    local acc = new("Frame", {
        Size = UDim2.new(0, 3, 0, 28),
        Position = UDim2.new(0, 14, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = getter() and P.Accent or P.TextFaint,
        BorderSizePixel = 0,
        Parent = card,
    })
    corner(acc, 2)
    new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 16),
        Position = UDim2.new(0, 28, 0, 8),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3 = P.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = card,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -100, 0, 14),
        Position = UDim2.new(0, 28, 0, 26),
        BackgroundTransparency = 1,
        Text = desc or "",
        TextColor3 = P.TextFaint,
        Font = Enum.Font.Gotham,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = card,
    })
    local pill = new("Frame", {
        Size = UDim2.new(0, 38, 0, 20),
        Position = UDim2.new(1, -52, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = getter() and P.Accent or P.Border,
        BorderSizePixel = 0,
        Parent = card,
    })
    corner(pill, 10)
    local knob = new("Frame", {
        Size = UDim2.new(0, 16, 0, 16),
        Position = getter() and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Parent = pill,
    })
    corner(knob, 8)
    local function refresh()
        local on = getter()
        acc.BackgroundColor3 = on and P.Accent or P.TextFaint
        TweenService:Create(pill, TweenInfo.new(0.2), {
            BackgroundColor3 = on and P.Accent or P.Border,
        }):Play()
        TweenService:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
            Position = on and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
        }):Play()
    end
    card.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.15), {
            BackgroundColor3 = P.BgCardHi,
            BackgroundTransparency = 0.05,
        }):Play()
    end)
    card.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.15), {
            BackgroundColor3 = P.BgCard,
            BackgroundTransparency = 0.15,
        }):Play()
    end)
    card.MouseButton1Click:Connect(function()
        setter(not getter())
        refresh()
    end)
    table.insert(S.NavItems, {
        card = card,
        refresh = refresh,
        setter = setter,
        getter = getter,
    })
    return card
end

local function makeSlider(parent, order, label, minV, maxV, getter, setter)
    local card = new("Frame", {
        Size = UDim2.new(1, 0, 0, 52),
        BackgroundColor3 = P.BgCard,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        LayoutOrder = order,
        Parent = parent,
    })
    corner(card, 12)
    stroke(card, P.BorderSoft, 1, 0.3)
    new("TextLabel", {
        Size = UDim2.new(0, 160, 0, 14),
        Position = UDim2.new(0, 20, 0, 8),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3 = P.TextDim,
        Font = Enum.Font.GothamBold,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = card,
    })
    local val = new("TextLabel", {
        Size = UDim2.new(0, 80, 0, 14),
        Position = UDim2.new(1, -90, 0, 8),
        BackgroundTransparency = 1,
        Text = tostring(getter()),
        TextColor3 = P.Accent,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = card,
    })
    local trackBg = new("Frame", {
        Size = UDim2.new(1, -48, 0, 6),
        Position = UDim2.new(0, 24, 0, 34),
        BackgroundColor3 = P.BorderSoft,
        BorderSizePixel = 0,
        Parent = card,
    })
    corner(trackBg, 3)
    local ratio = math.clamp((getter() - minV) / (maxV - minV), 0, 1)
    local fill = new("Frame", {
        Size = UDim2.new(ratio, 0, 1, 0),
        BackgroundColor3 = P.Accent,
        BorderSizePixel = 0,
        Parent = trackBg,
    })
    corner(fill, 3)
    local knob = new("Frame", {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(ratio, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Parent = trackBg,
    })
    corner(knob, 7)
    stroke(knob, P.Accent, 2, 0)
    local hit = new("TextButton", {
        Size = UDim2.new(1, -48, 0, 24),
        Position = UDim2.new(0, 24, 0, 20),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        Parent = card,
    })
    local dragging = false
    local function apply(xAbs)
        local tp = trackBg.AbsolutePosition.X
        local tw = trackBg.AbsoluteSize.X
        if tw <= 0 then return end
        local r = math.clamp((xAbs - tp) / tw, 0, 1)
        local v = minV + r * (maxV - minV)
        v = math.floor(v * 10 + 0.5) / 10
        setter(v)
        knob.Position = UDim2.new(r, 0, 0.5, 0)
        fill.Size = UDim2.new(r, 0, 1, 0)
        val.Text = tostring(v)
    end
    hit.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            apply(input.Position.X)
        end
    end)
    hit.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            apply(input.Position.X)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    table.insert(S.NavItems, {
        card = card,
        step = function(dir)
            local v = getter() + dir * ((maxV - minV) / 20)
            v = math.clamp(v, minV, maxV)
            v = math.floor(v * 10 + 0.5) / 10
            setter(v)
            local r = (v - minV) / (maxV - minV)
            knob.Position = UDim2.new(r, 0, 0.5, 0)
            fill.Size = UDim2.new(r, 0, 1, 0)
            val.Text = tostring(v)
        end,
    })
    return card
end

local function makeButton(parent, order, label, desc, color, onClick)
    local card = new("TextButton", {
        Size = UDim2.new(1, 0, 0, 52),
        BackgroundColor3 = P.BgCard,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = order,
        Parent = parent,
    })
    corner(card, 12)
    stroke(card, P.BorderSoft, 1, 0.3)
    new("Frame", {
        Size = UDim2.new(0, 3, 0, 28),
        Position = UDim2.new(0, 14, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = color or P.Accent,
        BorderSizePixel = 0,
        Parent = card,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -60, 0, 16),
        Position = UDim2.new(0, 28, 0, 8),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3 = P.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = card,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -60, 0, 14),
        Position = UDim2.new(0, 28, 0, 26),
        BackgroundTransparency = 1,
        Text = desc or "",
        TextColor3 = P.TextFaint,
        Font = Enum.Font.Gotham,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = card,
    })
    card.MouseButton1Click:Connect(onClick)
    table.insert(S.NavItems, {
        card = card,
        action = function() onClick() end,
    })
    return card
end

----------------------------------------------------------------------
-- BUILD UI
----------------------------------------------------------------------

local function buildUI()
    local gui = new("ScreenGui", {
        Name = "LEOLABAKAKA",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 999,
        Parent = PG,
    })
    S.Gui = gui

    local main = new("Frame", {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = P.BgBase,
        BorderSizePixel = 0,
        Active = true,
        Draggable = true,
        ClipsDescendants = true,
        Parent = gui,
    })
    corner(main, 16)
    stroke(main, P.Border, 1.2, 0.2)
    S.Main = main

    local toastHolder = new("Frame", {
        Size = UDim2.new(0, 320, 1, -40),
        Position = UDim2.new(1, -340, 0, 20),
        BackgroundTransparency = 1,
        ZIndex = 100,
        Parent = gui,
    })
    new("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        Parent = toastHolder,
    })
    S.ToastHolder = toastHolder

    local side = new("Frame", {
        Size = UDim2.new(0, 210, 1, 0),
        BackgroundColor3 = P.BgSide,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        ZIndex = 10,
        Parent = main,
    })
    corner(side, 16)
    stroke(side, P.BorderSoft, 1, 0.5)

    local header = new("Frame", {
        Size = UDim2.new(1, 0, 0, 78),
        BackgroundTransparency = 1,
        ZIndex = 11,
        Parent = side,
    })
    local logoBox = new("Frame", {
        Size = UDim2.new(0, 42, 0, 42),
        Position = UDim2.new(0, 18, 0, 18),
        BackgroundColor3 = P.Accent,
        BorderSizePixel = 0,
        ZIndex = 12,
        Parent = header,
    })
    corner(logoBox, 12)
    grad(logoBox, {{0, P.Accent}, {1, P.Accent2}}, 45)
    stroke(logoBox, P.Accent3, 1, 0.4)
    new("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "L",
        TextColor3 = Color3.new(1, 1, 1),
        Font = Enum.Font.GothamBlack,
        TextSize = 22,
        ZIndex = 13,
        Parent = logoBox,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -80, 0, 20),
        Position = UDim2.new(0, 70, 0, 20),
        BackgroundTransparency = 1,
        Text = "leolabakaka",
        TextColor3 = P.Text,
        Font = Enum.Font.GothamBlack,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 12,
        Parent = header,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -80, 0, 14),
        Position = UDim2.new(0, 70, 0, 40),
        BackgroundTransparency = 1,
        Text = "v1 · " .. EXECUTOR,
        TextColor3 = P.TextFaint,
        Font = Enum.Font.Gotham,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 12,
        Parent = header,
    })

    local nav = new("ScrollingFrame", {
        Size = UDim2.new(1, -20, 1, -160),
        Position = UDim2.new(0, 10, 0, 90),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = P.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ZIndex = 12,
        Parent = side,
    })
    new("UIListLayout", {
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = nav,
    })

    local pageHolder = new("Frame", {
        Size = UDim2.new(1, -230, 1, -40),
        Position = UDim2.new(0, 220, 0, 20),
        BackgroundTransparency = 1,
        ZIndex = 15,
        Parent = main,
    })

    local function addPage(id, title)
        local f = new("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = P.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false,
            ZIndex = 15,
            Parent = pageHolder,
        })
        local tr = new("Frame", {
            Size = UDim2.new(1, 0, 0, 34),
            BackgroundTransparency = 1,
            Parent = f,
        })
        new("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = title,
            TextColor3 = P.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 20,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = tr,
        })
        local list = new("Frame", {
            Size = UDim2.new(1, -20, 0, 0),
            Position = UDim2.new(0, 0, 0, 44),
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y,
            ZIndex = 16,
            Parent = f,
        })
        new("UIListLayout", {
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = list,
        })
        S.Pages[id] = {frame = f, list = list}
        table.insert(S.PageOrder, id)
        return list
    end

    local order = 0
    local function nextOrder() order = order + 1; return order end

    makeNavItem(nav, "Combat", "Combat", nextOrder())
    makeNavItem(nav, "ESP", "ESP", nextOrder())
    makeNavItem(nav, "Rivals", "Rivals", nextOrder())
    makeNavItem(nav, "New", "New", nextOrder())
    makeNavItem(nav, "Outfit", "Outfit", nextOrder())
    makeNavItem(nav, "Misc", "Misc", nextOrder())

    -- COMBAT PAGE
    local combat = addPage("Combat", "Combat")
    local o = 0
    local function co() o = o + 1; return o end

    makeSection(combat, co(), "Aimbot")
    makeToggle(combat, co(), "Aimbot", "Lock tête", function() return C.Aimbot end, function(v) C.Aimbot = v end)
    makeToggle(combat, co(), "Aimbot Key LMB", "Clic gauche", function() return C.AimbotKey end, function(v) C.AimbotKey = v end)
    makeToggle(combat, co(), "Aimbot Master U", "Touche U", function() return C.AimbotMaster end, function(v) C.AimbotMaster = v end)
    makeToggle(combat, co(), "Lock Full", "Instantané", function() return C.AimbotLockFull end, function(v) C.AimbotLockFull = v end)
    makeSlider(combat, co(), "Smooth", 0.05, 1.1, function() return C.AimbotSmooth end, function(v) C.AimbotSmooth = v end)
    makeSlider(combat, co(), "FOV", 50, 1500, function() return C.AimbotFOV end, function(v) C.AimbotFOV = v end)
    makeToggle(combat, co(), "Wall Check", "OFF = wallbang", function() return C.AimbotWallCheck end, function(v) C.AimbotWallCheck = v end)
    makeSlider(combat, co(), "Prediction", 0, 0.5, function() return C.AimbotPrediction end, function(v) C.AimbotPrediction = v end)
    makeToggle(combat, co(), "FOV Circle", "Cercle", function() return C.AimbotFOVCircle end, function(v) C.AimbotFOVCircle = v end)

    makeSection(combat, co(), "Silent Aim")
    makeToggle(combat, co(), "Silent Aim", "Silencieux", function() return C.SilentAim end, function(v) C.SilentAim = v end)
    makeSlider(combat, co(), "Silent FOV", 100, 1500, function() return C.SilentAimFOV end, function(v) C.SilentAimFOV = v end)
    makeToggle(combat, co(), "Silent Wall Check", "OFF = wallbang", function() return C.SilentAimWallCheck end, function(v) C.SilentAimWallCheck = v end)

    makeSection(combat, co(), "Magic Bullet / Wallbang")
    makeToggle(combat, co(), "Magic Bullet", "Multi-angle", function() return C.MagicBullet end, function(v) C.MagicBullet = v end)
    makeSlider(combat, co(), "Magic FOV", 100, 2000, function() return C.MagicBulletFOV end, function(v) C.MagicBulletFOV = v end)
    makeToggle(combat, co(), "Wallbang", "À travers TOUS les murs", function() return C.MagicBulletWall end, function(v) C.MagicBulletWall = v; C.Wallbang = v end)
    makeToggle(combat, co(), "Angle Spoof", "Simule LOS", function() return C.MagicBulletAngleSpoof end, function(v) C.MagicBulletAngleSpoof = v end)
    makeSlider(combat, co(), "Occlusion Offset", 0, 10, function() return C.MagicBulletOcclusion end, function(v) C.MagicBulletOcclusion = v end)
    makeSlider(combat, co(), "Velocity Lead", 0, 0.5, function() return C.MagicBulletVelocityLead end, function(v) C.MagicBulletVelocityLead = v end)
    makeToggle(combat, co(), "Anti-Reject", "Retry", function() return C.MagicBulletAntiReject end, function(v) C.MagicBulletAntiReject = v end)
    makeToggle(combat, co(), "Instant Hit", "Balles instantanées", function() return C.InstantHit end, function(v) C.InstantHit = v end)

    makeSection(combat, co(), "Armes")
    makeToggle(combat, co(), "No Recoil", "Sans recul", function() return C.NoRecoil end, function(v) C.NoRecoil = v end)
    makeToggle(combat, co(), "No Spread", "Sans spread", function() return C.NoSpread end, function(v) C.NoSpread = v end)
    makeToggle(combat, co(), "No Reload", "Recharge instant", function() return C.NoReload end, function(v) C.NoReload = v end)
    makeToggle(combat, co(), "Rapid Fire", "Tire vite", function() return C.RapidFire end, function(v) C.RapidFire = v end)
    makeSlider(combat, co(), "Rapid Multi", 1, 10, function() return C.RapidFireMulti end, function(v) C.RapidFireMulti = v end)
    makeToggle(combat, co(), "Infinite Ammo", "Munitions ∞", function() return C.InfiniteAmmo end, function(v) C.InfiniteAmmo = v end)

    makeSection(combat, co(), "Auto")
    makeToggle(combat, co(), "Auto Shoot", "Auto tire", function() return C.AutoShoot end, function(v) C.AutoShoot = v end)
    makeToggle(combat, co(), "Trigger Bot", "Trigger", function() return C.TriggerBot end, function(v) C.TriggerBot = v end)
    makeSlider(combat, co(), "Trigger Hit%", 0, 100, function() return C.TriggerBotHitChance end, function(v) C.TriggerBotHitChance = v end)
    makeToggle(combat, co(), "Aim Assist", "Assistant", function() return C.AimAssist end, function(v) C.AimAssist = v end)

    makeSection(combat, co(), "Hitbox Mega")
    makeToggle(combat, co(), "Hitbox Expander", "Agrandit", function() return C.HitboxExpander end, function(v) C.HitboxExpander = v end)
    makeToggle(combat, co(), "Hitbox Mega", "Max", function() return C.HitboxMega end, function(v) C.HitboxMega = v end)
    makeSlider(combat, co(), "Mega Size", 4, 25, function() return C.HitboxMegaSize end, function(v) C.HitboxMegaSize = v end)
    makeToggle(combat, co(), "Invisible Hitbox", "Cache", function() return C.HitboxMegaInvisible end, function(v) C.HitboxMegaInvisible = v end)

    -- ESP PAGE
    local esp = addPage("ESP", "ESP")
    o = 0
    makeSection(esp, co(), "ESP")
    makeToggle(esp, co(), "ESP Enable", "ESP", function() return C.ESP end, function(v) C.ESP = v end)
    makeToggle(esp, co(), "Box", "Cadre", function() return C.ESPBox end, function(v) C.ESPBox = v end)
    makeToggle(esp, co(), "Name", "Nom", function() return C.ESPName end, function(v) C.ESPName = v end)
    makeToggle(esp, co(), "Health", "HP", function() return C.ESPHealth end, function(v) C.ESPHealth = v end)
    makeToggle(esp, co(), "Distance", "Dist", function() return C.ESPDistance end, function(v) C.ESPDistance = v end)
    makeToggle(esp, co(), "Tracer", "Ligne (ennemis)", function() return C.ESPTracer end, function(v) C.ESPTracer = v end)
    makeToggle(esp, co(), "Skeleton", "Squelette", function() return C.ESPSkeleton end, function(v) C.ESPSkeleton = v end)
    makeToggle(esp, co(), "Chams", "Fond", function() return C.ESPChams end, function(v) C.ESPChams = v end)
    makeToggle(esp, co(), "Head Dot", "Dot", function() return C.ESPHeadDot end, function(v) C.ESPHeadDot = v end)
    makeToggle(esp, co(), "Enemy Color", "Rouge ennemis", function() return C.ESPEnemyColor end, function(v) C.ESPEnemyColor = v end)
    makeToggle(esp, co(), "Ally Color", "Vert alliés", function() return C.ESPAllyColor end, function(v) C.ESPAllyColor = v end)
    makeToggle(esp, co(), "Rainbow", "RGB ennemis", function() return C.ESPRainbow end, function(v) C.ESPRainbow = v end)
    makeToggle(esp, co(), "Team Check", "Ignore alliés (si Ally Color OFF)", function() return C.ESPTeamCheck end, function(v) C.ESPTeamCheck = v end)
    makeToggle(esp, co(), "Radar", "Minimap", function() return C.Radar end, function(v) C.Radar = v end)

    -- RIVALS PAGE
    local rivals = addPage("Rivals", "Rivals")
    o = 0
    makeSection(rivals, co(), "Survival")
    makeToggle(rivals, co(), "Forcefield", "FF visuel", function() return C.ForcefieldLocal end, function(v) C.ForcefieldLocal = v end)
    makeToggle(rivals, co(), "Auto-Heal", "Spam heal", function() return C.AutoHeal end, function(v) C.AutoHeal = v end)
    makeSlider(rivals, co(), "Heal Threshold %", 10, 100, function() return C.AutoHealThreshold end, function(v) C.AutoHealThreshold = v end)
    makeToggle(rivals, co(), "Auto-Dodge", "Esquive", function() return C.AutoDodge end, function(v) C.AutoDodge = v end)
    makeSlider(rivals, co(), "Dodge Range", 20, 200, function() return C.AutoDodgeRange end, function(v) C.AutoDodgeRange = v end)
    makeToggle(rivals, co(), "Anti-Katana", "Anti deflect", function() return C.AntiKatana end, function(v) C.AntiKatana = v end)
    makeToggle(rivals, co(), "Adonis Bypass", "Anti-cheat", function() return C.AdonisBypass end, function(v) C.AdonisBypass = v end)
    makeToggle(rivals, co(), "No Killcam", "Pas killcam", function() return C.NoKillcam end, function(v) C.NoKillcam = v end)
    makeToggle(rivals, co(), "No Flash", "Pas flash", function() return C.NoFlash end, function(v) C.NoFlash = v end)
    makeToggle(rivals, co(), "No Fog", "Pas brouillard", function() return C.NoFog end, function(v) C.NoFog = v end)

    makeSection(rivals, co(), "Feedback")
    makeToggle(rivals, co(), "Hit Sound", "Son hit", function() return C.HitSound end, function(v) C.HitSound = v end)
    makeToggle(rivals, co(), "Kill Sound", "Son kill", function() return C.KillSound end, function(v) C.KillSound = v end)
    makeToggle(rivals, co(), "Hit Marker", "Croix", function() return C.HitMarker end, function(v) C.HitMarker = v end)
    makeToggle(rivals, co(), "Damage Indicator", "Dégâts", function() return C.DamageIndicator end, function(v) C.DamageIndicator = v end)
    makeToggle(rivals, co(), "Kill Effect", "Particules", function() return C.KillEffect end, function(v) C.KillEffect = v end)

    -- NEW PAGE
    local newPage = addPage("New", "New")
    o = 0
    makeSection(newPage, co(), "Invisibilité (Y)")
    makeToggle(newPage, co(), "Invisibilité", "Touche Y", function() return C.Invisible end,
        function(v) C.Invisible = v; doSetInvisibility(v) end)
    makeSection(newPage, co(), "Infinite Jump (I)")
    makeToggle(newPage, co(), "Infinite Jump", "Touche I", function() return C.InfJump end, function(v) C.InfJump = v end)
    makeSection(newPage, co(), "Speed Boost")
    makeToggle(newPage, co(), "Speed Boost", "48 vitesse", function() return C.SpeedBoost end,
        function(v) C.SpeedBoost = v; doSetSpeedBoost(v) end)
    makeSection(newPage, co(), "Select (N)")
    makeToggle(newPage, co(), "Select", "Touche N", function() return C.SelectActive end, function(v) setSelect(v) end)
    makeSection(newPage, co(), "Fall Player (B)")
    makeToggle(newPage, co(), "Fall Player", "Touche B", function() return C.FallPlayer end, function(v) setFall(v) end)
    makeSlider(newPage, co(), "Distance", 2, 15, function() return C.FallDistance end, function(v) C.FallDistance = v end)
    makeButton(newPage, co(), "Reset Fall (C)", "Force reset", P.Danger, function() forceResetFall() end)

    -- OUTFIT PAGE
    local outfit = addPage("Outfit", "Outfit")
    o = 0
    makeSection(outfit, co(), "Tenues")
    for _, out in ipairs(OUTFITS) do
        makeButton(outfit, co(), out.name, "Appliquer", P.Accent, function() applyOutfit(out.userId) end)
    end
    makeSection(outfit, co(), "Sauvegarde")
    makeButton(outfit, co(), "Save tenue", "Sauvegarde", P.Success, function() saveOutfit() end)
    makeButton(outfit, co(), "Load tenue", "Charge", P.Warn, function() loadOutfit() end)
    makeButton(outfit, co(), "Reset tenue", "Reset", P.Danger, function() resetOutfit() end)

    -- MISC PAGE
    local misc = addPage("Misc", "Misc")
    o = 0
    makeSection(misc, co(), "Vision")
    makeToggle(misc, co(), "FOV Changer", "Modifie FOV", function() return C.FOVChanger end, function(v) C.FOVChanger = v end)
    makeSlider(misc, co(), "FOV Value", 30, 160, function() return C.FOVValue end, function(v) C.FOVValue = v end)
    makeToggle(misc, co(), "Third Person", "3e personne", function() return C.ThirdPerson end, function(v) C.ThirdPerson = v end)
    makeSlider(misc, co(), "3P Distance", 4, 30, function() return C.ThirdPersonDist end, function(v) C.ThirdPersonDist = v end)

    makeSection(misc, co(), "Movement")
    makeToggle(misc, co(), "Speed Hack", "Speed", function() return C.SpeedHack end, function(v) C.SpeedHack = v end)
    makeSlider(misc, co(), "Speed Value", 16, 200, function() return C.SpeedValue end, function(v) C.SpeedValue = v end)
    makeToggle(misc, co(), "Infinite Jump", "Jump ∞", function() return C.InfJump end, function(v) C.InfJump = v end)
    makeToggle(misc, co(), "No Clip", "Traverse murs", function() return C.Noclip end, function(v) C.Noclip = v end)
    makeToggle(misc, co(), "Bunny Hop", "Bhop", function() return C.BunnyHop end, function(v) C.BunnyHop = v end)
    makeToggle(misc, co(), "Silent Walk", "Pas silencieux", function() return C.SilentWalk end, function(v) C.SilentWalk = v end)

    makeSection(misc, co(), "Util")
    makeToggle(misc, co(), "Anti-AFK", "Anti kick", function() return C.AntiAFK end, function(v) C.AntiAFK = v end)
    makeToggle(misc, co(), "Anti-Void", "Anti vide", function() return C.AntiVoid end, function(v) C.AntiVoid = v end)
    makeToggle(misc, co(), "Auto Pickup", "Ramasser", function() return C.AutoPickup end, function(v) C.AutoPickup = v end)
    makeToggle(misc, co(), "Auto Reload", "Recharge", function() return C.AutoReload end, function(v) C.AutoReload = v end)
    makeToggle(misc, co(), "Auto Equip Best", "Meilleure arme", function() return C.AutoEquipBest end, function(v) C.AutoEquipBest = v end)
    makeToggle(misc, co(), "FPS Unlocker", "FPS ∞", function() return C.FPSUnlocker end, function(v) C.FPSUnlocker = v end)

    makeSection(misc, co(), "Info")
    makeButton(misc, co(), "Destroy Menu", "Supprime", P.Danger, function()
        if S.Gui then S.Gui:Destroy() end
        if RIV.RadarGui then RIV.RadarGui:Destroy() end
        if RIV.FOVCircle then RIV.FOVCircle:Remove() end
        if hmHolder then hmHolder:Destroy() end
    end)

    -- Activate first page
    S.CurrentPage = "Combat"
    for id, fn in pairs(S.NavButtons) do fn(id == "Combat") end
    for name, pg in pairs(S.Pages) do pg.frame.Visible = (name == "Combat") end

    main.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 900, 0, 560),
    }):Play()
end

----------------------------------------------------------------------
-- ARROW NAVIGATION
----------------------------------------------------------------------

local function refreshHighlight()
    for i, entry in ipairs(S.NavItems) do
        if entry.card then
            if i == S.SelectedIndex then
                entry.card.BackgroundColor3 = P.BgHover
                entry.card.BackgroundTransparency = 0.05
                local st = entry.card:FindFirstChildOfClass("UIStroke")
                if st then
                    st.Color = P.Accent
                    st.Transparency = 0.2
                end
            else
                entry.card.BackgroundColor3 = P.BgCard
                entry.card.BackgroundTransparency = 0.15
                local st = entry.card:FindFirstChildOfClass("UIStroke")
                if st then
                    st.Color = P.BorderSoft
                    st.Transparency = 0.3
                end
            end
        end
    end
end

local function refreshAllToggles()
    for _, entry in ipairs(S.NavItems) do
        if entry.refresh then
            pcall(function() entry.refresh() end)
        end
    end
end

local function getCurrentPageItems()
    local items = {}
    local page = S.Pages[S.CurrentPage]
    if not page then return items end
    for _, entry in ipairs(S.NavItems) do
        if entry.card and entry.card.Parent == page.list then
            items[#items + 1] = entry
        end
    end
    return items
end

local function navigateUp()
    local items = getCurrentPageItems()
    if #items == 0 then return end
    local cur = S.NavItems[S.SelectedIndex]
    local idx = 1
    for i, e in ipairs(items) do
        if e == cur then idx = i; break end
    end
    idx = math.max(1, idx - 1)
    for i, e in ipairs(S.NavItems) do
        if e == items[idx] then
            S.SelectedIndex = i
            break
        end
    end
    refreshHighlight()
end

local function navigateDown()
    local items = getCurrentPageItems()
    if #items == 0 then return end
    local cur = S.NavItems[S.SelectedIndex]
    local idx = 1
    for i, e in ipairs(items) do
        if e == cur then idx = i; break end
    end
    idx = math.min(#items, idx + 1)
    for i, e in ipairs(S.NavItems) do
        if e == items[idx] then
            S.SelectedIndex = i
            break
        end
    end
    refreshHighlight()
end

local function activateSelected()
    local entry = S.NavItems[S.SelectedIndex]
    if not entry then return end
    if entry.setter and entry.getter then
        entry.setter(not entry.getter())
        if entry.refresh then entry.refresh() end
    elseif entry.action then
        pcall(entry.action)
    end
end

local function stepSelected(dir)
    local entry = S.NavItems[S.SelectedIndex]
    if not entry then return end
    if entry.step then
        pcall(entry.step, dir)
    end
end

local function nextPage()
    local idx = 1
    for i, id in ipairs(S.PageOrder) do
        if id == S.CurrentPage then idx = i; break end
    end
    idx = idx + 1
    if idx > #S.PageOrder then idx = 1 end
    S.CurrentPage = S.PageOrder[idx]
    for id, fn in pairs(S.NavButtons) do fn(id == S.CurrentPage) end
    for name, pg in pairs(S.Pages) do pg.frame.Visible = (name == S.CurrentPage) end
    S.SelectedIndex = 1
    refreshHighlight()
end

local function prevPage()
    local idx = 1
    for i, id in ipairs(S.PageOrder) do
        if id == S.CurrentPage then idx = i; break end
    end
    idx = idx - 1
    if idx < 1 then idx = #S.PageOrder end
    S.CurrentPage = S.PageOrder[idx]
    for id, fn in pairs(S.NavButtons) do fn(id == S.CurrentPage) end
    for name, pg in pairs(S.Pages) do pg.frame.Visible = (name == S.CurrentPage) end
    S.SelectedIndex = 1
    refreshHighlight()
end

----------------------------------------------------------------------
-- INPUT
----------------------------------------------------------------------

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end

    if input.KeyCode == Enum.KeyCode.Y then
        C.Invisible = not C.Invisible
        doSetInvisibility(C.Invisible)
        refreshAllToggles()
        return
    end
    if input.KeyCode == Enum.KeyCode.I then
        C.InfJump = not C.InfJump
        refreshAllToggles()
        return
    end
    if input.KeyCode == Enum.KeyCode.N then
        setSelect(not C.SelectActive)
        refreshAllToggles()
        return
    end
    if input.KeyCode == Enum.KeyCode.B then
        setFall(not C.FallPlayer)
        refreshAllToggles()
        return
    end
    if input.KeyCode == Enum.KeyCode.C then
        forceResetFall()
        refreshAllToggles()
        return
    end
    if input.KeyCode == Enum.KeyCode.U then
        C.AimbotMaster = not C.AimbotMaster
        refreshAllToggles()
        return
    end
    if input.KeyCode == Enum.KeyCode.RightShift then
        S.Visible = not S.Visible
        if S.Main then
            if S.Visible then
                S.Main.Visible = true
                S.Main.Size = UDim2.new(0, 0, 0, 0)
                TweenService:Create(S.Main, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, 900, 0, 560),
                }):Play()
            else
                local tw = TweenService:Create(S.Main, TweenInfo.new(0.2), {
                    Size = UDim2.new(0, 0, 0, 0),
                })
                tw:Play()
                tw.Completed:Connect(function()
                    if S.Main then S.Main.Visible = false end
                end)
            end
        end
        return
    end

    if not S.Visible then return end

    if input.KeyCode == Enum.KeyCode.Up then
        navigateUp()
    elseif input.KeyCode == Enum.KeyCode.Down then
        navigateDown()
    elseif input.KeyCode == Enum.KeyCode.Left then
        stepSelected(-1)
    elseif input.KeyCode == Enum.KeyCode.Right then
        stepSelected(1)
    elseif input.KeyCode == Enum.KeyCode.Return or input.KeyCode == Enum.KeyCode.KeypadEnter then
        activateSelected()
    elseif input.KeyCode == Enum.KeyCode.Space then
        activateSelected()
    elseif input.KeyCode == Enum.KeyCode.Backspace then
        S.CurrentPage = "Combat"
        for id, fn in pairs(S.NavButtons) do fn(id == "Combat") end
        for name, pg in pairs(S.Pages) do pg.frame.Visible = (name == "Combat") end
        S.SelectedIndex = 1
        refreshHighlight()
    elseif input.KeyCode == Enum.KeyCode.Q then
        prevPage()
    elseif input.KeyCode == Enum.KeyCode.E then
        nextPage()
    end
end)

----------------------------------------------------------------------
-- CHARACTER / PLAYER EVENTS
----------------------------------------------------------------------

LP.CharacterAdded:Connect(function()
    task.wait(0.5)
    RIV_TARGET = nil
    RIV_SILENT_POS = nil
    RIV_MAGIC_POS = nil
    C.AimbotLockedTarget = nil
    if InvisState.isInvisible then
        InvisState.isInvisible = false
        C.Invisible = false
        if InvisState.invisChair then
            pcall(function() InvisState.invisChair:Destroy() end)
            InvisState.invisChair = nil
        end
        local c = workspace:FindFirstChild("invischair")
        if c then pcall(function() c:Destroy() end) end
    end
    if InvisState.isSpeedBoosted then
        InvisState.isSpeedBoosted = false
        C.SpeedBoost = false
    end
    FallState.lastSide = 0
    FallState.currentSide = 1
    if FallState.active or fallConn then
        FallState.generation = FallState.generation + 1
        stopFall()
        C.FallPlayer = false
    end
    scanFireRemotes()
    installFireHook()
end)

Players.PlayerRemoving:Connect(function(plr)
    if FallState.target == plr then FallState.target = nil end
    if SelectState.allies[plr.Name] then SelectState.allies[plr.Name] = nil end
    if SelectState.alliesIds[plr.UserId] then SelectState.alliesIds[plr.UserId] = nil end
    if C.AimbotLockedTarget == plr then
        C.AimbotLockedTarget = nil
        RIV_TARGET = nil
    end
    removeESP(plr)
end)

----------------------------------------------------------------------
-- CLEANUP + START
----------------------------------------------------------------------

pcall(function()
    for _, name in ipairs({
        "LEOLABAKAKA", "ZRXProject", "ZeyProject", "ZRXRadar",
        "ZeyRadar", "LEOLABAKAKA_Radar", "LEOLABAKAKA_HitMarkers",
        "VRivMenu", "VRivRadar",
    }) do
        local old = PG:FindFirstChild(name)
        if old then old:Destroy() end
    end
end)

buildRadar()
buildUI()
refreshHighlight()

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "leolabakaka",
        Text = "Y inv · I jump · N select · B fall · C reset · RShift menu · Flèches nav",
        Duration = 7,
    })
end)

pushToast("leolabakaka chargé", "Wallbang ON · Flèches pour naviguer · RShift menu", P.Success)

-- END LEOLABAKAKA
