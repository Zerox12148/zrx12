-- leolabakaka | Xeno | Rivals / FPS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")
local CAM = workspace.CurrentCamera

local EXECUTOR = "Unknown"
pcall(function() EXECUTOR = identifyexecutor() end)

local HAS_DRAWING = pcall(function() return Drawing.new("Square") end)
local HAS_META = pcall(function() return getrawmetatable(game) end)
local HAS_HOOK = pcall(function() return hookfunction end)
local HAS_NEWC = pcall(function() return newcclosure end)
local HAS_SETRO = pcall(function() return setreadonly end)
local HAS_GETNC = pcall(function() return getnamecallmethod end)

-- ═══════════════════════════════════════
-- THEME
-- ═══════════════════════════════════════
local P = {
    Accent      = Color3.fromRGB(180, 70, 255),
    Accent2     = Color3.fromRGB(100, 180, 255),
    Accent3     = Color3.fromRGB(255, 90, 160),
    Success     = Color3.fromRGB(80, 230, 160),
    Danger      = Color3.fromRGB(255, 70, 100),
    Warn        = Color3.fromRGB(255, 190, 80),
    BgDeep      = Color3.fromRGB(8, 8, 14),
    BgBase      = Color3.fromRGB(14, 14, 22),
    BgCard      = Color3.fromRGB(20, 20, 30),
    BgHover     = Color3.fromRGB(28, 28, 42),
    BgInput     = Color3.fromRGB(24, 24, 36),
    Border      = Color3.fromRGB(50, 45, 75),
    BorderSoft  = Color3.fromRGB(38, 35, 55),
    Text        = Color3.fromRGB(245, 245, 255),
    TextDim     = Color3.fromRGB(160, 160, 185),
    TextFaint   = Color3.fromRGB(100, 100, 125),
}

local ACCENT = P.Accent
local DANGER = P.Danger
local SUCCESS = P.Success
local WARN = P.Warn

-- ═══════════════════════════════════════
-- STATE
-- ═══════════════════════════════════════
local S = {
    Gui = nil, Main = nil, Pages = {}, CurrentPage = "Combat",
    NavButtons = {}, Visible = true,
    SelectedIndex = 1, NavItems = {}, NavOrder = {}, PageOrder = {},
    PageIndex = 1, SnowLayer = nil,
}

local C = {
    -- Aimbot
    Aimbot = true,
    AimbotKey = true,
    AimbotMaster = true,
    AimbotSmooth = 0.85,
    AimbotFOV = 180,
    AimbotWallCheck = false,
    AimbotVisCheck = false,
    AimbotPrediction = 0.14,
    AimbotBone = "Head",
    AimbotTeamCheck = true,
    AimbotLockFull = true,
    AimbotFOVCircle = true,
    AimbotLockedTarget = nil,
    AimbotStickyRange = 9999,
    AimbotTrackSpeed = 1,

    -- Silent
    SilentAim = true,
    SilentAimFOV = 900,
    SilentAimWallCheck = false,
    SilentAimVisCheck = false,
    SilentAimBone = "Head",

    -- Magic
    MagicBullet = true,
    MagicBulletFOV = 1200,
    MagicBulletWall = true,

    -- Weapon
    NoRecoil = true,
    NoSpread = true,
    NoReload = true,
    RapidFire = true,
    RapidFireMulti = 5,
    InfiniteAmmo = true,
    InstantHit = true,
    Wallbang = true,

    -- Auto
    AutoShoot = true,
    AutoShootDelay = 0.04,
    TriggerBot = false,
    TriggerBotDelay = 0.03,
    AimAssist = false,
    AimAssistStrength = 0.45,
    AimAssistFOV = 160,

    -- Hitbox
    HitboxExpander = true,
    HitboxSize = 4.5,
    HitboxTransparency = 0.65,

    -- ESP
    ESP = true,
    ESPBox = true,
    ESPName = true,
    ESPHealth = true,
    ESPDistance = true,
    ESPTracer = true,
    ESPSkeleton = true,
    ESPChams = true,
    ESPHeadDot = true,
    ESPTeamCheck = true,
    ESPWeapon = true,
    Radar = true,

    -- Movement
    FOVChanger = false,
    FOVValue = 95,
    SpeedHack = false,
    SpeedValue = 32,
    InfJump = true,
    Noclip = false,
    Invisible = false,
    SpeedBoost = false,
    Fly = false,
    FlySpeed = 55,
    Bhop = false,

    -- Special
    FallPlayer = false,
    FallDistance = 6,
    SelectActive = false,
    SnowEnabled = true,
    CurrentOutfit = "default",
    SavedOutfit = nil,

    -- Extra Rivals / FPS
    Spinbot = false,
    SpinSpeed = 18,
    AntiAim = false,
    ThirdPerson = false,
    ThirdPersonDist = 8,
    Crosshair = true,
    CrosshairSize = 8,
    CrosshairGap = 4,
    KillSound = true,
    AutoReload = false,
    InstantRespawn = false,
    GodMode = false,
}

local RIV = {
    ESPObjs = {},
    RadarGui = nil,
    Hitboxes = {},
    CameraHooked = false,
    FireRemote = nil,
    RemoteScanned = false,
    FOVCircle = nil,
    OriginalFOV = 70,
    SkeletonCache = {},
    ChamsCache = {},
    Crosshair = {},
}

local RIV_TARGET = nil
local RIV_SILENT_POS = nil
local RIV_MAGIC_POS = nil

local NEWCFG = {
    INVIS_POSITION = Vector3.new(-25.95, 84, 3537.55),
    BOOSTED_SPEED = 52,
    SOUND_ID = "rbxassetid://942127495",
}

local InvisState = {
    isInvisible = false,
    isSpeedBoosted = false,
    originalSpeed = 16,
    invisChair = nil,
    sound = nil,
}

local FallState = {
    active = false,
    target = nil,
    cachedWeapon = nil,
    lastError = 0,
    orbitAngle = 0,
    generation = 0,
    loopRunning = false,
    override = false,
    currentSide = 1,
    lastSide = 0,
    sideTimer = 0,
}

local SelectState = {
    active = false,
    allies = {},
    alliesIds = {},
    scannedAt = 0,
}

local FlyState = {
    active = false,
    bodyVel = nil,
    bodyGyro = nil,
}

-- ═══════════════════════════════════════
-- UTILS
-- ═══════════════════════════════════════
local function new(cls, props)
    local i = Instance.new(cls)
    for k, v in pairs(props or {}) do i[k] = v end
    return i
end

local function corner(p, r)
    return new("UICorner", {CornerRadius = UDim.new(0, r or 8), Parent = p})
end

local function stroke(p, color, thick, trans)
    return new("UIStroke", {
        Color = color or P.Border, Thickness = thick or 1,
        Transparency = trans or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = p,
    })
end

local function grad(p, stops, rot)
    local keys = {}
    for _, s in ipairs(stops) do
        keys[#keys+1] = ColorSequenceKeypoint.new(s[1], s[2])
    end
    return new("UIGradient", {
        Color = ColorSequence.new(keys),
        Rotation = rot or 90, Parent = p,
    })
end

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
    if not p or p == LP then return false end
    if not p.Character then return false end
    local h = p.Character:FindFirstChildOfClass("Humanoid")
    if not h or h.Health <= 0 then return false end
    if not p.Character:FindFirstChild("HumanoidRootPart") then return false end
    return true
end

local function sameTeam(a, b)
    if not (a and b) then return false end
    local ta, tb = a.Team, b.Team
    if ta and tb then return ta == tb end
    return false
end

local function isPartner(target)
    if not target then return false end
    if LP.Team and target.Team and LP.Team == target.Team then return true end
    local myAttr = LP:GetAttribute("Team") or LP:GetAttribute("team")
    local tAttr = target:GetAttribute("Team") or target:GetAttribute("team")
    if myAttr and tAttr and myAttr == tAttr then return true end
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

local function hasLOS(target, wallCheck)
    if not wallCheck then return true end
    local myHRP = getHRP(LP)
    local tHRP = getHRP(target)
    if not (myHRP and tHRP) then return false end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {LP.Character, target.Character}
    local ray = workspace:Raycast(myHRP.Position, tHRP.Position - myHRP.Position, params)
    return ray == nil
end

local function isAlly(p)
    if not p then return false end
    if p == LP then return true end
    if SelectState.allies[p.Name] then return true end
    if SelectState.alliesIds[p.UserId] then return true end
    return false
end

local function worldToScreen(pos)
    local sp, on = CAM:WorldToViewportPoint(pos)
    if not on then return nil end
    return Vector2.new(sp.X, sp.Y), sp.Z
end

-- ═══════════════════════════════════════
-- FIRE REMOTE + HOOKS
-- ═══════════════════════════════════════
local FIRE_REMOTE_NAMES = {
    "Fire", "Shoot", "FireWeapon", "WeaponFire", "GunFire",
    "FireGun", "Attack", "Hit", "Damage", "Bullet",
    "FireServer", "ShootServer", "RemoteFire", "Weapon",
    "ShootBullet", "Projectile", "FireProjectile",
}

local function scanFireRemotes()
    if RIV.RemoteScanned then return end
    RIV.RemoteScanned = true
    local candidates = {}
    local function scan(parent, depth)
        if depth > 5 then return end
        for _, c in ipairs(parent:GetChildren()) do
            if c:IsA("RemoteEvent") or c:IsA("RemoteFunction") then
                local n = c.Name:lower()
                for _, key in ipairs(FIRE_REMOTE_NAMES) do
                    if n:find(key:lower()) then
                        candidates[#candidates+1] = c
                        break
                    end
                end
            end
            pcall(scan, c, depth + 1)
        end
    end
    pcall(scan, ReplicatedStorage, 0)
    pcall(scan, workspace, 0)
    if #candidates > 0 then
        RIV.FireRemote = candidates[1]
    end
end

local function installFireHook()
    if not (HAS_META and HAS_SETRO and HAS_NEWC and HAS_GETNC) then return end
    if not RIV.FireRemote then scanFireRemotes() end
    if not RIV.FireRemote then return end

    local ok, mt = pcall(getrawmetatable, game)
    if not ok or not mt then return end
    local oldNamecall = mt.__namecall
    if not oldNamecall then return end

    pcall(setreadonly, mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "FireServer" and self == RIV.FireRemote then
            local args = {...}
            local useMagic = C.MagicBullet and RIV_MAGIC_POS
            local useSilent = C.SilentAim and RIV_SILENT_POS
            local targetPos = nil
            if useMagic then targetPos = RIV_MAGIC_POS
            elseif useSilent then targetPos = RIV_SILENT_POS end

            if targetPos then
                local originIdx, dirIdx = nil, nil
                for i, a in ipairs(args) do
                    if typeof(a) == "Vector3" then
                        if originIdx == nil then originIdx = i
                        elseif dirIdx == nil then dirIdx = i; break end
                    end
                end
                if originIdx and dirIdx then
                    if useMagic and C.MagicBulletWall then
                        args[originIdx] = targetPos - Vector3.new(0, 2, 0)
                        args[dirIdx] = Vector3.new(0, 1, 0)
                    else
                        local origin = args[originIdx]
                        local mag = args[dirIdx].Magnitude > 0 and args[dirIdx].Magnitude or 1000
                        args[dirIdx] = (targetPos - origin).Unit * mag
                    end
                elseif originIdx then
                    args[originIdx] = targetPos
                    if args[originIdx+1] and typeof(args[originIdx+1]) == "Vector3" then
                        args[originIdx+1] = Vector3.new(0, 0, 0.01)
                    end
                end
                return oldNamecall(self, unpack(args))
            end
        end
        return oldNamecall(self, ...)
    end)
    pcall(setreadonly, mt, true)
end

local function installCameraHook()
    if RIV.CameraHooked then return end
    RIV.CameraHooked = true
    if not (HAS_META and HAS_SETRO and HAS_NEWC) then return end
    local ok, mt = pcall(getrawmetatable, CAM)
    if not ok or not mt then return end
    local oldIndex = mt.__index
    if not oldIndex then return end
    pcall(setreadonly, mt, false)
    mt.__index = newcclosure(function(self, key)
        local val = oldIndex(self, key)
        if key == "CFrame" then
            if FallState.active and FallState.target and FallState.override then
                local head = getBone(FallState.target, "Head")
                if head then
                    return CFrame.new(val.Position, head.Position)
                end
            end
            if C.Aimbot and C.AimbotMaster and C.AimbotLockedTarget
                and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                local head = getBone(C.AimbotLockedTarget, C.AimbotBone)
                if head then
                    local targetPos = head.Position
                    if C.AimbotPrediction > 0 then
                        local hrp = getHRP(C.AimbotLockedTarget)
                        if hrp then
                            targetPos = targetPos + hrp.AssemblyLinearVelocity * C.AimbotPrediction
                        end
                    end
                    return CFrame.new(val.Position, targetPos)
                end
            end
        end
        return val
    end)
    pcall(setreadonly, mt, true)
end

-- ═══════════════════════════════════════
-- TARGETING
-- ═══════════════════════════════════════
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

local function findBestTarget()
    local mouse = UIS:GetMouseLocation()
    local best, bestScore = nil, C.AimbotFOV
    for _, p in ipairs(Players:GetPlayers()) do
        if isRival(p) and not isPartner(p) and not sameTeam(LP, p) and not isAlly(p) then
            local part = getBone(p, C.AimbotBone)
            if part then
                local sp, on = CAM:WorldToViewportPoint(part.Position)
                if on then
                    local d = (Vector2.new(sp.X, sp.Y) - mouse).Magnitude
                    if d < bestScore then
                        if not (C.AimbotWallCheck and not hasLOS(p, true)) then
                            best, bestScore = p, d
                        end
                    end
                end
            end
        end
    end
    return best
end

local function aimbotStep(dt)
    if FallState.active and FallState.target and FallState.override then
        local locked = FallState.target
        if isRival(locked) and not isAlly(locked) then
            local head = getBone(locked, "Head") or getHRP(locked)
            if head then
                local targetPos = head.Position
                if C.AimbotPrediction > 0 then
                    local hrp = getHRP(locked)
                    if hrp then targetPos = targetPos + hrp.AssemblyLinearVelocity * C.AimbotPrediction end
                end
                local cur = CAM.CFrame
                CAM.CFrame = cur:Lerp(CFrame.new(cur.Position, targetPos), 1)
                C.AimbotLockedTarget = locked
                RIV_TARGET = locked
                return
            end
        end
        return
    end

    if not C.AimbotMaster or not C.Aimbot then
        RIV_TARGET = nil
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
        if not t or isPartner(t) or sameTeam(LP, t) or isAlly(t) then
            RIV_TARGET = nil
            return
        end
        C.AimbotLockedTarget = t
    end
    local locked = C.AimbotLockedTarget
    if not locked or not isRival(locked) or isAlly(locked) then
        C.AimbotLockedTarget = nil
        RIV_TARGET = nil
        return
    end
    local myHRP, tHRP = getHRP(LP), getHRP(locked)
    if myHRP and tHRP and (tHRP.Position - myHRP.Position).Magnitude > C.AimbotStickyRange then
        C.AimbotLockedTarget = nil
        RIV_TARGET = nil
        return
    end
    RIV_TARGET = locked
    local head = getBone(locked, C.AimbotBone) or getHRP(locked)
    if not head then
        C.AimbotLockedTarget = nil
        RIV_TARGET = nil
        return
    end
    local targetPos = head.Position
    if C.AimbotPrediction > 0 then
        local hrp = getHRP(locked)
        if hrp then targetPos = targetPos + hrp.AssemblyLinearVelocity * C.AimbotPrediction end
    end
    local cur = CAM.CFrame
    local alpha = C.AimbotLockFull and 1 or math.clamp(C.AimbotSmooth, 0.05, 1)
    CAM.CFrame = cur:Lerp(CFrame.new(cur.Position, targetPos), alpha)
end

pcall(function()
    RunService:UnbindFromRenderStep("LEOLA_Aimbot")
    RunService:BindToRenderStep("LEOLA_Aimbot", Enum.RenderPriority.Camera.Value + 1, aimbotStep)
end)

-- ═══════════════════════════════════════
-- INVIS / SPEED / SELECT / FALL
-- ═══════════════════════════════════════
local function playToggleSound()
    if not InvisState.sound then
        InvisState.sound = Instance.new("Sound")
        InvisState.sound.SoundId = NEWCFG.SOUND_ID
        InvisState.sound.Volume = 0.45
        InvisState.sound.Parent = PG
    end
    pcall(function() InvisState.sound:Play() end)
end

local function setCharTransparency(char, t)
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") or d:IsA("Decal") then
            pcall(function() d.Transparency = t end)
        end
    end
end

local function doSetInvisibility(state)
    if not LP.Character then return end
    if state == InvisState.isInvisible then return end
    InvisState.isInvisible = state
    playToggleSound()
    if state then
        local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local saved = hrp.CFrame
        LP.Character:MoveTo(NEWCFG.INVIS_POSITION)
        task.wait(0.15)
        local seat = Instance.new("Seat")
        seat.Name = "leola_invis"
        seat.Anchored = false
        seat.CanCollide = false
        seat.Transparency = 1
        seat.Position = NEWCFG.INVIS_POSITION
        seat.Parent = workspace
        local torso = LP.Character:FindFirstChild("Torso") or LP.Character:FindFirstChild("UpperTorso")
        if torso then
            local weld = Instance.new("Weld")
            weld.Part0 = seat
            weld.Part1 = torso
            weld.Parent = seat
        end
        task.wait()
        seat.CFrame = saved
        InvisState.invisChair = seat
        setCharTransparency(LP.Character, 0.55)
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title = "leolabakaka", Text = "Invisibilité ON", Duration = 2})
        end)
    else
        if InvisState.invisChair then
            pcall(function() InvisState.invisChair:Destroy() end)
            InvisState.invisChair = nil
        end
        local chair = workspace:FindFirstChild("leola_invis")
        if chair then pcall(function() chair:Destroy() end) end
        if LP.Character then setCharTransparency(LP.Character, 0) end
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title = "leolabakaka", Text = "Invisibilité OFF", Duration = 2})
        end)
    end
end

local function doSetSpeedBoost(state)
    local hum = getHum(LP)
    if not hum then return end
    if state and not InvisState.isSpeedBoosted then
        InvisState.originalSpeed = hum.WalkSpeed
        hum.WalkSpeed = NEWCFG.BOOSTED_SPEED
        InvisState.isSpeedBoosted = true
        playToggleSound()
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title = "Speed Boost", Text = "ON · " .. NEWCFG.BOOSTED_SPEED, Duration = 2})
        end)
    elseif not state and InvisState.isSpeedBoosted then
        hum.WalkSpeed = InvisState.originalSpeed
        InvisState.isSpeedBoosted = false
        playToggleSound()
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title = "Speed Boost", Text = "OFF", Duration = 2})
        end)
    end
end

local function scanAlliesInZone()
    SelectState.allies = {}
    SelectState.alliesIds = {}
    local myHRP = getHRP(LP)
    if not myHRP then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            local hrp = getHRP(p)
            if hrp and (hrp.Position - myHRP.Position).Magnitude <= 5 then
                SelectState.allies[p.Name] = true
                SelectState.alliesIds[p.UserId] = true
            end
        end
    end
    SelectState.scannedAt = tick()
end

local function isPlayerAlive(p)
    if not p or not p.Parent or not p.Character then return false end
    local hum = p.Character:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    if not p.Character:FindFirstChild("HumanoidRootPart") then return false end
    return true
end

local function equipWeapon()
    local ch = LP.Character
    if not ch then return end
    local hum = ch:FindFirstChildOfClass("Humanoid")
    local current = ch:FindFirstChildOfClass("Tool")
    if current then FallState.cachedWeapon = current; return current end
    local bp = LP:FindFirstChild("Backpack")
    if bp then
        for _, t in ipairs(bp:GetChildren()) do
            if t:IsA("Tool") then
                pcall(function() hum:EquipTool(t) end)
                FallState.cachedWeapon = t
                return t
            end
        end
    end
    return nil
end

local function getFallPlayerTarget()
    local myHRP = getHRP(LP)
    if not myHRP then return nil end
    local best, bestDist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and not isAlly(p) and isPlayerAlive(p) then
            local hrp = getHRP(p)
            if hrp then
                local d = (hrp.Position - myHRP.Position).Magnitude
                if d < bestDist then best, bestDist = p, d end
            end
        end
    end
    return best
end

local function randomSide()
    local side = math.random(1, 3)
    local attempts = 0
    while side == FallState.lastSide and attempts < 5 do
        side = math.random(1, 3)
        attempts = attempts + 1
    end
    FallState.lastSide = side
    return side
end

local function getSideOffset(side, dist, tHRP)
    local right, look = tHRP.CFrame.RightVector, tHRP.CFrame.LookVector
    if side == 1 then return right * -dist
    elseif side == 2 then return right * dist
    else return look * -dist end
end

local fallPlayerConn = nil

local function stopFallPlayerLoop()
    if fallPlayerConn then pcall(function() fallPlayerConn:Disconnect() end); fallPlayerConn = nil end
    FallState.loopRunning = false
    FallState.override = false
    FallState.active = false
    FallState.target = nil
    FallState.sideTimer = 0
    C.AimbotLockedTarget = nil
    RIV_TARGET = nil
end

local function fallPlayerLoop()
    if fallPlayerConn then pcall(function() fallPlayerConn:Disconnect() end); fallPlayerConn = nil end
    FallState.generation = FallState.generation + 1
    local myGen = FallState.generation
    FallState.loopRunning = true
    FallState.active = true
    fallPlayerConn = RunService.RenderStepped:Connect(function(dt)
        if FallState.generation ~= myGen or not C.FallPlayer or not FallState.active then
            stopFallPlayerLoop()
            return
        end
        local ok = pcall(function()
            local myHRP = getHRP(LP)
            if not myHRP then FallState.override = false; return end
            if FallState.target and (not FallState.target.Parent or not isPlayerAlive(FallState.target) or isAlly(FallState.target)) then
                FallState.target = nil
                FallState.override = false
            end
            if not FallState.target then
                FallState.target = getFallPlayerTarget()
                FallState.currentSide = randomSide()
                FallState.sideTimer = 0
            end
            local tgt = FallState.target
            if not tgt or not tgt.Parent then FallState.override = false; return end
            local tHRP = getHRP(tgt)
            local tHead = getBone(tgt, "Head")
            if not tHRP then FallState.target = nil; FallState.override = false; return end
            equipWeapon()
            FallState.override = true
            FallState.sideTimer = FallState.sideTimer + dt
            if FallState.sideTimer >= 0.08 then
                FallState.currentSide = randomSide()
                FallState.sideTimer = 0
            end
            local dist = C.FallDistance or 6
            local offset = getSideOffset(FallState.currentSide, dist, tHRP)
            local facing = tHead or tHRP
            local predicted = tHRP.Position + tHRP.AssemblyLinearVelocity * 0.04
            local targetPos = Vector3.new(predicted.X + offset.X, tHRP.Position.Y + 1, predicted.Z + offset.Z)
            pcall(function() myHRP.CFrame = CFrame.new(targetPos, facing.Position) end)
            pcall(function() CAM.CFrame = CFrame.new(CAM.CFrame.Position, facing.Position) end)
            C.AimbotLockedTarget = tgt
            RIV_TARGET = tgt
        end)
        if not ok then FallState.target = nil; FallState.override = false end
    end)
end

local function forceResetFallPlayer()
    FallState.generation = FallState.generation + 1
    stopFallPlayerLoop()
    C.FallPlayer = false
    C.AimbotLockedTarget = nil
    RIV_TARGET = nil
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title = "Fall Player", Text = "FORCE RESET", Duration = 2})
    end)
end

local function setFallPlayer(state)
    state = state and true or false
    if state == C.FallPlayer and state == FallState.active then return end
    C.FallPlayer = state
    if state then
        FallState.generation = FallState.generation + 1
        FallState.active = true
        FallState.target = nil
        FallState.override = false
        FallState.currentSide = randomSide()
        FallState.sideTimer = 0
        fallPlayerLoop()
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title = "Fall Player", Text = "ACTIVÉ", Duration = 2})
        end)
    else
        FallState.generation = FallState.generation + 1
        stopFallPlayerLoop()
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title = "Fall Player", Text = "DÉSACTIVÉ", Duration = 2})
        end)
    end
end

local function setSelect(state)
    if state == SelectState.active then return end
    C.SelectActive = state
    if state then
        SelectState.active = true
        scanAlliesInZone()
        if not (FallState.active and FallState.override) then
            RIV_TARGET = nil
            C.AimbotLockedTarget = nil
        end
        local count = 0
        for _ in pairs(SelectState.allies) do count = count + 1 end
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title = "Select", Text = "ACTIVÉ · " .. count .. " allié(s)", Duration = 3})
        end)
    else
        SelectState.active = false
        SelectState.allies = {}
        SelectState.alliesIds = {}
        if not (FallState.active and FallState.override) then
            RIV_TARGET = nil
            C.AimbotLockedTarget = nil
        end
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title = "Select", Text = "DÉSACTIVÉ", Duration = 2})
        end)
    end
end

-- ═══════════════════════════════════════
-- FLY
-- ═══════════════════════════════════════
local function setFly(state)
    C.Fly = state
    local hrp = getHRP(LP)
    local hum = getHum(LP)
    if state then
        if not hrp then return end
        if FlyState.bodyVel then pcall(function() FlyState.bodyVel:Destroy() end) end
        if FlyState.bodyGyro then pcall(function() FlyState.bodyGyro:Destroy() end) end
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.zero
        bv.Parent = hrp
        local bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.P = 9e4
        bg.Parent = hrp
        FlyState.bodyVel = bv
        FlyState.bodyGyro = bg
        FlyState.active = true
        if hum then hum.PlatformStand = true end
    else
        FlyState.active = false
        if FlyState.bodyVel then pcall(function() FlyState.bodyVel:Destroy() end); FlyState.bodyVel = nil end
        if FlyState.bodyGyro then pcall(function() FlyState.bodyGyro:Destroy() end); FlyState.bodyGyro = nil end
        if hum then hum.PlatformStand = false end
    end
end

RunService.RenderStepped:Connect(function()
    if not C.Fly or not FlyState.active then return end
    local hrp = getHRP(LP)
    if not hrp or not FlyState.bodyVel or not FlyState.bodyGyro then return end
    local camCF = CAM.CFrame
    local dir = Vector3.zero
    if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + camCF.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - camCF.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - camCF.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + camCF.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0, 1, 0) end
    if dir.Magnitude > 0 then dir = dir.Unit * C.FlySpeed end
    FlyState.bodyVel.Velocity = dir
    FlyState.bodyGyro.CFrame = camCF
end)

-- ═══════════════════════════════════════
-- SPINBOT / ANTI-AIM
-- ═══════════════════════════════════════
RunService.RenderStepped:Connect(function()
    if not C.Spinbot then return end
    local hrp = getHRP(LP)
    if not hrp then return end
    hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(C.SpinSpeed), 0)
end)

-- ═══════════════════════════════════════
-- LOOPS : AUTO / SILENT / MAGIC / WEAPON / HITBOX
-- ═══════════════════════════════════════
if HAS_DRAWING then
    RIV.FOVCircle = Drawing.new("Circle")
    RIV.FOVCircle.Thickness = 1.6
    RIV.FOVCircle.Color = ACCENT
    RIV.FOVCircle.Filled = false
    RIV.FOVCircle.NumSides = 64
    RIV.FOVCircle.Radius = C.AimbotFOV
    RIV.FOVCircle.Visible = false

    -- Crosshair
    for i = 1, 4 do
        local line = Drawing.new("Line")
        line.Thickness = 1.5
        line.Color = ACCENT
        line.Visible = false
        RIV.Crosshair[i] = line
    end

    RunService.RenderStepped:Connect(function()
        if RIV.FOVCircle then
            local show = C.Aimbot and C.AimbotMaster and C.AimbotFOVCircle and not (FallState.active and FallState.override)
            RIV.FOVCircle.Visible = show
            if show then
                RIV.FOVCircle.Position = Vector2.new(CAM.ViewportSize.X / 2, CAM.ViewportSize.Y / 2)
                RIV.FOVCircle.Radius = C.AimbotFOV
                RIV.FOVCircle.Color = ACCENT
            end
        end
        if C.Crosshair and RIV.Crosshair[1] then
            local cx, cy = CAM.ViewportSize.X / 2, CAM.ViewportSize.Y / 2
            local s, g = C.CrosshairSize, C.CrosshairGap
            RIV.Crosshair[1].From = Vector2.new(cx - s - g, cy); RIV.Crosshair[1].To = Vector2.new(cx - g, cy)
            RIV.Crosshair[2].From = Vector2.new(cx + g, cy); RIV.Crosshair[2].To = Vector2.new(cx + s + g, cy)
            RIV.Crosshair[3].From = Vector2.new(cx, cy - s - g); RIV.Crosshair[3].To = Vector2.new(cx, cy - g)
            RIV.Crosshair[4].From = Vector2.new(cx, cy + g); RIV.Crosshair[4].To = Vector2.new(cx, cy + s + g)
            for i = 1, 4 do
                RIV.Crosshair[i].Visible = true
                RIV.Crosshair[i].Color = ACCENT
            end
        else
            for i = 1, 4 do if RIV.Crosshair[i] then RIV.Crosshair[i].Visible = false end end
        end
    end)
end

task.spawn(function()
    while true do
        task.wait(C.AutoShootDelay)
        if not C.AutoShoot or not C.AimbotMaster then continue end
        local t = getClosestToCursor(C.AimbotFOV, C.AimbotWallCheck, C.AimbotVisCheck, C.AimbotBone)
        if not t then continue end
        local tool = LP.Character and LP.Character:FindFirstChildOfClass("Tool")
        if tool then pcall(function() tool:Activate() end) end
    end
end)

task.spawn(function()
    while true do
        task.wait(C.TriggerBotDelay)
        if not C.TriggerBot then continue end
        local t = getClosestToCursor(45, false, false, "Head")
        if not t then continue end
        local tool = LP.Character and LP.Character:FindFirstChildOfClass("Tool")
        if tool then pcall(function() tool:Activate() end) end
    end
end)

RunService.RenderStepped:Connect(function()
    if not C.AimAssist then return end
    local t = getClosestToCursor(C.AimAssistFOV, false, false, "Head")
    if not t then return end
    local head = getBone(t, "Head")
    if not head then return end
    local cur = CAM.CFrame
    CAM.CFrame = cur:Lerp(CFrame.new(cur.Position, head.Position), C.AimAssistStrength * 0.12)
end)

RunService.RenderStepped:Connect(function()
    if not C.SilentAim then RIV_SILENT_POS = nil; return end
    local t = getClosestToCursor(C.SilentAimFOV, C.SilentAimWallCheck, C.SilentAimVisCheck, C.SilentAimBone)
    if t then
        local head = getBone(t, C.SilentAimBone)
        if head then RIV_SILENT_POS = head.Position end
    else RIV_SILENT_POS = nil end
end)

RunService.RenderStepped:Connect(function()
    if not C.MagicBullet then RIV_MAGIC_POS = nil; return end
    local t = getClosestToCursor(C.MagicBulletFOV, false, false, "Head")
    if t then
        local head = getBone(t, "Head")
        if head then RIV_MAGIC_POS = head.Position end
    else RIV_MAGIC_POS = nil end
end)

local hookedWeapons = {}
local function hookWeapon(w)
    if hookedWeapons[w] then return end
    hookedWeapons[w] = true
    local function apply()
        for _, prop in ipairs({"Recoil", "RecoilX", "RecoilY", "Spread", "SpreadX", "SpreadY", "CameraShake", "Shake"}) do
            pcall(function() if w[prop] ~= nil and (C.NoRecoil or C.NoSpread) then w[prop] = 0 end end)
        end
        for _, prop in ipairs({"ReloadTime", "ReloadSpeed", "ReloadDuration"}) do
            pcall(function() if w[prop] ~= nil and C.NoReload then w[prop] = 0 end end)
        end
        for _, prop in ipairs({"FireRate", "FireDelay", "Cooldown", "Debounce"}) do
            pcall(function() if w[prop] ~= nil and C.RapidFire then w[prop] = w[prop] / math.max(1, C.RapidFireMulti) end end)
        end
        for _, prop in ipairs({"Ammo", "MaxAmmo", "ClipSize", "Magazine", "CurrentAmmo"}) do
            pcall(function() if w[prop] ~= nil and C.InfiniteAmmo then w[prop] = 9999 end end)
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
            local n = c.Name:lower()
            if n:find("weapon") or n:find("gun") or n:find("tool") or n:find("viewmodel") then
                hookWeapon(c)
                for _, d in ipairs(c:GetDescendants()) do
                    if d:IsA("Model") or d:IsA("Folder") then hookWeapon(d) end
                end
            end
        end
    end)
    pcall(function()
        local ch = LP.Character
        if ch then for _, t in ipairs(ch:GetChildren()) do if t:IsA("Tool") then hookWeapon(t) end end end
    end)
    pcall(function()
        local bp = LP:FindFirstChild("Backpack")
        if bp then for _, t in ipairs(bp:GetChildren()) do if t:IsA("Tool") then hookWeapon(t) end end end
    end)
end

task.spawn(function() while true do task.wait(1); scanWeapons() end end)

task.spawn(function()
    while true do
        task.wait(0.2)
        if C.HitboxExpander then
            for _, p in ipairs(Players:GetPlayers()) do
                if isRival(p) and not isPartner(p) and not sameTeam(LP, p) and not isAlly(p) then
                    local ch = p.Character
                    if ch then
                        for _, part in ipairs(ch:GetChildren()) do
                            if part:IsA("BasePart") and (part.Name == "Head" or part.Name == "Torso" or part.Name == "UpperTorso" or part.Name == "HumanoidRootPart") then
                                if not RIV.Hitboxes[part] then RIV.Hitboxes[part] = part.Size end
                                pcall(function()
                                    part.Size = Vector3.new(C.HitboxSize, C.HitboxSize, C.HitboxSize)
                                    part.Transparency = C.HitboxTransparency
                                    part.CanCollide = false
                                end)
                            end
                        end
                    end
                end
            end
        else
            for part, sz in pairs(RIV.Hitboxes) do
                if part and part.Parent then
                    pcall(function() part.Size = sz; part.Transparency = 0 end)
                end
                RIV.Hitboxes[part] = nil
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if C.FOVChanger then CAM.FieldOfView = C.FOVValue end
        if C.SpeedHack then
            local hum = getHum()
            if hum and hum.WalkSpeed ~= C.SpeedValue then hum.WalkSpeed = C.SpeedValue end
        end
        if C.ThirdPerson then
            CAM.CameraType = Enum.CameraType.Custom
            local hrp = getHRP(LP)
            if hrp then
                CAM.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 2, C.ThirdPersonDist), hrp.Position)
            end
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

LP.CharacterAdded:Connect(function(ch)
    if C.Noclip then
        task.wait(0.1)
        for _, p in ipairs(ch:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false; p.CanTouch = false; p.CanQuery = false end
        end
    end
end)

UIS.JumpRequest:Connect(function()
    if C.InfJump then
        local hum = getHum()
        if hum then pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end) end
    end
end)

-- Bhop
RunService.RenderStepped:Connect(function()
    if not C.Bhop then return end
    local hum = getHum()
    if not hum then return end
    if hum:GetState() == Enum.HumanoidStateType.Freefall or hum:GetState() == Enum.HumanoidStateType.Jumping then
        local hrp = getHRP()
        if hrp then
            local vel = hrp.AssemblyLinearVelocity
            local dir = Vector3.new(vel.X, 0, vel.Z)
            if dir.Magnitude > 1 then
                hrp.AssemblyLinearVelocity = Vector3.new(dir.Unit.X * C.SpeedValue * 1.15, vel.Y, dir.Unit.Z * C.SpeedValue * 1.15)
            end
        end
    end
end)

scanFireRemotes()
installFireHook()
installCameraHook()

-- ═══════════════════════════════════════
-- ESP
-- ═══════════════════════════════════════
local function createESP(plr)
    if plr == LP or RIV.ESPObjs[plr] or not HAS_DRAWING then return end
    local box = Drawing.new("Square"); box.Thickness = 2; box.Filled = false; box.Visible = false
    local boxGlow = Drawing.new("Square"); boxGlow.Thickness = 4; boxGlow.Filled = false; boxGlow.Visible = false; boxGlow.Transparency = 0.85
    local nameBg = Drawing.new("Square"); nameBg.Thickness = 1; nameBg.Filled = true; nameBg.Visible = false; nameBg.Color = Color3.fromRGB(0,0,0); nameBg.Transparency = 0.4
    local name = Drawing.new("Text"); name.Center = true; name.Outline = true; name.Size = 14; name.Visible = false; name.Font = 2
    local dist = Drawing.new("Text"); dist.Center = true; dist.Outline = true; dist.Size = 12; dist.Visible = false; dist.Font = 2
    local weapon = Drawing.new("Text"); weapon.Center = true; weapon.Outline = true; weapon.Size = 11; weapon.Visible = false; weapon.Font = 2
    local hpBarBg = Drawing.new("Square"); hpBarBg.Thickness = 1; hpBarBg.Filled = true; hpBarBg.Visible = false; hpBarBg.Color = Color3.fromRGB(20,20,30); hpBarBg.Transparency = 0.15
    local hpBar = Drawing.new("Square"); hpBar.Thickness = 1; hpBar.Filled = true; hpBar.Visible = false
    local tracer = Drawing.new("Line"); tracer.Thickness = 1.4; tracer.Visible = false
    local headDot = Drawing.new("Circle"); headDot.Thickness = 2; headDot.Filled = true; headDot.NumSides = 16; headDot.Radius = 4.5; headDot.Visible = false
    local chams = Drawing.new("Square"); chams.Thickness = 1; chams.Filled = true; chams.Color = P.Accent; chams.Transparency = 0.78; chams.Visible = false
    local c1 = Drawing.new("Line"); c1.Thickness = 2; c1.Visible = false
    local c2 = Drawing.new("Line"); c2.Thickness = 2; c2.Visible = false
    local c3 = Drawing.new("Line"); c3.Thickness = 2; c3.Visible = false
    local c4 = Drawing.new("Line"); c4.Thickness = 2; c4.Visible = false
    RIV.ESPObjs[plr] = {
        Box = box, BoxGlow = boxGlow, NameBg = nameBg, Name = name, Dist = dist, Weapon = weapon,
        HPBarBg = hpBarBg, HPBar = hpBar, Tracer = tracer, HeadDot = headDot, Chams = chams,
        Corner1 = c1, Corner2 = c2, Corner3 = c3, Corner4 = c4,
    }
end

local function removeESP(plr)
    local e = RIV.ESPObjs[plr]
    if e then for _, d in pairs(e) do pcall(function() d:Remove() end) end; RIV.ESPObjs[plr] = nil end
end

local function hideESP(e)
    pcall(function()
        e.Box.Visible = false; e.BoxGlow.Visible = false
        e.NameBg.Visible = false; e.Name.Visible = false
        e.Dist.Visible = false; e.Weapon.Visible = false
        e.HPBarBg.Visible = false; e.HPBar.Visible = false
        e.Tracer.Visible = false; e.HeadDot.Visible = false; e.Chams.Visible = false
        e.Corner1.Visible = false; e.Corner2.Visible = false
        e.Corner3.Visible = false; e.Corner4.Visible = false
    end)
end

for _, p in ipairs(Players:GetPlayers()) do createESP(p) end
Players.PlayerAdded:Connect(function(p) task.wait(1); if p and p.Parent then createESP(p) end end)
Players.PlayerRemoving:Connect(function(p) removeESP(p) end)

RunService.RenderStepped:Connect(function()
    if not HAS_DRAWING then return end
    if not C.ESP then for _, e in pairs(RIV.ESPObjs) do hideESP(e) end; return end
    local cam = workspace.CurrentCamera
    if not cam then return end
    local myHRP = getHRP(LP)
    local myPos = myHRP and myHRP.Position

    for plr, e in pairs(RIV.ESPObjs) do
        local ok = pcall(function() return e.Box.Visible end)
        if not ok then RIV.ESPObjs[plr] = nil; continue end
        if not isRival(plr) or isPartner(plr) or sameTeam(LP, plr) or isAlly(plr) then hideESP(e); continue end

        local ch = plr.Character
        local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
        local head = ch and ch:FindFirstChild("Head")
        local hum = ch and ch:FindFirstChildOfClass("Humanoid")
        if not (hrp and head and hum and hum.Health > 0) then hideESP(e); continue end

        local hp, hon = cam:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
        local fp, fon = cam:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
        if not (hon or fon) then hideESP(e); continue end

        local h = math.abs(hp.Y - fp.Y)
        local w = h / 2
        local boxX, boxY = hp.X - w / 2, hp.Y
        local col = P.Danger

        if C.ESPChams then
            pcall(function()
                e.Chams.Size = Vector2.new(w + 8, h + 8)
                e.Chams.Position = Vector2.new(boxX - 4, boxY - 4)
                e.Chams.Color = Color3.fromHSV((tick() * 0.28) % 1, 0.55, 1)
                e.Chams.Visible = true
            end)
        else pcall(function() e.Chams.Visible = false end) end

        if C.ESPBox then
            pcall(function()
                e.BoxGlow.Size = Vector2.new(w + 4, h + 4)
                e.BoxGlow.Position = Vector2.new(boxX - 2, boxY - 2)
                e.BoxGlow.Color = Color3.fromHSV((tick() * 0.35) % 1, 0.9, 1)
                e.BoxGlow.Visible = true
                e.Box.Size = Vector2.new(w, h)
                e.Box.Position = Vector2.new(boxX, boxY)
                e.Box.Color = col
                e.Box.Visible = true
            end)
            local cLen = w * 0.22
            pcall(function()
                e.Corner1.From = Vector2.new(boxX, boxY); e.Corner1.To = Vector2.new(boxX + cLen, boxY); e.Corner1.Color = col; e.Corner1.Visible = true
                e.Corner2.From = Vector2.new(boxX, boxY); e.Corner2.To = Vector2.new(boxX, boxY + cLen); e.Corner2.Color = col; e.Corner2.Visible = true
                e.Corner3.From = Vector2.new(boxX + w, boxY + h); e.Corner3.To = Vector2.new(boxX + w - cLen, boxY + h); e.Corner3.Color = col; e.Corner3.Visible = true
                e.Corner4.From = Vector2.new(boxX + w, boxY + h); e.Corner4.To = Vector2.new(boxX + w, boxY + h - cLen); e.Corner4.Color = col; e.Corner4.Visible = true
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
                e.Name.Position = Vector2.new(hp.X, boxY - 20)
                e.Name.Color = P.Text
                e.Name.Visible = true
                e.NameBg.Size = Vector2.new(w + 28, 16)
                e.NameBg.Position = Vector2.new(hp.X - (w + 28) / 2, boxY - 26)
                e.NameBg.Visible = true
            end)
        else pcall(function() e.Name.Visible = false; e.NameBg.Visible = false end) end

        if C.ESPHealth then
            local ratio = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
            local barX, barY, barW, barH = boxX - 7, boxY, 3.5, h
            pcall(function()
                e.HPBarBg.Size = Vector2.new(barW + 2, barH + 2)
                e.HPBarBg.Position = Vector2.new(barX - 1, barY - 1)
                e.HPBarBg.Visible = true
                e.HPBar.Size = Vector2.new(barW, barH * ratio)
                e.HPBar.Position = Vector2.new(barX, barY + barH * (1 - ratio))
                e.HPBar.Color = ratio > 0.55 and Color3.fromRGB(90, 230, 150) or (ratio > 0.28 and Color3.fromRGB(255, 190, 80) or Color3.fromRGB(255, 80, 100))
                e.HPBar.Visible = true
            end)
        else pcall(function() e.HPBar.Visible = false; e.HPBarBg.Visible = false end) end

        if C.ESPDistance and myPos then
            pcall(function()
                e.Dist.Text = string.format("[%.0fm]", (hrp.Position - myPos).Magnitude)
                e.Dist.Position = Vector2.new(hp.X, boxY + h + 3)
                e.Dist.Color = P.TextDim
                e.Dist.Visible = true
            end)
        else pcall(function() e.Dist.Visible = false end) end

        if C.ESPWeapon then
            local tool = ch:FindFirstChildOfClass("Tool")
            pcall(function()
                e.Weapon.Text = tool and tool.Name or ""
                e.Weapon.Position = Vector2.new(hp.X, boxY + h + 16)
                e.Weapon.Color = P.Accent2
                e.Weapon.Visible = tool ~= nil
            end)
        else pcall(function() e.Weapon.Visible = false end) end

        if C.ESPTracer then
            pcall(function()
                e.Tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                e.Tracer.To = Vector2.new(hp.X, hp.Y)
                e.Tracer.Color = col
                e.Tracer.Visible = true
            end)
        else pcall(function() e.Tracer.Visible = false end) end

        if C.ESPHeadDot then
            pcall(function()
                e.HeadDot.Position = Vector2.new(hp.X, hp.Y)
                e.HeadDot.Color = P.Warn
                e.HeadDot.Visible = true
            end)
        else pcall(function() e.HeadDot.Visible = false end) end
    end
end)

local SKELETON_BONES = {
    {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"RightLowerArm", "RightHand"},
    {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}, {"RightLowerLeg", "RightFoot"},
}

local skeletonLines = {}
local function ensureSkeleton(plr)
    if skeletonLines[plr] then return skeletonLines[plr] end
    if not HAS_DRAWING then return nil end
    local lines = {}
    for i = 1, #SKELETON_BONES do
        local l = Drawing.new("Line"); l.Thickness = 1.4; l.Visible = false; l.Color = P.Accent
        lines[i] = l
    end
    skeletonLines[plr] = lines
    return lines
end

RunService.RenderStepped:Connect(function()
    if not HAS_DRAWING or not (C.ESP and C.ESPSkeleton) then
        for _, lines in pairs(skeletonLines) do for _, l in ipairs(lines) do pcall(function() l.Visible = false end) end end
        return
    end
    local cam = workspace.CurrentCamera
    if not cam then return end
    for plr, _ in pairs(RIV.ESPObjs) do
        if isRival(plr) and not isPartner(plr) and not sameTeam(LP, plr) and not isAlly(plr) then
            local lines = ensureSkeleton(plr)
            if lines then
                local ch = plr.Character
                for i, pair in ipairs(SKELETON_BONES) do
                    local a = ch and ch:FindFirstChild(pair[1])
                    local b = ch and ch:FindFirstChild(pair[2])
                    if a and b and a:IsA("BasePart") and b:IsA("BasePart") then
                        local ap, aon = cam:WorldToViewportPoint(a.Position)
                        local bp, bon = cam:WorldToViewportPoint(b.Position)
                        if aon and bon then
                            pcall(function()
                                lines[i].From = Vector2.new(ap.X, ap.Y)
                                lines[i].To = Vector2.new(bp.X, bp.Y)
                                lines[i].Color = Color3.fromHSV((tick() * 0.28 + i * 0.04) % 1, 0.65, 1)
                                lines[i].Visible = true
                            end)
                        else pcall(function() lines[i].Visible = false end) end
                    else pcall(function() lines[i].Visible = false end) end
                end
            end
        else
            local lines = skeletonLines[plr]
            if lines then for _, l in ipairs(lines) do pcall(function() l.Visible = false end) end end
        end
    end
end)

-- ═══════════════════════════════════════
-- RADAR
-- ═══════════════════════════════════════
local function buildRadar()
    if RIV.RadarGui and RIV.RadarGui.Parent then return end
    local g = new("ScreenGui", {Name = "LeolaRadar", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 998, Parent = PG})
    RIV.RadarGui = g
    local frame = new("Frame", {
        Size = UDim2.new(0, 190, 0, 190), Position = UDim2.new(1, -210, 0, 18),
        BackgroundColor3 = P.BgBase, BackgroundTransparency = 0.12, BorderSizePixel = 0, Parent = g,
    })
    corner(frame, 12)
    stroke(frame, P.Border, 1, 0.25)
    grad(frame, {{0, P.BgBase}, {1, P.BgDeep}}, 140)
    new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 20), Position = UDim2.new(0, 0, 0, 5),
        BackgroundTransparency = 1, Text = "RADAR", TextColor3 = P.Accent,
        Font = Enum.Font.GothamBold, TextSize = 11, Parent = frame,
    })
    local center = new("Frame", {
        Size = UDim2.new(0, 5, 0, 5), Position = UDim2.new(0.5, -2.5, 0.5, -2.5),
        BackgroundColor3 = P.Accent, BorderSizePixel = 0, Parent = frame,
    })
    corner(center, 3)
    local circle = new("Frame", {
        Size = UDim2.new(0, 110, 0, 110), Position = UDim2.new(0.5, -55, 0.5, -55),
        BackgroundTransparency = 1, BorderSizePixel = 0, Parent = frame,
    })
    corner(circle, 55)
    stroke(circle, P.BorderSoft, 1, 0.45)

    task.spawn(function()
        while g.Parent do
            task.wait(0.1)
            for _, c in ipairs(frame:GetChildren()) do
                if c:IsA("Frame") and c ~= center and c ~= circle and c.BackgroundTransparency ~= 0.6 then c:Destroy() end
            end
            if C.Radar then
                local myHRP = getHRP(LP)
                if myHRP then
                    for _, p in ipairs(Players:GetPlayers()) do
                        if isRival(p) and not isPartner(p) and not sameTeam(LP, p) and not isAlly(p) then
                            local hrp = getHRP(p)
                            if hrp then
                                local rel = hrp.Position - myHRP.Position
                                local scale = 170 / 280
                                local x = math.clamp(95 + rel.X * scale, 6, 184)
                                local z = math.clamp(95 + rel.Z * scale, 24, 184)
                                local dot = new("Frame", {
                                    Size = UDim2.new(0, 5, 0, 5), Position = UDim2.new(0, x, 0, z),
                                    BackgroundColor3 = P.Danger, BorderSizePixel = 0, Parent = frame,
                                })
                                corner(dot, 3)
                            end
                        end
                    end
                end
            end
        end
    end)
end

-- ═══════════════════════════════════════
-- SNOW + UI BUILDERS
-- ═══════════════════════════════════════
local function startSnow(parent)
    local snowLayer = new("Frame", {
        Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1,
        ClipsDescendants = true, ZIndex = 5, Parent = parent,
    })
    corner(snowLayer, 14)
    S.SnowLayer = snowLayer
    task.spawn(function()
        while snowLayer and snowLayer.Parent do
            if C.SnowEnabled then
                local size = math.random(2, 4)
                local x = math.random(0, math.max(1, math.floor(snowLayer.AbsoluteSize.X)))
                local dur = math.random(4, 8) + math.random()
                local flake = new("Frame", {
                    Size = UDim2.new(0, size, 0, size), Position = UDim2.new(0, x, 0, -8),
                    BackgroundColor3 = Color3.fromRGB(240, 240, 255),
                    BackgroundTransparency = 0.3 + math.random() * 0.4,
                    BorderSizePixel = 0, ZIndex = 6, Parent = snowLayer,
                })
                corner(flake, size)
                local drift = math.random(-25, 25)
                local tw = TweenService:Create(flake, TweenInfo.new(dur, Enum.EasingStyle.Linear), {
                    Position = UDim2.new(0, x + drift, 1, 8), BackgroundTransparency = 1,
                })
                tw:Play()
                tw.Completed:Connect(function() if flake and flake.Parent then flake:Destroy() end end)
            end
            task.wait(0.09)
        end
    end)
end

local function makeNavItem(parent, label, pageId, order)
    local btn = new("TextButton", {
        Size = UDim2.new(1, 0, 0, 36), BackgroundColor3 = P.BgCard,
        BackgroundTransparency = 1, BorderSizePixel = 0, Text = "",
        AutoButtonColor = false, LayoutOrder = order, Parent = parent,
    })
    corner(btn, 9)
    local bar = new("Frame", {
        Size = UDim2.new(0, 3, 0, 0), Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = P.Accent, BorderSizePixel = 0, Parent = btn,
    })
    corner(bar, 2)
    local lbl = new("TextLabel", {
        Size = UDim2.new(1, -18, 1, 0), Position = UDim2.new(0, 14, 0, 0),
        BackgroundTransparency = 1, Text = label, TextColor3 = P.TextDim,
        Font = Enum.Font.GothamMedium, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = btn,
    })
    local function setActive(active)
        if active then
            TweenService:Create(btn, TweenInfo.new(0.22), {BackgroundTransparency = 0.65}):Play()
            TweenService:Create(bar, TweenInfo.new(0.28, Enum.EasingStyle.Back), {Size = UDim2.new(0, 3, 0, 20)}):Play()
            TweenService:Create(lbl, TweenInfo.new(0.18), {TextColor3 = P.Accent}):Play()
        else
            TweenService:Create(btn, TweenInfo.new(0.18), {BackgroundTransparency = 1}):Play()
            TweenService:Create(bar, TweenInfo.new(0.18), {Size = UDim2.new(0, 3, 0, 0)}):Play()
            TweenService:Create(lbl, TweenInfo.new(0.18), {TextColor3 = P.TextDim}):Play()
        end
    end
    btn.MouseEnter:Connect(function()
        if S.CurrentPage ~= pageId then
            TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundTransparency = 0.82}):Play()
            TweenService:Create(lbl, TweenInfo.new(0.12), {TextColor3 = P.Text}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if S.CurrentPage ~= pageId then
            TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundTransparency = 1}):Play()
            TweenService:Create(lbl, TweenInfo.new(0.12), {TextColor3 = P.TextDim}):Play()
        end
    end)
    btn.MouseButton1Click:Connect(function()
        S.CurrentPage = pageId
        for id, fn in pairs(S.NavButtons) do fn(id == pageId) end
        for name, pg in pairs(S.Pages) do pg.frame.Visible = (name == pageId) end
    end)
    S.NavButtons[pageId] = setActive
    S.NavOrder[#S.NavOrder+1] = {btn = btn, page = pageId}
    return btn
end

local function makeSection(parent, order, text)
    local h = new("Frame", {Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1, LayoutOrder = order, Parent = parent})
    local dot = new("Frame", {
        Size = UDim2.new(0, 5, 0, 5), Position = UDim2.new(0, 2, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = P.Accent, BorderSizePixel = 0, Parent = h,
    })
    corner(dot, 3)
    new("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0), Position = UDim2.new(0, 14, 0, 0),
        BackgroundTransparency = 1, Text = string.upper(text), TextColor3 = P.TextFaint,
        Font = Enum.Font.GothamBold, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, Parent = h,
    })
    new("Frame", {
        Size = UDim2.new(1, -18, 0, 1), Position = UDim2.new(0, 14, 1, -1),
        BackgroundColor3 = P.BorderSoft, BackgroundTransparency = 0.35, BorderSizePixel = 0, Parent = h,
    })
end

local function makeToggle(parent, order, label, desc, getter, setter)
    local card = new("TextButton", {
        Size = UDim2.new(1, 0, 0, 48), BackgroundColor3 = P.BgCard,
        BackgroundTransparency = 0.12, BorderSizePixel = 0, Text = "",
        AutoButtonColor = false, LayoutOrder = order, Parent = parent,
    })
    corner(card, 11)
    stroke(card, P.BorderSoft, 1, 0.28)
    local acc = new("Frame", {
        Size = UDim2.new(0, 3, 0, 26), Position = UDim2.new(0, 12, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = getter() and P.Accent or P.TextFaint, BorderSizePixel = 0, Parent = card,
    })
    corner(acc, 2)
    new("TextLabel", {
        Size = UDim2.new(1, -95, 0, 15), Position = UDim2.new(0, 26, 0, 7),
        BackgroundTransparency = 1, Text = label, TextColor3 = P.Text,
        Font = Enum.Font.GothamBold, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, Parent = card,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -95, 0, 13), Position = UDim2.new(0, 26, 0, 24),
        BackgroundTransparency = 1, Text = desc or "", TextColor3 = P.TextFaint,
        Font = Enum.Font.Gotham, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, Parent = card,
    })
    local pill = new("Frame", {
        Size = UDim2.new(0, 36, 0, 18), Position = UDim2.new(1, -48, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = getter() and P.Accent or P.Border, BorderSizePixel = 0, Parent = card,
    })
    corner(pill, 9)
    local knob = new("Frame", {
        Size = UDim2.new(0, 14, 0, 14),
        Position = getter() and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255,255,255), BorderSizePixel = 0, Parent = pill,
    })
    corner(knob, 7)
    local function refresh()
        local on = getter()
        acc.BackgroundColor3 = on and P.Accent or P.TextFaint
        TweenService:Create(pill, TweenInfo.new(0.18), {BackgroundColor3 = on and P.Accent or P.Border}):Play()
        TweenService:Create(knob, TweenInfo.new(0.22, Enum.EasingStyle.Back), {
            Position = on and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
        }):Play()
    end
    card.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.12), {BackgroundColor3 = P.BgHover, BackgroundTransparency = 0.04}):Play()
    end)
    card.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.12), {BackgroundColor3 = P.BgCard, BackgroundTransparency = 0.12}):Play()
    end)
    card.MouseButton1Click:Connect(function() setter(not getter()); refresh() end)
    S.NavItems[#S.NavItems+1] = {card = card, refresh = refresh, setter = setter, getter = getter}
    return card
end

local function makeSlider(parent, order, label, minV, maxV, getter, setter)
    local card = new("Frame", {
        Size = UDim2.new(1, 0, 0, 48), BackgroundColor3 = P.BgCard,
        BackgroundTransparency = 0.12, BorderSizePixel = 0, LayoutOrder = order, Parent = parent,
    })
    corner(card, 11)
    stroke(card, P.BorderSoft, 1, 0.28)
    new("TextLabel", {
        Size = UDim2.new(0, 150, 0, 13), Position = UDim2.new(0, 18, 0, 7),
        BackgroundTransparency = 1, Text = label, TextColor3 = P.TextDim,
        Font = Enum.Font.GothamBold, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, Parent = card,
    })
    local val = new("TextLabel", {
        Size = UDim2.new(0, 70, 0, 13), Position = UDim2.new(1, -80, 0, 7),
        BackgroundTransparency = 1, Text = tostring(getter()), TextColor3 = P.Accent,
        Font = Enum.Font.GothamBold, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Right, Parent = card,
    })
    local trackBg = new("Frame", {
        Size = UDim2.new(1, -44, 0, 5), Position = UDim2.new(0, 22, 0, 32),
        BackgroundColor3 = P.BorderSoft, BorderSizePixel = 0, Parent = card,
    })
    corner(trackBg, 3)
    local ratio = math.clamp((getter() - minV) / (maxV - minV), 0, 1)
    local fill = new("Frame", {Size = UDim2.new(ratio, 0, 1, 0), BackgroundColor3 = P.Accent, BorderSizePixel = 0, Parent = trackBg})
    corner(fill, 3)
    grad(fill, {{0, P.Accent}, {1, P.Accent2}}, 0)
    local knob = new("Frame", {
        Size = UDim2.new(0, 12, 0, 12), Position = UDim2.new(ratio, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255,255,255), BorderSizePixel = 0, Parent = trackBg,
    })
    corner(knob, 6)
    stroke(knob, P.Accent, 1.5, 0)
    local hit = new("TextButton", {
        Size = UDim2.new(1, -44, 0, 22), Position = UDim2.new(0, 22, 0, 18),
        BackgroundTransparency = 1, Text = "", AutoButtonColor = false, Parent = card,
    })
    local dragging = false
    local function apply(xAbs)
        local tp, tw = trackBg.AbsolutePosition.X, trackBg.AbsoluteSize.X
        if tw <= 0 then return end
        local r = math.clamp((xAbs - tp) / tw, 0, 1)
        local v = math.floor((minV + r * (maxV - minV)) * 10 + 0.5) / 10
        setter(v)
        knob.Position = UDim2.new(r, 0, 0.5, 0)
        fill.Size = UDim2.new(r, 0, 1, 0)
        val.Text = tostring(v)
    end
    hit.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; apply(input.Position.X)
        end
    end)
    hit.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            apply(input.Position.X)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
    S.NavItems[#S.NavItems+1] = {
        card = card,
        step = function(dir)
            local v = math.clamp(getter() + dir * ((maxV - minV) / 20), minV, maxV)
            v = math.floor(v * 10 + 0.5) / 10
            setter(v)
            local r = (v - minV) / (maxV - minV)
            knob.Position = UDim2.new(r, 0, 0.5, 0)
            fill.Size = UDim2.new(r, 0, 1, 0)
            val.Text = tostring(v)
        end,
    }
    return card
end

local function makeButton(parent, order, label, desc, color, onClick)
    local card = new("TextButton", {
        Size = UDim2.new(1, 0, 0, 48), BackgroundColor3 = P.BgCard,
        BackgroundTransparency = 0.12, BorderSizePixel = 0, Text = "",
        AutoButtonColor = false, LayoutOrder = order, Parent = parent,
    })
    corner(card, 11)
    stroke(card, P.BorderSoft, 1, 0.28)
    local acc = new("Frame", {
        Size = UDim2.new(0, 3, 0, 26), Position = UDim2.new(0, 12, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = color or P.Accent, BorderSizePixel = 0, Parent = card,
    })
    corner(acc, 2)
    local lbl = new("TextLabel", {
        Size = UDim2.new(1, -55, 0, 15), Position = UDim2.new(0, 26, 0, 7),
        BackgroundTransparency = 1, Text = label, TextColor3 = P.Text,
        Font = Enum.Font.GothamBold, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, Parent = card,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -55, 0, 13), Position = UDim2.new(0, 26, 0, 24),
        BackgroundTransparency = 1, Text = desc or "", TextColor3 = P.TextFaint,
        Font = Enum.Font.Gotham, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, Parent = card,
    })
    card.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.12), {BackgroundColor3 = P.BgHover, BackgroundTransparency = 0.04}):Play()
        TweenService:Create(lbl, TweenInfo.new(0.12), {TextColor3 = color or P.Accent}):Play()
    end)
    card.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.12), {BackgroundColor3 = P.BgCard, BackgroundTransparency = 0.12}):Play()
        TweenService:Create(lbl, TweenInfo.new(0.12), {TextColor3 = P.Text}):Play()
    end)
    card.MouseButton1Click:Connect(onClick)
    S.NavItems[#S.NavItems+1] = {card = card, action = function() onClick() end}
    return card
end

local function createAnimatedBackground(parent)
    local bg = new("Frame", {
        Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = P.BgDeep, BorderSizePixel = 0, ZIndex = 1, Parent = parent,
    })
    corner(bg, 14)
    local g = grad(bg, {{0, P.BgDeep}, {0.5, Color3.fromRGB(18, 14, 28)}, {1, P.BgDeep}}, 40)
    local orbs = {}
    for i = 1, 4 do
        local orb = new("Frame", {
            Size = UDim2.new(0, 200, 0, 200), Position = UDim2.new(math.random(), 0, math.random(), 0),
            BackgroundColor3 = (i % 2 == 0) and P.Accent or P.Accent2,
            BackgroundTransparency = 0.88, BorderSizePixel = 0, ZIndex = 2, Parent = bg,
        })
        corner(orb, 100)
        table.insert(orbs, orb)
    end
    task.spawn(function()
        while bg.Parent do
            task.wait(0.016)
            for i, orb in ipairs(orbs) do
                local t = tick() * 0.28 + i * 1.4
                pcall(function()
                    orb.Position = UDim2.new(0.5 + math.sin(t) * 0.32, -100, 0.5 + math.cos(t * 0.75) * 0.32, -100)
                end)
            end
            pcall(function() g.Rotation = (tick() * 18) % 360 end)
        end
    end)
    local glass = new("Frame", {
        Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = Color3.fromRGB(0,0,0),
        BackgroundTransparency = 0.32, BorderSizePixel = 0, ZIndex = 3, Parent = bg,
    })
    corner(glass, 14)
    return bg
end

-- ═══════════════════════════════════════
-- OUTFIT
-- ═══════════════════════════════════════
local OUTFITS = {
    {name = "Default", userId = 1},
    {name = "Noob", userId = 261},
    {name = "Builderman", userId = 156},
    {name = "Shedletsky", userId = 261},
    {name = "Pink Girl", userId = 124322466},
    {name = "Red Ninja", userId = 19578790},
    {name = "Black Suit", userId = 7},
}

local function applyOutfitByUserId(userId)
    pcall(function()
        local desc = Players:GetHumanoidDescriptionFromUserId(userId)
        local hum = getHum(LP)
        if hum and desc then
            hum:ApplyDescription(desc)
            pcall(function()
                StarterGui:SetCore("SendNotification", {Title = "Outfit", Text = "ID " .. userId .. " appliqué", Duration = 2})
            end)
        end
    end)
end

local function resetOutfit()
    pcall(function()
        local desc = Players:GetHumanoidDescriptionFromUserId(LP.UserId)
        local hum = getHum(LP)
        if hum and desc then
            hum:ApplyDescription(desc)
            pcall(function()
                StarterGui:SetCore("SendNotification", {Title = "Outfit", Text = "Tenue d'origine", Duration = 2})
            end)
        end
    end)
end

local function saveCurrentOutfit()
    pcall(function()
        local hum = getHum(LP)
        if hum then
            C.SavedOutfit = hum:GetAppliedDescription()
            pcall(function()
                StarterGui:SetCore("SendNotification", {Title = "Outfit", Text = "Sauvegardée", Duration = 2})
            end)
        end
    end)
end

local function loadSavedOutfit()
    if not C.SavedOutfit then
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title = "Outfit", Text = "Aucune sauvegarde", Duration = 2})
        end)
        return
    end
    pcall(function()
        local hum = getHum(LP)
        if hum then
            hum:ApplyDescription(C.SavedOutfit)
            pcall(function()
                StarterGui:SetCore("SendNotification", {Title = "Outfit", Text = "Chargée", Duration = 2})
            end)
        end
    end)
end

local function applyCustomOutfit(inputText)
    local id = tonumber(inputText)
    if not id then
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title = "Outfit", Text = "ID invalide", Duration = 2})
        end)
        return
    end
    applyOutfitByUserId(id)
end

-- ═══════════════════════════════════════
-- BUILD UI
-- ═══════════════════════════════════════
local function buildUI()
    local gui = new("ScreenGui", {
        Name = "leolabakaka", ResetOnSpawn = false, IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 999, Parent = PG,
    })
    S.Gui = gui

    local main = new("Frame", {
        Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = P.BgBase,
        BorderSizePixel = 0, Active = true, Draggable = true, ClipsDescendants = true, Parent = gui,
    })
    corner(main, 14)
    stroke(main, P.Border, 1.1, 0.18)
    S.Main = main

    createAnimatedBackground(main)
    startSnow(main)

    local side = new("Frame", {
        Size = UDim2.new(0, 195, 1, 0), BackgroundColor3 = P.BgBase,
        BackgroundTransparency = 0.28, BorderSizePixel = 0, ZIndex = 10, Parent = main,
    })
    corner(side, 14)
    stroke(side, P.BorderSoft, 1, 0.45)

    local header = new("Frame", {Size = UDim2.new(1, 0, 0, 72), BackgroundTransparency = 1, ZIndex = 11, Parent = side})
    local logoBox = new("Frame", {
        Size = UDim2.new(0, 38, 0, 38), Position = UDim2.new(0, 16, 0, 16),
        BackgroundColor3 = P.Accent, BorderSizePixel = 0, ZIndex = 12, Parent = header,
    })
    corner(logoBox, 10)
    grad(logoBox, {{0, P.Accent}, {1, P.Accent2}}, 45)
    new("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "L",
        TextColor3 = Color3.fromRGB(255,255,255), Font = Enum.Font.GothamBlack, TextSize = 20, ZIndex = 13, Parent = logoBox,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -70, 0, 18), Position = UDim2.new(0, 64, 0, 18),
        BackgroundTransparency = 1, Text = "leolabakaka", TextColor3 = P.Text,
        Font = Enum.Font.GothamBlack, TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 12, Parent = header,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -70, 0, 13), Position = UDim2.new(0, 64, 0, 38),
        BackgroundTransparency = 1, Text = "Rivals · " .. EXECUTOR,
        TextColor3 = P.TextFaint, Font = Enum.Font.Gotham, TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 12, Parent = header,
    })
    local sep = new("Frame", {
        Size = UDim2.new(1, -32, 0, 1), Position = UDim2.new(0, 16, 0, 72),
        BackgroundColor3 = P.BorderSoft, BackgroundTransparency = 0.35, BorderSizePixel = 0, ZIndex = 11, Parent = side,
    })
    grad(sep, {{0, P.Accent}, {1, P.Accent2}}, 0)

    local nav = new("ScrollingFrame", {
        Size = UDim2.new(1, -18, 1, -145), Position = UDim2.new(0, 9, 0, 82),
        BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 2,
        ScrollBarImageColor3 = P.Accent, ScrollBarImageTransparency = 0.55,
        CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y, ZIndex = 12, Parent = side,
    })
    new("UIListLayout", {Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, Parent = nav})

    local footer = new("Frame", {
        Size = UDim2.new(1, -18, 0, 46), Position = UDim2.new(0, 9, 1, -55),
        BackgroundColor3 = P.BgCard, BackgroundTransparency = 0.35, BorderSizePixel = 0, ZIndex = 12, Parent = side,
    })
    corner(footer, 9)
    stroke(footer, P.BorderSoft, 1, 0.45)
    new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 15), Position = UDim2.new(0, 0, 0, 7),
        BackgroundTransparency = 1, Text = "LEOLABAKAKA v2",
        TextColor3 = P.Accent, Font = Enum.Font.GothamBold, TextSize = 10, ZIndex = 13, Parent = footer,
    })
    new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 12), Position = UDim2.new(0, 0, 0, 24),
        BackgroundTransparency = 1, Text = "Y invis · I jump · N select · B fall · C reset",
        TextColor3 = P.TextFaint, Font = Enum.Font.Gotham, TextSize = 8, ZIndex = 13, Parent = footer,
    })

    local pageHolder = new("Frame", {
        Size = UDim2.new(1, -215, 1, -36), Position = UDim2.new(0, 205, 0, 18),
        BackgroundTransparency = 1, ZIndex = 15, Parent = main,
    })

    local function addPage(id, title)
        local f = new("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, BorderSizePixel = 0,
            ScrollBarThickness = 3, ScrollBarImageColor3 = P.Accent, ScrollBarImageTransparency = 0.35,
            CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollingDirection = Enum.ScrollingDirection.Y, Visible = false, ZIndex = 15, Parent = pageHolder,
        })
        local titleRow = new("Frame", {Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1, LayoutOrder = 0, ZIndex = 16, Parent = f})
        local titleBar = new("Frame", {
            Size = UDim2.new(0, 3, 0, 18), Position = UDim2.new(0, 0, 0, 4),
            BackgroundColor3 = P.Accent, BorderSizePixel = 0, ZIndex = 17, Parent = titleRow,
        })
        corner(titleBar, 2)
        grad(titleBar, {{0, P.Accent}, {1, P.Accent2}}, 90)
        new("TextLabel", {
            Size = UDim2.new(1, -16, 1, 0), Position = UDim2.new(0, 12, 0, 0),
            BackgroundTransparency = 1, Text = title, TextColor3 = P.Text,
            Font = Enum.Font.GothamBold, TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 17, Parent = titleRow,
        })
        local list = new("Frame", {
            Size = UDim2.new(1, -16, 0, 0), Position = UDim2.new(0, 0, 0, 38),
            BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, ZIndex = 16, Parent = f,
        })
        new("UIListLayout", {Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder, Parent = list})
        S.Pages[id] = {frame = f, list = list}
        S.PageOrder[#S.PageOrder+1] = id
        return list
    end

    local order = 0
    local function nextOrder() order = order + 1; return order end

    makeNavItem(nav, "Combat", "Combat", nextOrder())
    makeNavItem(nav, "ESP", "ESP", nextOrder())
    makeNavItem(nav, "Movement", "Movement", nextOrder())
    makeNavItem(nav, "Special", "Special", nextOrder())
    makeNavItem(nav, "Outfit", "Outfit", nextOrder())
    makeNavItem(nav, "Misc", "Misc", nextOrder())

    -- COMBAT
    local combat = addPage("Combat", "Combat")
    local o = 0
    local function co() o = o + 1; return o end

    makeSection(combat, co(), "Aimbot")
    makeToggle(combat, co(), "Aimbot", "Lock sur la tête", function() return C.Aimbot end, function(v) C.Aimbot = v end)
    makeToggle(combat, co(), "Aimbot Key (LMB)", "Actif seulement clic gauche", function() return C.AimbotKey end, function(v) C.AimbotKey = v end)
    makeToggle(combat, co(), "Aimbot Master", "Master switch", function() return C.AimbotMaster end, function(v) C.AimbotMaster = v end)
    makeToggle(combat, co(), "Lock Full", "Snap instantané", function() return C.AimbotLockFull end, function(v) C.AimbotLockFull = v end)
    makeSlider(combat, co(), "Smooth", 0.05, 1.0, function() return C.AimbotSmooth end, function(v) C.AimbotSmooth = v end)
    makeSlider(combat, co(), "FOV", 40, 1600, function() return C.AimbotFOV end, function(v) C.AimbotFOV = v end)
    makeToggle(combat, co(), "Wall Check", "Ignore murs", function() return C.AimbotWallCheck end, function(v) C.AimbotWallCheck = v end)
    makeToggle(combat, co(), "Vis Check", "Ligne de vue", function() return C.AimbotVisCheck end, function(v) C.AimbotVisCheck = v end)
    makeSlider(combat, co(), "Prediction", 0, 0.55, function() return C.AimbotPrediction end, function(v) C.AimbotPrediction = v end)
    makeToggle(combat, co(), "Team Check", "Ignore alliés", function() return C.AimbotTeamCheck end, function(v) C.AimbotTeamCheck = v end)
    makeToggle(combat, co(), "FOV Circle", "Cercle FOV", function() return C.AimbotFOVCircle end, function(v) C.AimbotFOVCircle = v end)

    makeSection(combat, co(), "Silent Aim")
    makeToggle(combat, co(), "Silent Aim", "Redirection silencieuse", function() return C.SilentAim end, function(v) C.SilentAim = v end)
    makeSlider(combat, co(), "Silent FOV", 80, 1600, function() return C.SilentAimFOV end, function(v) C.SilentAimFOV = v end)
    makeToggle(combat, co(), "Silent Wall Check", "Pas à travers murs", function() return C.SilentAimWallCheck end, function(v) C.SilentAimWallCheck = v end)

    makeSection(combat, co(), "Magic Bullet")
    makeToggle(combat, co(), "Magic Bullet", "Balles magiques tête", function() return C.MagicBullet end, function(v) C.MagicBullet = v end)
    makeSlider(combat, co(), "Magic FOV", 80, 2000, function() return C.MagicBulletFOV end, function(v) C.MagicBulletFOV = v end)
    makeToggle(combat, co(), "Wallbang", "Tir à travers murs", function() return C.MagicBulletWall end, function(v) C.MagicBulletWall = v end)

    makeSection(combat, co(), "Armes")
    makeToggle(combat, co(), "No Recoil", "Recul zéro", function() return C.NoRecoil end, function(v) C.NoRecoil = v end)
    makeToggle(combat, co(), "No Spread", "Dispersion zéro", function() return C.NoSpread end, function(v) C.NoSpread = v end)
    makeToggle(combat, co(), "No Reload", "Reload instant", function() return C.NoReload end, function(v) C.NoReload = v end)
    makeToggle(combat, co(), "Rapid Fire", "Cadence boostée", function() return C.RapidFire end, function(v) C.RapidFire = v end)
    makeSlider(combat, co(), "Rapid Multi", 1, 12, function() return C.RapidFireMulti end, function(v) C.RapidFireMulti = v end)
    makeToggle(combat, co(), "Infinite Ammo", "Munitions infinies", function() return C.InfiniteAmmo end, function(v) C.InfiniteAmmo = v end)
    makeToggle(combat, co(), "Instant Hit", "Hit instantané", function() return C.InstantHit end, function(v) C.InstantHit = v end)

    makeSection(combat, co(), "Auto Fire")
    makeToggle(combat, co(), "Auto Shoot", "Tir auto dans FOV", function() return C.AutoShoot end, function(v) C.AutoShoot = v end)
    makeSlider(combat, co(), "Auto Delay", 0.02, 0.8, function() return C.AutoShootDelay end, function(v) C.AutoShootDelay = v end)
    makeToggle(combat, co(), "Trigger Bot", "Tir si crosshair sur cible", function() return C.TriggerBot end, function(v) C.TriggerBot = v end)
    makeToggle(combat, co(), "Aim Assist", "Assistance légère", function() return C.AimAssist end, function(v) C.AimAssist = v end)
    makeSlider(combat, co(), "Assist Strength", 0.05, 1, function() return C.AimAssistStrength end, function(v) C.AimAssistStrength = v end)

    makeSection(combat, co(), "Hitbox")
    makeToggle(combat, co(), "Hitbox Expander", "Agrandit hitboxes", function() return C.HitboxExpander end, function(v) C.HitboxExpander = v end)
    makeSlider(combat, co(), "Hitbox Size", 1, 18, function() return C.HitboxSize end, function(v) C.HitboxSize = v end)
    makeSlider(combat, co(), "Hitbox Transparency", 0, 1, function() return C.HitboxTransparency end, function(v) C.HitboxTransparency = v end)

    -- ESP
    local esp = addPage("ESP", "ESP")
    o = 0
    makeSection(esp, co(), "ESP")
    makeToggle(esp, co(), "ESP Enable", "Active l'ESP", function() return C.ESP end, function(v) C.ESP = v end)
    makeToggle(esp, co(), "Box", "Cadre", function() return C.ESPBox end, function(v) C.ESPBox = v end)
    makeToggle(esp, co(), "Name", "Nom", function() return C.ESPName end, function(v) C.ESPName = v end)
    makeToggle(esp, co(), "Health", "Barre de vie", function() return C.ESPHealth end, function(v) C.ESPHealth = v end)
    makeToggle(esp, co(), "Distance", "Distance", function() return C.ESPDistance end, function(v) C.ESPDistance = v end)
    makeToggle(esp, co(), "Weapon", "Arme équipée", function() return C.ESPWeapon end, function(v) C.ESPWeapon = v end)
    makeToggle(esp, co(), "Tracer", "Ligne", function() return C.ESPTracer end, function(v) C.ESPTracer = v end)
    makeToggle(esp, co(), "Skeleton", "Squelette RGB", function() return C.ESPSkeleton end, function(v) C.ESPSkeleton = v end)
    makeToggle(esp, co(), "Chams", "Fond coloré", function() return C.ESPChams end, function(v) C.ESPChams = v end)
    makeToggle(esp, co(), "Head Dot", "Point tête", function() return C.ESPHeadDot end, function(v) C.ESPHeadDot = v end)
    makeToggle(esp, co(), "Team Check", "Ignore alliés", function() return C.ESPTeamCheck end, function(v) C.ESPTeamCheck = v end)

    makeSection(esp, co(), "Radar & Crosshair")
    makeToggle(esp, co(), "Radar", "Minimap 2D", function() return C.Radar end, function(v) C.Radar = v end)
    makeToggle(esp, co(), "Crosshair", "Croix custom", function() return C.Crosshair end, function(v) C.Crosshair = v end)
    makeSlider(esp, co(), "Crosshair Size", 4, 20, function() return C.CrosshairSize end, function(v) C.CrosshairSize = v end)
    makeSlider(esp, co(), "Crosshair Gap", 0, 12, function() return C.CrosshairGap end, function(v) C.CrosshairGap = v end)

    makeSection(esp, co(), "Effets")
    makeToggle(esp, co(), "Snow", "Neige dans le menu", function() return C.SnowEnabled end, function(v) C.SnowEnabled = v end)

    -- MOVEMENT
    local movement = addPage("Movement", "Movement")
    o = 0
    makeSection(movement, co(), "Vitesse")
    makeToggle(movement, co(), "Speed Hack", "Vitesse custom", function() return C.SpeedHack end, function(v) C.SpeedHack = v end)
    makeSlider(movement, co(), "Speed Value", 16, 220, function() return C.SpeedValue end, function(v) C.SpeedValue = v end)
    makeToggle(movement, co(), "Speed Boost", "Boost fixe 52", function() return C.SpeedBoost end, function(v) C.SpeedBoost = v; doSetSpeedBoost(v) end)

    makeSection(movement, co(), "Saut & Collision")
    makeToggle(movement, co(), "Infinite Jump", "Saut infini", function() return C.InfJump end, function(v) C.InfJump = v end)
    makeToggle(movement, co(), "No Collision", "Noclip", function() return C.Noclip end, function(v) C.Noclip = v end)
    makeToggle(movement, co(), "Bhop", "Bunny hop", function() return C.Bhop end, function(v) C.Bhop = v end)

    makeSection(movement, co(), "Fly")
    makeToggle(movement, co(), "Fly", "Vol libre WASD + Space/Ctrl", function() return C.Fly end, function(v) setFly(v) end)
    makeSlider(movement, co(), "Fly Speed", 20, 120, function() return C.FlySpeed end, function(v) C.FlySpeed = v end)

    makeSection(movement, co(), "Caméra")
    makeToggle(movement, co(), "FOV Changer", "Champ de vision", function() return C.FOVChanger end, function(v) C.FOVChanger = v end)
    makeSlider(movement, co(), "FOV Value", 30, 160, function() return C.FOVValue end, function(v) C.FOVValue = v end)
    makeToggle(movement, co(), "Third Person", "Vue 3ème personne", function() return C.ThirdPerson end, function(v) C.ThirdPerson = v end)
    makeSlider(movement, co(), "Third Dist", 4, 20, function() return C.ThirdPersonDist end, function(v) C.ThirdPersonDist = v end)

    -- SPECIAL
    local special = addPage("Special", "Special")
    o = 0
    makeSection(special, co(), "Invisibilité (Y)")
    makeToggle(special, co(), "Invisibilité", "Touche Y", function() return C.Invisible end, function(v) C.Invisible = v; doSetInvisibility(v) end)

    makeSection(special, co(), "Select (N)")
    makeToggle(special, co(), "Select", "Sauvegarde alliés 5m", function() return C.SelectActive end, function(v) setSelect(v) end)

    makeSection(special, co(), "Fall Player (B)")
    makeToggle(special, co(), "Fall Player", "Orbital + aim forcé", function() return C.FallPlayer end, function(v) setFallPlayer(v) end)
    makeSlider(special, co(), "Fall Distance", 2, 16, function() return C.FallDistance end, function(v) C.FallDistance = v end)
    makeButton(special, co(), "Reset Fall Player", "Force reset (C)", P.Danger, function() forceResetFallPlayer(); refreshAllToggles() end)

    makeSection(special, co(), "Spin / Anti-Aim")
    makeToggle(special, co(), "Spinbot", "Tourne sur soi", function() return C.Spinbot end, function(v) C.Spinbot = v end)
    makeSlider(special, co(), "Spin Speed", 5, 40, function() return C.SpinSpeed end, function(v) C.SpinSpeed = v end)

    -- OUTFIT
    local outfit = addPage("Outfit", "Outfit")
    o = 0
    makeSection(outfit, co(), "Tenues prédéfinies")
    for _, out in ipairs(OUTFITS) do
        makeButton(outfit, co(), out.name, "Appliquer " .. out.name, P.Accent, function()
            applyOutfitByUserId(out.userId)
            C.CurrentOutfit = out.name
        end)
    end
    makeSection(outfit, co(), "Custom ID")
    local inputBox = new("TextBox", {
        Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = P.BgInput, BackgroundTransparency = 0.08,
        BorderSizePixel = 0, Text = "", PlaceholderText = "ID joueur (ex: 1)",
        TextColor3 = P.Text, PlaceholderColor3 = P.TextFaint, Font = Enum.Font.Gotham, TextSize = 12,
        ClearTextOnFocus = false, LayoutOrder = co(), Parent = outfit,
    })
    corner(inputBox, 9)
    stroke(inputBox, P.BorderSoft, 1, 0.28)
    makeButton(outfit, co(), "Appliquer cet ID", "Charge la tenue", P.Accent2, function() applyCustomOutfit(inputBox.Text) end)
    makeSection(outfit, co(), "Sauvegarde")
    makeButton(outfit, co(), "Sauvegarder", "Tenue actuelle", P.Success, function() saveCurrentOutfit() end)
    makeButton(outfit, co(), "Charger sauvegarde", "Applique la sauvegarde", P.Warn, function() loadSavedOutfit() end)
    makeButton(outfit, co(), "Reset tenue", "Tenue d'origine", P.Danger, function() resetOutfit() end)

    -- MISC
    local misc = addPage("Misc", "Misc")
    o = 0
    makeSection(misc, co(), "Info")
    makeButton(misc, co(), "Destroy Menu", "Supprime le panel", P.Danger, function()
        if S.Gui then S.Gui:Destroy() end
        if RIV.RadarGui then RIV.RadarGui:Destroy() end
        if RIV.FOVCircle then pcall(function() RIV.FOVCircle:Remove() end) end
        for i = 1, 4 do if RIV.Crosshair[i] then pcall(function() RIV.Crosshair[i]:Remove() end) end end
    end)

    main.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(main, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 880, 0, 540),
    }):Play()
end

-- ═══════════════════════════════════════
-- NAVIGATION + KEYBINDS
-- ═══════════════════════════════════════
local function refreshHighlight()
    for i, entry in ipairs(S.NavItems) do
        if entry.card then
            if i == S.SelectedIndex then
                entry.card.BackgroundColor3 = P.BgHover
                entry.card.BackgroundTransparency = 0.04
                local s = entry.card:FindFirstChildOfClass("UIStroke")
                if s then s.Color = P.Accent; s.Transparency = 0.18 end
            else
                entry.card.BackgroundColor3 = P.BgCard
                entry.card.BackgroundTransparency = 0.12
                local s = entry.card:FindFirstChildOfClass("UIStroke")
                if s then s.Color = P.BorderSoft; s.Transparency = 0.28 end
            end
        end
    end
end

local function refreshAllToggles()
    for _, entry in ipairs(S.NavItems) do
        if entry.refresh then pcall(function() entry.refresh() end) end
    end
end

local function getCurrentPageItems()
    local items = {}
    local page = S.Pages[S.CurrentPage]
    if not page then return items end
    for _, entry in ipairs(S.NavItems) do
        if entry.card and entry.card.Parent == page.list then items[#items+1] = entry end
    end
    return items
end

local function navigateUp()
    local items = getCurrentPageItems()
    if #items == 0 then return end
    for i, e in ipairs(items) do
        if e == S.NavItems[S.SelectedIndex] then
            S.SelectedIndex = math.max(1, S.SelectedIndex - 1)
            refreshHighlight()
            return
        end
    end
    S.SelectedIndex = 1
    refreshHighlight()
end

local function navigateDown()
    local items = getCurrentPageItems()
    if #items == 0 then return end
    for i, e in ipairs(items) do
        if e == S.NavItems[S.SelectedIndex] then
            S.SelectedIndex = math.min(#S.NavItems, S.SelectedIndex + 1)
            refreshHighlight()
            return
        end
    end
    S.SelectedIndex = 1
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
    if entry and entry.step then pcall(entry.step, dir) end
end

local function nextPage()
    local idx = 1
    for i, id in ipairs(S.PageOrder) do if id == S.CurrentPage then idx = i; break end end
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
    for i, id in ipairs(S.PageOrder) do if id == S.CurrentPage then idx = i; break end end
    idx = idx - 1
    if idx < 1 then idx = #S.PageOrder end
    S.CurrentPage = S.PageOrder[idx]
    for id, fn in pairs(S.NavButtons) do fn(id == S.CurrentPage) end
    for name, pg in pairs(S.Pages) do pg.frame.Visible = (name == S.CurrentPage) end
    S.SelectedIndex = 1
    refreshHighlight()
end

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
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title = "Infinite Jump", Text = C.InfJump and "ON" or "OFF", Duration = 2})
        end)
        return
    end
    if input.KeyCode == Enum.KeyCode.N then
        setSelect(not C.SelectActive)
        refreshAllToggles()
        return
    end
    if input.KeyCode == Enum.KeyCode.B then
        setFallPlayer(not C.FallPlayer)
        refreshAllToggles()
        return
    end
    if input.KeyCode == Enum.KeyCode.C then
        forceResetFallPlayer()
        refreshAllToggles()
        return
    end
    if input.KeyCode == Enum.KeyCode.RightShift then
        S.Visible = not S.Visible
        if S.Main then
            if S.Visible then
                S.Main.Visible = true
                S.Main.Size = UDim2.new(0, 0, 0, 0)
                TweenService:Create(S.Main, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, 880, 0, 540),
                }):Play()
            else
                local tw = TweenService:Create(S.Main, TweenInfo.new(0.18), {Size = UDim2.new(0, 0, 0, 0)})
                tw:Play()
                tw.Completed:Connect(function() if S.Main then S.Main.Visible = false end end)
            end
        end
        return
    end

    if not S.Visible then return end
    if input.KeyCode == Enum.KeyCode.Up then navigateUp()
    elseif input.KeyCode == Enum.KeyCode.Down then navigateDown()
    elseif input.KeyCode == Enum.KeyCode.Left then stepSelected(-1)
    elseif input.KeyCode == Enum.KeyCode.Right then stepSelected(1)
    elseif input.KeyCode == Enum.KeyCode.Return or input.KeyCode == Enum.KeyCode.KeypadEnter or input.KeyCode == Enum.KeyCode.Space then activateSelected()
    elseif input.KeyCode == Enum.KeyCode.Backspace then
        S.CurrentPage = "Combat"
        for id, fn in pairs(S.NavButtons) do fn(id == "Combat") end
        for name, pg in pairs(S.Pages) do pg.frame.Visible = (name == "Combat") end
        S.SelectedIndex = 1
        refreshHighlight()
    elseif input.KeyCode == Enum.KeyCode.Q then prevPage()
    elseif input.KeyCode == Enum.KeyCode.E then nextPage()
    end
end)

LP.CharacterAdded:Connect(function()
    task.wait(0.5)
    RIV_TARGET = nil
    RIV_SILENT_POS = nil
    RIV_MAGIC_POS = nil
    C.AimbotLockedTarget = nil
    if InvisState.isInvisible then
        InvisState.isInvisible = false
        C.Invisible = false
        if InvisState.invisChair then pcall(function() InvisState.invisChair:Destroy() end); InvisState.invisChair = nil end
        local chair = workspace:FindFirstChild("leola_invis")
        if chair then pcall(function() chair:Destroy() end) end
    end
    if InvisState.isSpeedBoosted then InvisState.isSpeedBoosted = false; C.SpeedBoost = false end
    if FlyState.active then setFly(false); C.Fly = false end
    FallState.lastSide = 0
    FallState.currentSide = 1
    if FallState.active or fallPlayerConn then
        FallState.generation = FallState.generation + 1
        stopFallPlayerLoop()
        C.FallPlayer = false
    end
    scanFireRemotes()
    installFireHook()
end)

Players.PlayerRemoving:Connect(function(plr)
    if FallState.target == plr then FallState.target = nil end
    if SelectState.allies[plr.Name] then SelectState.allies[plr.Name] = nil end
    if SelectState.alliesIds[plr.UserId] then SelectState.alliesIds[plr.UserId] = nil end
    if C.AimbotLockedTarget == plr then C.AimbotLockedTarget = nil; RIV_TARGET = nil end
    removeESP(plr)
end)

pcall(function()
    for _, name in ipairs({"leolabakaka", "ZeyProject", "VRivMenu", "LeolaRadar", "ZeyRadar", "VRivRadar"}) do
        local old = PG:FindFirstChild(name)
        if old then old:Destroy() end
    end
end)

buildRadar()
buildUI()
refreshHighlight()

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "leolabakaka v2",
        Text = "Y invis · I jump · N select · B fall · C reset · RShift menu",
        Duration = 5,
    })
end)
