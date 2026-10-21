local _0x0DC7 = game:GetService("Players")
local _0xDDE4 = game:GetService("RunService")
local _0x4D5E = game:GetService("UserInputService")
local _0x72EF = game:GetService("TweenService")
local _0x5872 = game:GetService("Debris")
local _0xCDE1 = game:GetService("StarterGui")
local _0xE2F5= game:GetService("ReplicatedStorage")
local _0xE3CC = game:GetService("Lighting")
local _0xF726 = game:GetService("SoundService")
local _0x5FAD = game:GetService("VirtualUser")
local _0xAFD5 = game:GetService("HttpService")
local _0x0E64 = game:GetService("TeleportService")
local _0xEC97 = game:GetService("PathfindingService")
local _0xCC79= game:GetService("CollectionService")
local _0xB21B = game:GetService("TextService")
local _0x37AF = game:GetService("GuiService")
local _0xEF16 = _0x4D5E
local _0x3B67 = _0x0DC7.LocalPlayer
local _0x9B21 = _0x3B67:WaitForChild("PlayerGui")
local _0x4A4A = workspace.CurrentCamera
local _0xDE1E ="Unknown"pcall(function() _0xDE1E = identifyexecutor() end)
local _0xF199 = pcall(function() return Drawing.new("Square") end)
local _0xF843 = pcall(function() return getrawmetatable(game) end)
local _0xB52B = pcall(function() return newcclosure end)
local _0x2185 = pcall(function() return setreadonly end)
local _0xD413 = pcall(function() return getnamecallmethod end)
local _0x7A38 = pcall(function() return hookfunction end)
local _0xFB6D = pcall(function() return getupvalue end)
local _0xC269 = pcall(function() return setupvalue end)
local _0xDEBE= pcall(function() return getconstants end)
local _0x8B88= pcall(function() return setconstant end)
local _0xAD43 = pcall(function() return checkcaller end)
local _0x104F = pcall(function() return islclosure end)
local _0x7971 = pcall(function() return hookmetamethod end)
local function _0xC733(cls, props)
local _0xBE38 = Instance.new(cls)
for k, _0x10C0 in pairs(props or {}) do _0xBE38[k] = _0x10C0 end
return _0xBE38
end
local _0x7082 = {
Accent = Color3.fromRGB(0, 229, 255),
Accent2 = Color3.fromRGB(120, 100, 255),
Accent3 = Color3.fromRGB(255, 90, 180),
Success = Color3.fromRGB(80, 240, 160),
Danger = Color3.fromRGB(255, 85, 110),
Warn = Color3.fromRGB(255, 200, 90),
BgDeep = Color3.fromRGB(6, 8, 14),
BgBase = Color3.fromRGB(12, 14, 22),
BgSide = Color3.fromRGB(16, 18, 28),
BgCard = Color3.fromRGB(20, 23, 34),
BgCardHi = Color3.fromRGB(26, 30, 44),
BgInput = Color3.fromRGB(18, 21, 32),
BgHover = Color3.fromRGB(30, 30, 44),
Border = Color3.fromRGB(45, 52, 72),
BorderSoft = Color3.fromRGB(32, 38, 55),
Text = Color3.fromRGB(235, 240, 252),
TextDim = Color3.fromRGB(150, 158, 180),
TextFaint = Color3.fromRGB(95, 102, 125),
EnemyESP = Color3.fromRGB(255, 70, 90),
AllyESP = Color3.fromRGB(70, 230, 140),
NeutralESP = Color3.fromRGB(200, 200, 210),
}
local function _0xC900(p, _0x96A0)
return _0xC733("UICorner", {CornerRadius = UDim.new(0, _0x96A0 or 8), Parent = p})
end
local function _0x7DF4(p, _0x7FB1, _0x61D9, _0x0BD5)
return _0xC733("UIStroke", {
Color = _0x7FB1 or _0x7082.Border,
Thickness = _0x61D9 or 1,
Transparency = _0x0BD5 or 0,
ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
Parent = p,
})
end
local function _0x6611(p, stops, rot)
local _0x33B8 = {}
for _, _0xA777 in ipairs(stops) do
_0x33B8[#_0x33B8 + 1] = ColorSequenceKeypoint.new(_0xA777[1], _0xA777[2])
end
return _0xC733("UIGradient", {
Color = ColorSequence.new(_0x33B8),
Rotation = rot or 90,
Parent = p,
})
endlocal _0x1F65 = {
Gui = nil,
Main = nil,
Pages = {},
CurrentPage ="Combat",
NavButtons = {},
Visible = true,
NavItems = {},
NavOrder = {},
PageOrder = {},
SelectedIndex= 1,
PageIndex = 1,
SnowLayer = nil,
ToastHolder = nil,
StatusBar = nil,
}
local _0x91BA = {Aimbot = true,
AimbotKey = true,
AimbotMaster = true,
AimbotSmooth = 1,
AimbotFOV = 158.1,
AimbotWallCheck = false,AimbotVisCheck = false,
AimbotPrediction = 0.22,
AimbotBone ="Head",
AimbotTeamCheck = true,
AimbotLockFull = true,
AimbotFOVCircle = true,
AimbotLockedTarget= nil,
AimbotStickyRange = 9999,
AimbotTrackSpeed = 1,SilentAim = true,
SilentAimFOV = 900,
SilentAimWallCheck= false,SilentAimVisCheck = false,
SilentAimHitPart ="Head",
SilentAimBone ="Head",MagicBullet = true,
MagicBulletFOV = 1200,
MagicBulletWall = true,MagicBulletMultiAngle = true,
MagicBulletAngleSpoof = true,
MagicBulletVelocityLead = 0.18,
MagicBulletAntiReject = true,
MagicBulletRetryCount = 3,
MagicBulletOcclusion = 2.5,
InstantHit = true,
Wallbang = true,NoRecoil = true,
NoSpread = true,
NoReload = true,
RapidFire = true,
RapidFireMulti= 5,
InfiniteAmmo = true,AutoShoot = true,
AutoShootDelay = 0.05,
TriggerBot = false,
TriggerBotDelay = 0.03,
TriggerBotFOV = 40,
TriggerBotHitChance = 100,
AimAssist = false,
AimAssistStrength = 0.4,
AimAssistFOV = 150,HitboxExpander = true,
HitboxSize = 6,
HitboxTransparency = 0.6,
HitboxMega = true,
HitboxMegaSize = 12,
HitboxMegaInvisible= true,
HitboxMegaMultiPart= true,ESP = true,
ESPBox = true,
ESPName = true,
ESPHealth = true,
ESPDistance = true,
ESPTracer = true,
ESPSkeleton = true,
ESPChams = true,
ESPHeadDot = true,
ESPTeamCheck = true,
ESPEnemyColor = true,ESPAllyColor = true,ESPRainbow = true,
Radar = true,AutoDodge = true,
AutoDodgeRange = 80,
AutoDodgeStrength = 28,
AutoHeal = true,
AutoHealThreshold = 65,
AutoHealCooldown = 0.4,
ForcefieldLocal = true,
ForcefieldRefresh = 0.6,
AdonisBypass = true,
AntiKatana = true,
NoKillcam = true,
NoFlash = true,
NoFog = true,HitSound = true,
HitSoundId ="rbxassetid://9125402735",
HitSoundVol = 0.5,
KillSound = true,
KillSoundId ="rbxassetid://9114653326",
KillSoundVol = 0.6,
HitMarker = true,
DamageIndicator = true,
KillEffect = true,ThirdPerson = false,
ThirdPersonDist = 8,
AutoReload = true,
AutoPickup = true,
AntiAFK = true,
AntiVoid = false,
AntiVoidY = -50,
BunnyHop = false,
BhopPower = 50,
SilentWalk = false,
AutoEquipBest = false,
BestWeaponKeyword ="gun",
FPSUnlocker = true,
FPSLimit = 240,
FOVChanger = false,
FOVValue = 90,
SpeedHack = false,
SpeedValue = 30,
InfJump = true,
Noclip = false,
Invisible = false,
SpeedBoost = false,
FallPlayer = false,
FallDistance = 6,
SelectActive = false,
SnowEnabled = true,
SavedOutfit = nil,
CurrentOutfit ="default",
}
local _0xE7DB = {
ESPObjs = {},
RadarGui = nil,
MegaHitboxes = {},
Hitboxes = {},
CameraHooked = false,
FireCandidates= {},
FireRemote = nil,
RemoteScanned = false,
FOVCircle = nil,
SkeletonCache = {},
ChamsCache = {},
HitSound = nil,
KillSound = nil,
AdonisHooks = {},
AutoHealLast = 0,
ForcefieldObj = nil,
DodgeDir = 0,
DodgeLast = 0,
MagicHits = 0,
LastHealth = {},
OriginalFOV = 70,
}
local _0x38A3 = nil
local _0xD326 = nil
local _0x6B87 = nil
local _0xC7D8 = {
INVIS_POSITION = Vector3.new(-25.95, 84, 3537.55),
BOOSTED_SPEED = 48,
SOUND_ID ="rbxassetid://942127495",
}
local _0x8409 = {
isInvisible = false,
isSpeedBoosted= false,
originalSpeed = 16,
invisChair = nil,
sound = nil,
}
local _0xB76C = {
active = false,
target = nil,
generation = 0,
loopRunning = false,
override = false,
currentSide = 1,
lastSide = 0,
sideTimer = 0,
cachedWeapon= nil,
lastError = 0,
orbitAngle = 0,
}
local _0x59E0 = {
active = false,
allies = {},
alliesIds = {},
scannedAt = 0,
}local function _0x53E3(p)
local _0x7FB1 = (p or _0x3B67).Character
return _0x7FB1 and _0x7FB1:FindFirstChild("HumanoidRootPart")
end
local function _0x4578(p)
local _0x7FB1 = (p or _0x3B67).Character
return _0x7FB1 and _0x7FB1:FindFirstChildOfClass("Humanoid")
end
local function _0xEA11(p)
local _0x7FB1 = (p or _0x3B67).Character
return _0x7FB1 and (_0x7FB1:FindFirstChild("Head") or _0x7FB1:FindFirstChild("head"))
end
local function _0x9E2F(p)
local _0x1BC9 = _0x4578(p)
return _0x1BC9 and _0x1BC9.Health > 0
end
local function _0xBE50(p)
if not p or p == _0x3B67 or not p.Character then return false end
local _0x1BC9 = p.Character:FindFirstChildOfClass("Humanoid")
if not _0x1BC9 or _0x1BC9.Health <= 0 then return false end
return p.Character:FindFirstChild("HumanoidRootPart") ~= nil
end
local function _0xF664(_0x9BF5, _0xC475)
if not (_0x9BF5 and _0xC475) then return false end
if _0x9BF5.Team and _0xC475.Team then return _0x9BF5.Team == _0xC475.Team end
return false
end
local function _0x77CF(_0x61D9)
if not _0x61D9 then return false end
if _0x3B67.Team and _0x61D9.Team and _0x3B67.Team == _0x61D9.Team then return true end
local _0x9BF5 = _0x3B67:GetAttribute("Team") or _0x3B67:GetAttribute("team")
local _0xC475 = _0x61D9:GetAttribute("Team") or _0x61D9:GetAttribute("team")
return _0x9BF5 and _0xC475 and _0x9BF5 == _0xC475
end
local function _0x65BA(p)
if not p then return false end
if p == _0x3B67 then return true end
if _0x59E0.allies[p.Name] then return true end
if _0x59E0.alliesIds[p.UserId] then return true end
return false
end
local function _0x3271(p, bone)
local _0x7FB1 = p and p.Character
if not _0x7FB1 then return nil end
bone = bone or"Head"local _0xC475 = _0x7FB1:FindFirstChild(bone)
if _0xC475 and _0xC475:IsA("BasePart") then return _0xC475 end
local _0x8C93 = {
Head = {"Head","head"},
Torso = {"Torso","UpperTorso","Chest"},
HumanoidRootPart = {"HumanoidRootPart","RootPart"},
}
for _, _0xBD64 in ipairs(_0x8C93[bone] or {bone}) do
local _0x82BB = _0x7FB1:FindFirstChild(_0xBD64)
if _0x82BB and _0x82BB:IsA("BasePart") then return _0x82BB end
end
return _0x53E3(p)
endlocal function _0x166C(target, wall)
if not wall then return true end
if _0x91BA.MagicBulletWall or _0x91BA.Wallbang then return true end
local _0x9BF5, _0xC475 = _0x53E3(_0x3B67), _0x53E3(target)
if not (_0x9BF5 and _0xC475) then return false end
local _0x6BE4 = RaycastParams.new()
_0x6BE4.FilterType = Enum.RaycastFilterType.Exclude
_0x6BE4.FilterDescendantsInstances = {_0x3B67.Character, target.Character}
return workspace:Raycast(_0x9BF5.Position, _0xC475.Position - _0x9BF5.Position, _0x6BE4) == nil
end
local function _0xE6BB(pos)
local _0x4BC5, _0x5594 = _0x4A4A:WorldToViewportPoint(pos)
if not _0x5594 then return nil end
return Vector2.new(_0x4BC5.X, _0x4BC5.Y), _0x4BC5.Z
end
local function _0x6EA0(title, text, color)
if not _0x1F65.ToastHolder then return end
color = color or _0x7082.Accent
local _0x5537 = _0xC733("Frame", {
Size = UDim2.new(0, 280, 0, 50),
BackgroundColor3 = _0x7082.BgCard,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
LayoutOrder = 0,
Parent = _0x1F65.ToastHolder,
})
_0xC900(_0x5537, 10)
_0x7DF4(_0x5537, color, 1.2, 0.3)
_0xC733("TextLabel", {
Size = UDim2.new(1, -20, 0, 18),
Position = UDim2.new(0, 14, 0, 6),
BackgroundTransparency = 1,
Text = title,
TextColor3 = _0x7082.Text,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = _0x5537,
})
_0xC733("TextLabel", {
Size = UDim2.new(1, -20, 0, 20),
Position = UDim2.new(0, 14, 0, 24),
BackgroundTransparency = 1,
Text = text,
TextColor3 = _0x7082.TextDim,
Font = Enum.Font.Gotham,
TextSize = 11,
TextXAlignment = Enum.TextXAlignment.Left,
TextWrapped = true,
Parent = _0x5537,
})
_0x5537.Position = UDim2.new(1, 320, 0, 0)
_0x72EF:Create(_0x5537, TweenInfo.new(0.35, Enum.EasingStyle.Back), {
Position = UDim2.new(1, -300, 0, 0),
}):Play()
task.delay(3, function()
if _0x5537 and _0x5537.Parent then
local _0x1C10 = _0x72EF:Create(_0x5537, TweenInfo.new(0.3), {
Position = UDim2.new(1, 320, 0, 0),
BackgroundTransparency = 1,
})
_0x1C10:Play()
_0x1C10.Completed:Connect(function() _0x5537:Destroy() end)
end
end)
endlocal _0x08C4 = {"fire","shoot","hit","damage","attack","bullet","spell","cast","gun","weapon","projectile","ray","beam","shot","hitmarker","fireweapon","weaponfire","gunfire","firegun",
}
local _0xBA60 = {"Fire","Shoot","FireWeapon","WeaponFire","GunFire","FireGun","Attack","Hit","Damage","Bullet","FireServer","ShootServer","RemoteFire","Weapon",
}
local function _0x3544(_0x96A0)
local _0xA777 = 0
local _0xBD64 = _0x96A0.Name:lower()
for _, k in ipairs(_0x08C4) do
if _0xBD64:find(k, 1, true) then _0xA777 = _0xA777 + 10 end
end
if _0x96A0:IsA("RemoteEvent") then _0xA777 = _0xA777 + 5 end
if _0x96A0:IsA("RemoteFunction") then _0xA777 = _0xA777 + 3 end
return _0xA777
end
local function _0xEA9F()
_0xE7DB.FireCandidates = {}
_0xE7DB.RemoteScanned = true
local function _0xDEF4(p, _0xE41C)
if _0xE41C > 5 then return end
for _, _0x7FB1 in ipairs(p:GetChildren()) do
if _0x7FB1:IsA("RemoteEvent") or _0x7FB1:IsA("RemoteFunction") then
local _0xA777 = _0x3544(_0x7FB1)
if _0xA777 > 0 then
table.insert(_0xE7DB.FireCandidates, {remote = _0x7FB1, score = _0xA777})
end
local _0xBD64 = _0x7FB1.Name:lower()
for _, key in ipairs(_0xBA60) do
if _0xBD64:find(key:lower()) then
if not _0xE7DB.FireRemote then _0xE7DB.FireRemote = _0x7FB1 end
break
end
end
end
pcall(_0xDEF4, _0x7FB1, _0xE41C + 1)
end
end
pcall(_0xDEF4, _0xE2F5, 0)
pcall(_0xDEF4, workspace, 0)
pcall(_0xDEF4, _0x3B67, 0)
table.sort(_0xE7DB.FireCandidates, function(_0x9BF5, _0xC475) return _0x9BF5.score > _0xC475.score end)
if #_0xE7DB.FireCandidates > 0 and not _0xE7DB.FireRemote then
_0xE7DB.FireRemote = _0xE7DB.FireCandidates[1].remote
end
end
local function _0xA722(target)
if not target or not target.Character then return {} end
local _0x0D3B = target.Character
local _0x3E23 = {}
for _, _0xBD64 in ipairs({"Head","UpperTorso","Torso","HumanoidRootPart","LowerTorso"}) do
local _0x82BB = _0x0D3B:FindFirstChild(_0xBD64)
if _0x82BB and _0x82BB:IsA("BasePart") then table.insert(_0x3E23, _0x82BB) end
end
return _0x3E23
end
local function _0x1AC0(_0xB4A2, _0xA98A, _0x237D)
_0x237D = _0x237D or _0x91BA.MagicBulletOcclusion or 2.5
return _0xB4A2 + (_0xA98A - _0xB4A2).Unit * _0x237D
end
local function _0xEC79(target, basePos)
if not target or not target.Character then return basePos end
local _0xB7CA = target.Character:FindFirstChild("HumanoidRootPart")
if not _0xB7CA then return basePos end
return basePos + _0xB7CA.AssemblyLinearVelocity * (_0x91BA.MagicBulletVelocityLead or 0.18)
end
local function _0x9C73(_0xA4DE, target)
if not target then return _0xA4DE end
local _0x5C20 = _0xA722(target)
if #_0x5C20 == 0 then return _0xA4DE end
local _0x9FFB = _0x4D5E:GetMouseLocation()
local _0x6E95, _0xADE9 = nil, math.huge
for _, _0x7FB1 in ipairs(_0x5C20) do
local _0x4BC5, _0x5594 = _0x4A4A:WorldToViewportPoint(_0x7FB1.Position)
if _0x5594 then
local _0xE41C = (Vector2.new(_0x4BC5.X, _0x4BC5.Y) - _0x9FFB).Magnitude
if _0xE41C < _0xADE9 then _0x6E95, _0xADE9 = _0x7FB1, _0xE41C end
end
end
_0x6E95 = _0x6E95 or _0x5C20[1]
local _0xA98A = _0xEC79(target, _0x6E95.Position)
local _0xDD11, _0x5122
for _0xBE38, _0x9BF5 in ipairs(_0xA4DE) do
if typeof(_0x9BF5) =="Vector3"then
if _0xDD11 == nil then _0xDD11 = _0xBE38
elseif _0x5122 == nil then _0x5122 = _0xBE38; break end
end
end
if not _0xDD11 then return _0xA4DE end
local _0xB4A2 = _0xA4DE[_0xDD11]if _0x91BA.MagicBulletWall or _0x91BA.Wallbang then
_0xA4DE[_0xDD11] = _0xA98A - Vector3.new(0, 1.5, 0)
if _0x5122 then
_0xA4DE[_0x5122] = Vector3.new(0, 1, 0) * 5000
elseif _0xA4DE[_0xDD11 + 1] and typeof(_0xA4DE[_0xDD11 + 1]) =="Vector3"then
_0xA4DE[_0xDD11 + 1] = Vector3.new(0, 0, 0.01)
end
else
if _0x91BA.MagicBulletAngleSpoof and _0x91BA.MagicBulletOcclusion > 0 then
_0xB4A2 = _0x1AC0(_0xB4A2, _0xA98A, _0x91BA.MagicBulletOcclusion)
_0xA4DE[_0xDD11] = _0xB4A2
end
if _0x5122 and typeof(_0xA4DE[_0x5122]) =="Vector3"then
local _0xB618 = _0xA4DE[_0x5122].Magnitude
if _0xB618 < 1 then _0xB618 = 5000 end
_0xA4DE[_0x5122] = (_0xA98A - _0xB4A2).Unit * _0xB618
elseif _0xA4DE[_0xDD11 + 1] and typeof(_0xA4DE[_0xDD11 + 1]) =="Vector3"then
_0xA4DE[_0xDD11 + 1] = (_0xA98A - _0xB4A2).Unit * 5000
else
_0xA4DE[_0xDD11] = _0xA98A
end
end
return _0xA4DE
end
local function _0x9A67()
if not (_0xF843 and _0x2185 and _0xB52B and _0xD413) then return end
if #_0xE7DB.FireCandidates == 0 then _0xEA9F() end
local _0x466C, _0xA4FF = pcall(getrawmetatable, game)
if not _0x466C or not _0xA4FF then return end
local _0xB1BC = _0xA4FF.__namecall
if not _0xB1BC then return end
pcall(setreadonly, _0xA4FF, false)
_0xA4FF.__namecall = newcclosure(function(self, ...)
local _0xB618 = getnamecallmethod()
if _0xB618 =="FireServer"or _0xB618 =="InvokeServer"then
for _, _0x597E in ipairs(_0xE7DB.FireCandidates) do
if _0x597E.remote == self then
local _0xA4DE = {...}
if _0x91BA.MagicBullet and _0x6B87 and _0x38A3 then
_0xA4DE = _0x9C73(_0xA4DE, _0x38A3)
_0xE7DB.MagicHits = _0xE7DB.MagicHits + 1
if _0x91BA.MagicBulletAntiReject then
task.spawn(function()
for _0xBE38 = 1, _0x91BA.MagicBulletRetryCount do
task.wait(0.02)
pcall(function() _0xB1BC(self, unpack(_0xA4DE)) end)
end
end)
end
elseif (_0x91BA.SilentAim and _0xD326) or (_0x91BA.MagicBullet and _0x6B87) then
local _0xB41B = _0x6B87 or _0xD326
local _0x8386, _0x54A6
for _0xBE38, _0x9BF5 in ipairs(_0xA4DE) do
if typeof(_0x9BF5) =="Vector3"then
if _0x8386 == nil then _0x8386 = _0xBE38
elseif _0x54A6 == nil then _0x54A6 = _0xBE38; break end
end
end
if _0x8386 and _0x54A6 and _0xB41B then
if _0x91BA.MagicBulletWall or _0x91BA.Wallbang then
_0xA4DE[_0x8386] = _0xB41B - Vector3.new(0, 2, 0)
_0xA4DE[_0x54A6] = Vector3.new(0, 1, 0)
else
local _0xB4A2 = _0xA4DE[_0x8386]
local _0x6CE6 = _0xA4DE[_0x54A6].Magnitude
if _0x6CE6 < 1 then _0x6CE6 = 1000 end
_0xA4DE[_0x54A6] = (_0xB41B - _0xB4A2).Unit * _0x6CE6
end
elseif _0x8386 and _0xB41B then
_0xA4DE[_0x8386] = _0xB41B
if _0xA4DE[_0x8386 + 1] and typeof(_0xA4DE[_0x8386 + 1]) =="Vector3"then
_0xA4DE[_0x8386 + 1] = Vector3.new(0, 0, 0.01)
end
end
end
return _0xB1BC(self, unpack(_0xA4DE))
end
endif _0xE7DB.FireRemote and self == _0xE7DB.FireRemote then
local _0xA4DE = {...}
local _0x4324 = _0x91BA.MagicBullet and _0x6B87
local _0x3AD3 = _0x91BA.SilentAim and _0xD326
local _0xB41B = _0x4324 and _0x6B87 or (_0x3AD3 and _0xD326)
if _0xB41B then
local _0x8386, _0x54A6
for _0xBE38, _0x9BF5 in ipairs(_0xA4DE) do
if typeof(_0x9BF5) =="Vector3"then
if _0x8386 == nil then _0x8386 = _0xBE38
elseif _0x54A6 == nil then _0x54A6 = _0xBE38; break end
end
end
if _0x8386 and _0x54A6 then
if _0x91BA.MagicBulletWall or _0x91BA.Wallbang then
_0xA4DE[_0x8386] = _0xB41B - Vector3.new(0, 2, 0)
_0xA4DE[_0x54A6] = Vector3.new(0, 1, 0)
else
local _0xB4A2 = _0xA4DE[_0x8386]
local _0x6CE6 = _0xA4DE[_0x54A6].Magnitude
if _0x6CE6 < 1 then _0x6CE6 = 1000 end
_0xA4DE[_0x54A6] = (_0xB41B - _0xB4A2).Unit * _0x6CE6
end
elseif _0x8386 then
_0xA4DE[_0x8386] = _0xB41B
end
return _0xB1BC(self, unpack(_0xA4DE))
end
end
end
return _0xB1BC(self, ...)
end)
pcall(setreadonly, _0xA4FF, true)
end
local function _0x6841()
if _0xE7DB.CameraHooked then return end
_0xE7DB.CameraHooked = true
if not (_0xF843 and _0x2185 and _0xB52B) then return end
local _0x466C, _0xA4FF = pcall(getrawmetatable, _0x4A4A)
if not _0x466C or not _0xA4FF then return end
local _0xB1BC = _0xA4FF.__index
if not _0xB1BC then return end
pcall(setreadonly, _0xA4FF, false)
_0xA4FF.__index = newcclosure(function(self, k)
local _0x10C0 = _0xB1BC(self, k)
if k =="CFrame"then
if _0xB76C.active and _0xB76C.target and _0xB76C.override then
local _0x1BC9 = _0x3271(_0xB76C.target,"Head")
if _0x1BC9 then return CFrame.new(_0x10C0.Position, _0x1BC9.Position) end
end
if _0x91BA.Aimbot and _0x91BA.AimbotMaster and _0x91BA.AimbotLockedTarget
and _0x4D5E:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
local _0x1BC9 = _0x3271(_0x91BA.AimbotLockedTarget, _0x91BA.AimbotBone)
if _0x1BC9 then
local _0xA98A = _0x1BC9.Position
if _0x91BA.AimbotPrediction > 0 then
local _0xB7CA = _0x53E3(_0x91BA.AimbotLockedTarget)
if _0xB7CA then _0xA98A = _0xA98A + _0xB7CA.AssemblyLinearVelocity * _0x91BA.AimbotPrediction end
end
return CFrame.new(_0x10C0.Position, _0xA98A)
end
end
end
return _0x10C0
end)
pcall(setreadonly, _0xA4FF, true)
endlocal function _0x5EF4()
local _0x9FFB = _0x4D5E:GetMouseLocation()
local _0x6E95, _0xC089 = nil, _0x91BA.AimbotFOV
for _, p in ipairs(_0x0DC7:GetPlayers()) do
if _0xBE50(p) and not _0x77CF(p) and not _0xF664(_0x3B67, p) and not _0x65BA(p) then
local _0x42C5 = _0x3271(p, _0x91BA.AimbotBone)
if _0x42C5 then
local _0x4BC5, _0x5594 = _0x4A4A:WorldToViewportPoint(_0x42C5.Position)
if _0x5594 then
local _0xE41C = (Vector2.new(_0x4BC5.X, _0x4BC5.Y) - _0x9FFB).Magnitude
if _0xE41C < _0xC089 thenif not _0x91BA.AimbotWallCheck or _0x166C(p, true) then
_0x6E95, _0xC089 = p, _0xE41C
end
end
end
end
end
end
return _0x6E95
end
local function _0xAD98(maxFOV, wc, bone)
if _0x91BA.AimbotLockedTarget and _0xBE50(_0x91BA.AimbotLockedTarget) and not _0x65BA(_0x91BA.AimbotLockedTarget) then
return _0x91BA.AimbotLockedTarget, 0
end
maxFOV = maxFOV or math.huge
local _0x9FFB = _0x4D5E:GetMouseLocation()
local _0x6E95, _0xC089 = nil, maxFOV
for _, p in ipairs(_0x0DC7:GetPlayers()) do
if _0xBE50(p) and not _0x77CF(p) and not _0xF664(_0x3B67, p) and not _0x65BA(p) then
local _0x42C5 = _0x3271(p, bone)
if _0x42C5 then
local _0x4BC5, _0x5594 = _0x4A4A:WorldToViewportPoint(_0x42C5.Position)
if _0x5594 then
local _0xE41C = (Vector2.new(_0x4BC5.X, _0x4BC5.Y) - _0x9FFB).Magnitude
if _0xE41C < _0xC089 then
if wc and not _0x166C(p, true) thenelse
_0x6E95, _0xC089 = p, _0xE41C
end
end
end
end
end
end
return _0x6E95, _0xC089
end
local function _0x8C64(maxFOV, wallCheck, visCheck, bone)
if _0xB76C.active and _0xB76C.target and _0xB76C.override then
local _0x61D9 = _0xB76C.target
if _0xBE50(_0x61D9) and not _0x65BA(_0x61D9) then return _0x61D9, 0 end
return nil, math.huge
end
if _0x91BA.AimbotLockedTarget and _0xBE50(_0x91BA.AimbotLockedTarget) and not _0x65BA(_0x91BA.AimbotLockedTarget) then
return _0x91BA.AimbotLockedTarget, 0
end
maxFOV = maxFOV or math.huge
local _0x9FFB = _0x4D5E:GetMouseLocation()
local _0x6E95, _0x6885 = nil, maxFOV
for _, p in ipairs(_0x0DC7:GetPlayers()) do
if _0xBE50(p) and not _0x77CF(p) and not _0xF664(_0x3B67, p) and not _0x65BA(p) then
local _0x42C5 = _0x3271(p, bone)
if _0x42C5 then
local _0x4BC5 = _0xE6BB(_0x42C5.Position)
if _0x4BC5 then
local _0xE41C = (_0x4BC5 - _0x9FFB).Magnitude
if _0xE41C < _0x6885 then
if wallCheck and not _0x166C(p, true) then continue end
if visCheck and not _0x166C(p, true) then continue end
_0x6E95, _0x6885 = p, _0xE41C
end
end
end
end
end
return _0x6E95, _0x6885
end
local function _0x7900()
if _0xB76C.active and _0xB76C.target and _0xB76C.override then
local _0xCECB = _0xB76C.target
if _0xBE50(_0xCECB) and not _0x65BA(_0xCECB) then
local _0x1BC9 = _0x3271(_0xCECB,"Head") or _0x53E3(_0xCECB)
if _0x1BC9 then
local _0xA98A = _0x1BC9.Position
if _0x91BA.AimbotPrediction > 0 then
local _0xB7CA = _0x53E3(_0xCECB)
if _0xB7CA then _0xA98A = _0xA98A + _0xB7CA.AssemblyLinearVelocity * _0x91BA.AimbotPrediction end
end
_0x4A4A.CFrame = _0x4A4A.CFrame:Lerp(CFrame.new(_0x4A4A.CFrame.Position, _0xA98A), 1)
_0x91BA.AimbotLockedTarget = _0xCECB
_0x38A3 = _0xCECB
return
end
end
return
end
if not _0x91BA.AimbotMaster then
_0x38A3 = nil
_0x91BA.AimbotLockedTarget = nil
return
end
if not _0x91BA.Aimbot then
_0x91BA.AimbotLockedTarget = nil
return
end
if _0x91BA.AimbotKey and not _0x4D5E:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
_0x38A3 = nil
_0x91BA.AimbotLockedTarget = nil
return
end
if _0x91BA.AimbotLockedTarget and (not _0xBE50(_0x91BA.AimbotLockedTarget) or _0x65BA(_0x91BA.AimbotLockedTarget)) then
_0x91BA.AimbotLockedTarget = nil
end
if not _0x91BA.AimbotLockedTarget or not _0xBE50(_0x91BA.AimbotLockedTarget) then
local _0x61D9 = _0x5EF4()
if not _0x61D9 then _0x38A3 = nil; return end
if _0x77CF(_0x61D9) or _0xF664(_0x3B67, _0x61D9) or _0x65BA(_0x61D9) then _0x38A3 = nil; return end
_0x91BA.AimbotLockedTarget = _0x61D9
end
local _0xCECB = _0x91BA.AimbotLockedTarget
if not _0xCECB or not _0xBE50(_0xCECB) or _0x65BA(_0xCECB) then
_0x91BA.AimbotLockedTarget = nil
_0x38A3 = nil
return
end
_0x38A3 = _0xCECB
local _0x1BC9 = _0x3271(_0xCECB, _0x91BA.AimbotBone) or _0x53E3(_0xCECB)
if not _0x1BC9 then
_0x91BA.AimbotLockedTarget = nil
_0x38A3 = nil
return
end
local _0x9838 = CFrame.new(_0x4A4A.CFrame.Position, _0xEC79(_0xCECB, _0x1BC9.Position))
if _0x91BA.AimbotLockFull then
_0x4A4A.CFrame = _0x9838
else
_0x4A4A.CFrame = _0x4A4A.CFrame:Lerp(_0x9838, math.clamp(_0x91BA.AimbotSmooth, 0.01, 1))
end
end
pcall(function()
_0xDDE4:UnbindFromRenderStep("LEOLABAKAKA_Aimbot")
_0xDDE4:BindToRenderStep("LEOLABAKAKA_Aimbot", Enum.RenderPriority.Camera.Value + 1, _0x7900)
end)local function _0x53D0()
if not _0x8409.sound then
_0x8409.sound = _0xC733("Sound", {
SoundId = _0xC7D8.SOUND_ID,
Volume = 0.5,
Parent = _0x9B21,
})
end
pcall(function() _0x8409.sound:Play() end)
end
local function _0xAC3F(_0x0D3B, _0x61D9)
for _, _0xE41C in ipairs(_0x0D3B:GetDescendants()) do
if _0xE41C:IsA("BasePart") or _0xE41C:IsA("Decal") then
pcall(function() _0xE41C.Transparency = _0x61D9 end)
end
end
end
local function _0xA0E7(state)
if not _0x3B67.Character or state == _0x8409.isInvisible then return end
_0x8409.isInvisible = state
_0x53D0()
if state then
local _0xB7CA = _0x3B67.Character:FindFirstChild("HumanoidRootPart")
if not _0xB7CA then return end
local _0xB8B9 = _0xB7CA.CFrame
_0x3B67.Character:MoveTo(_0xC7D8.INVIS_POSITION)
task.wait(0.15)
local _0xB410 = _0xC733("Seat", {
Name ="invischair",
Anchored = false,
CanCollide = false,
Transparency = 1,
Position = _0xC7D8.INVIS_POSITION,
Parent = workspace,
})
local _0xEB5F = _0x3B67.Character:FindFirstChild("Torso") or _0x3B67.Character:FindFirstChild("UpperTorso")
if _0xEB5F then
_0xC733("Weld", {Part0 = _0xB410, Part1 = _0xEB5F, Parent = _0xB410})
end
task.wait()
_0xB410.CFrame = _0xB8B9
_0x8409.invisChair = _0xB410
_0xAC3F(_0x3B67.Character, 0.5)
_0x6EA0("Invisibilité","ON", _0x7082.Success)
else
if _0x8409.invisChair then pcall(function() _0x8409.invisChair:Destroy() end) end
_0x8409.invisChair = nil
local _0x7FB1 = workspace:FindFirstChild("invischair")
if _0x7FB1 then pcall(function() _0x7FB1:Destroy() end) end
if _0x3B67.Character then _0xAC3F(_0x3B67.Character, 0) end
_0x6EA0("Invisibilité","OFF", _0x7082.Warn)
end
end
local function _0x6698(state)
local _0x1BC9 = _0x4578(_0x3B67)
if not _0x1BC9 then return end
if state and not _0x8409.isSpeedBoosted then
_0x8409.originalSpeed = _0x1BC9.WalkSpeed
_0x1BC9.WalkSpeed = _0xC7D8.BOOSTED_SPEED
_0x8409.isSpeedBoosted = true
_0x53D0()
_0x6EA0("Speed Boost","ON · ".. _0xC7D8.BOOSTED_SPEED, _0x7082.Success)
elseif not state and _0x8409.isSpeedBoosted then
_0x1BC9.WalkSpeed = _0x8409.originalSpeed
_0x8409.isSpeedBoosted = false
_0x53D0()
_0x6EA0("Speed Boost","OFF", _0x7082.Warn)
end
end
local function _0x46C6()
_0x59E0.allies = {}
_0x59E0.alliesIds = {}
local _0xEDA5 = _0x53E3(_0x3B67)
if not _0xEDA5 then return end
for _, p in ipairs(_0x0DC7:GetPlayers()) do
if p ~= _0x3B67 then
local _0x1BC9 = _0x53E3(p)
if _0x1BC9 and (_0x1BC9.Position - _0xEDA5.Position).Magnitude <= 5 then
_0x59E0.allies[p.Name] = true
_0x59E0.alliesIds[p.UserId] = true
end
end
end
_0x59E0.scannedAt = tick()
end
local function _0x8DC5(state)
if state == _0x59E0.active then return end
_0x91BA.SelectActive = state
if state then
_0x59E0.active = true
_0x46C6()
if not (_0xB76C.active and _0xB76C.override) then
_0x38A3 = nil
_0x91BA.AimbotLockedTarget = nil
end
local _0xBD64 = 0
for _ in pairs(_0x59E0.allies) do _0xBD64 = _0xBD64 + 1 end
_0x6EA0("Select ON", _0xBD64 .." allié(s)", _0x7082.Success)
else
_0x59E0.active = false
_0x59E0.allies = {}
_0x59E0.alliesIds = {}
if not (_0xB76C.active and _0xB76C.override) then
_0x38A3 = nil
_0x91BA.AimbotLockedTarget = nil
end
_0x6EA0("Select OFF","Reset", _0x7082.Warn)
end
end
local function _0xB9CF(p)
if not p or not p.Parent or not p.Character then return false end
local _0x1BC9 = p.Character:FindFirstChildOfClass("Humanoid")
if not _0x1BC9 or _0x1BC9.Health <= 0 then return false end
return p.Character:FindFirstChild("HumanoidRootPart") ~= nil
end
local function _0x75CA()
local _0x0D3B = _0x3B67.Character
if not _0x0D3B then return end
local _0x61D9 = _0x0D3B:FindFirstChildOfClass("Tool")
if _0x61D9 then
_0xB76C.cachedWeapon = _0x61D9
return _0x61D9
end
local _0x1BC9 = _0x0D3B:FindFirstChildOfClass("Humanoid")
local _0xC673 = _0x3B67:FindFirstChild("Backpack")
if _0xC673 then
for _, _0x82BB in ipairs(_0xC673:GetChildren()) do
if _0x82BB:IsA("Tool") then
pcall(function() _0x1BC9:EquipTool(_0x82BB) end)
_0xB76C.cachedWeapon = _0x82BB
return _0x82BB
end
end
end
end
local function _0xAD0E()
local _0xEDA5 = _0x53E3(_0x3B67)
if not _0xEDA5 then return nil end
local _0x6E95, _0xADE9 = nil, math.huge
for _, p in ipairs(_0x0DC7:GetPlayers()) do
if p ~= _0x3B67 and not _0x65BA(p) and _0xB9CF(p) then
local _0x1BC9 = _0x53E3(p)
if _0x1BC9 then
local _0xE41C = (_0x1BC9.Position - _0xEDA5.Position).Magnitude
if _0xE41C < _0xADE9 then _0x6E95, _0xADE9 = p, _0xE41C end
end
end
end
return _0x6E95
end
local function _0x4E0F()
local _0xA777 = math.random(1, 3)
local _0x9BF5 = 0
while _0xA777 == _0xB76C.lastSide and _0x9BF5 < 5 do
_0xA777 = math.random(1, 3)
_0x9BF5 = _0x9BF5 + 1
end
_0xB76C.lastSide = _0xA777
return _0xA777
end
local function _0xC10F(_0x06ED, _0xE62A, _0x0987)
local _0x96A0 = _0x0987.CFrame.RightVector
local _0xCECB = _0x0987.CFrame.LookVector
if _0x06ED == 1 then return _0x96A0 * -_0xE62A
elseif _0x06ED == 2 then return _0x96A0 * _0xE62A
else return _0xCECB * -_0xE62A end
end
local _0x2868
local function _0x2577()
if _0x2868 then pcall(function() _0x2868:Disconnect() end); _0x2868 = nil end
_0xB76C.loopRunning = false
_0xB76C.override = false
_0xB76C.active = false
_0xB76C.target = nil
_0x91BA.AimbotLockedTarget = nil
_0x38A3 = nil
end
local function _0xBABF()
if _0x2868 then pcall(function() _0x2868:Disconnect() end) end
_0xB76C.generation = _0xB76C.generation + 1
local _0x8807 = _0xB76C.generation
_0xB76C.loopRunning = true
_0xB76C.active = true
_0x2868 = _0xDDE4.RenderStepped:Connect(function(dt)
if _0xB76C.generation ~= _0x8807 then _0x2577(); return end
if not _0x91BA.FallPlayer or not _0xB76C.active then _0x2577(); return end
pcall(function()
local _0xEDA5 = _0x53E3(_0x3B67)
if not _0xEDA5 then _0xB76C.override = false; return end
if _0xB76C.target and (not _0xB76C.target.Parent or not _0xB9CF(_0xB76C.target) or _0x65BA(_0xB76C.target)) then
_0xB76C.target = nil
_0xB76C.override = false
end
if not _0xB76C.target then
_0xB76C.target = _0xAD0E()
_0xB76C.currentSide = _0x4E0F()
_0xB76C.sideTimer = 0
end
local _0x61D9 = _0xB76C.target
if not _0x61D9 or not _0x61D9.Parent then _0xB76C.override = false; return end
local _0x0987 = _0x53E3(_0x61D9)
local _0x98A0 = _0x3271(_0x61D9,"Head")
if not _0x0987 then _0xB76C.target = nil; _0xB76C.override = false; return end
_0x75CA()
_0xB76C.override = true
_0xB76C.sideTimer = _0xB76C.sideTimer + dt
if _0xB76C.sideTimer >= 0.08 then
_0xB76C.currentSide = _0x4E0F()
_0xB76C.sideTimer = 0
end
local _0xE41C = _0x91BA.FallDistance or 6
local _0x237D = _0xC10F(_0xB76C.currentSide, _0xE41C, _0x0987)
local _0x34DC = _0x98A0 or _0x0987
local _0x06F8 = _0x0987.Position + _0x0987.AssemblyLinearVelocity * 0.04
local _0xA98A = _0x06F8 + _0x237D
_0xA98A = Vector3.new(_0xA98A.X, _0x0987.Position.Y + 1, _0xA98A.Z)
pcall(function() _0xEDA5.CFrame = CFrame.new(_0xA98A, _0x34DC.Position) end)
if _0x4A4A then pcall(function() _0x4A4A.CFrame = CFrame.new(_0x4A4A.CFrame.Position, _0x34DC.Position) end) end
_0x91BA.AimbotLockedTarget = _0x61D9
_0x38A3 = _0x61D9
end)
end)
end
local function _0xFBC8()
_0xB76C.generation = _0xB76C.generation + 1
_0xB76C.lastSide = 0
_0xB76C.currentSide = 1
_0xB76C.sideTimer = 0
_0x2577()
_0x91BA.FallPlayer = false
_0x91BA.AimbotLockedTarget = nil
_0x38A3 = nil
_0x6EA0("Fall Player","RESET", _0x7082.Warn)
end
local function _0xD45F(state)
state = state and true or false
if state == _0x91BA.FallPlayer and state == _0xB76C.active then return end
_0x91BA.FallPlayer = state
if state then
_0xB76C.generation = _0xB76C.generation + 1
_0xB76C.active = true
_0xB76C.target = nil
_0xB76C.loopRunning = false
_0xB76C.override = false
_0xB76C.lastSide = 0
_0xB76C.currentSide = _0x4E0F()
_0xB76C.sideTimer = 0
_0xBABF()
_0x6EA0("Fall Player","ACTIVÉ", _0x7082.Success)
else
_0xB76C.generation = _0xB76C.generation + 1
_0x2577()
_0x6EA0("Fall Player","DÉSACTIVÉ", _0x7082.Warn)
end
end
_0xEA9F()
_0x9A67()
_0x6841()if _0xF199 then
_0xE7DB.FOVCircle = Drawing.new("Circle")
_0xE7DB.FOVCircle.Thickness = 1.5
_0xE7DB.FOVCircle.Color = _0x7082.Accent
_0xE7DB.FOVCircle.Filled = false
_0xE7DB.FOVCircle.NumSides = 60
_0xE7DB.FOVCircle.Radius = _0x91BA.AimbotFOV
_0xE7DB.FOVCircle.Visible = false
_0xDDE4.RenderStepped:Connect(function()
if not _0xE7DB.FOVCircle then return end
local _0x99F0 = false
if not (_0xB76C.active and _0xB76C.override) then
if _0x91BA.Aimbot and _0x91BA.AimbotMaster and _0x91BA.AimbotFOVCircle then _0x99F0 = true end
end
if _0x99F0 then
_0xE7DB.FOVCircle.Visible = true
_0xE7DB.FOVCircle.Position = Vector2.new(_0x4A4A.ViewportSize.X / 2, _0x4A4A.ViewportSize.Y / 2)
_0xE7DB.FOVCircle.Radius = _0x91BA.AimbotFOV
_0xE7DB.FOVCircle.Color = _0x7082.Accent
else
_0xE7DB.FOVCircle.Visible = false
end
end)
endtask.spawn(function()
while true do
task.wait(_0x91BA.AutoShootDelay)
if not _0x91BA.AutoShoot or not _0x91BA.AimbotMaster then continue end
local _0x61D9 = _0xAD98(_0x91BA.AimbotFOV, _0x91BA.AimbotWallCheck, _0x91BA.AimbotBone)
if not _0x61D9 then continue end
local _0x4C7D = _0x3B67.Character and _0x3B67.Character:FindFirstChildOfClass("Tool")
if _0x4C7D then pcall(function() _0x4C7D:Activate() end) end
end
end)
task.spawn(function()
while true do
task.wait(_0x91BA.TriggerBotDelay)
if not _0x91BA.TriggerBot then continue end
if math.random(100) > _0x91BA.TriggerBotHitChance then continue end
local _0x61D9 = _0xAD98(_0x91BA.TriggerBotFOV, false,"Head")
if not _0x61D9 then continue end
local _0x4C7D = _0x3B67.Character and _0x3B67.Character:FindFirstChildOfClass("Tool")
if _0x4C7D then pcall(function() _0x4C7D:Activate() end) end
end
end)
_0xDDE4.RenderStepped:Connect(function()
if not _0x91BA.AimAssist then return end
local _0x61D9 = _0xAD98(_0x91BA.AimAssistFOV, false,"Head")
if not _0x61D9 then return end
local _0x1BC9 = _0x3271(_0x61D9,"Head")
if not _0x1BC9 then return end
_0x4A4A.CFrame = _0x4A4A.CFrame:Lerp(CFrame.new(_0x4A4A.CFrame.Position, _0x1BC9.Position), _0x91BA.AimAssistStrength * 0.15)
end)
_0xDDE4.RenderStepped:Connect(function()
if not _0x91BA.SilentAim then _0xD326 = nil; return end
local _0x61D9 = _0xAD98(_0x91BA.SilentAimFOV, _0x91BA.SilentAimWallCheck, _0x91BA.SilentAimHitPart)
if _0x61D9 then
local _0x1BC9 = _0x3271(_0x61D9, _0x91BA.SilentAimHitPart)
if _0x1BC9 then _0xD326 = _0x1BC9.Position end
else
_0xD326 = nil
end
end)
_0xDDE4.RenderStepped:Connect(function()
if not _0x91BA.MagicBullet then _0x6B87 = nil; return end
local _0x61D9 = _0xAD98(_0x91BA.MagicBulletFOV, false,"Head")
if _0x61D9 then
local _0x1BC9 = _0x3271(_0x61D9,"Head")
if _0x1BC9 then _0x6B87 = _0x1BC9.Position end
else
_0x6B87 = nil
end
end)task.spawn(function()
while true do
task.wait(_0x91BA.ForcefieldRefresh)
if _0x91BA.ForcefieldLocal and _0x3B67.Character then
if not (_0xE7DB.ForcefieldObj and _0xE7DB.ForcefieldObj.Parent == _0x3B67.Character) then
_0xE7DB.ForcefieldObj = _0xC733("ForceField", {
Name ="LEOLABAKAKA_FF",
Visible = false,
Parent = _0x3B67.Character,
})
end
elseif _0xE7DB.ForcefieldObj and _0xE7DB.ForcefieldObj.Parent then
_0xE7DB.ForcefieldObj:Destroy()
_0xE7DB.ForcefieldObj = nil
end
end
end)
local _0x5274 = {"heal","med","bandage","health","potion","kit","revive","syringe","injector"}
local function _0xF28E()
local _0x0D3B = _0x3B67.Character
if _0x0D3B then
for _, _0x61D9 in ipairs(_0x0D3B:GetChildren()) do
if _0x61D9:IsA("Tool") then
local _0xBD64 = _0x61D9.Name:lower()
for _, k in ipairs(_0x5274) do
if _0xBD64:find(k, 1, true) then return _0x61D9 end
end
end
end
end
local _0xC673 = _0x3B67:FindFirstChild("Backpack")
if _0xC673 then
for _, _0x61D9 in ipairs(_0xC673:GetChildren()) do
if _0x61D9:IsA("Tool") then
local _0xBD64 = _0x61D9.Name:lower()
for _, k in ipairs(_0x5274) do
if _0xBD64:find(k, 1, true) then return _0x61D9 end
end
end
end
end
end
task.spawn(function()
while true do
task.wait(0.1)
if not _0x91BA.AutoHeal then continue end
local _0x1BC9 = _0x4578()
if not _0x1BC9 or _0x1BC9.Health <= 0 then continue end
if _0x1BC9.Health / _0x1BC9.MaxHealth * 100 > _0x91BA.AutoHealThreshold then continue end
if tick() - _0xE7DB.AutoHealLast < _0x91BA.AutoHealCooldown then continue end
local _0x4C7D = _0xF28E()
if _0x4C7D then
if _0x4C7D.Parent ~= _0x3B67.Character then
pcall(function() _0x1BC9:EquipTool(_0x4C7D) end)
task.wait(0.08)
end
pcall(function() _0x4C7D:Activate() end)
_0xE7DB.AutoHealLast = tick()
end
end
end)
local function _0x2B82()
local _0xEDA5 = _0x53E3(_0x3B67)
if not _0xEDA5 then return nil end
local _0xFE51 = _0xEDA5.Position
local _0x6E95, _0xADE9 = nil, math.huge
for _, p in ipairs(_0x0DC7:GetPlayers()) do
if _0xBE50(p) and not _0x77CF(p) and not _0xF664(_0x3B67, p) and not _0x65BA(p) then
local _0xB7CA = _0x53E3(p)
if _0xB7CA then
local _0xE41C = (_0xB7CA.Position - _0xFE51).Magnitude
if _0xE41C <= _0x91BA.AutoDodgeRange and _0xE41C < _0xADE9 then
local _0xB326 = _0xB7CA.CFrame.LookVector:Dot((_0xFE51 - _0xB7CA.Position).Unit)
if _0xB326 > 0.85 then _0x6E95, _0xADE9 = p, _0xE41C end
end
end
end
end
return _0x6E95
end
task.spawn(function()
while true do
task.wait(0.08)
if not _0x91BA.AutoDodge then continue end
local _0x218A = _0x2B82()
if not _0x218A then continue end
local _0x1BC9 = _0x4578()
local _0xEDA5 = _0x53E3(_0x3B67)
local _0x0987 = _0x53E3(_0x218A)
if not (_0x1BC9 and _0xEDA5 and _0x0987) then continue end
if tick() - _0xE7DB.DodgeLast > 0.15 then
_0xE7DB.DodgeDir = (math.random() > 0.5) and 1 or -1
_0xE7DB.DodgeLast = tick()
end
local _0xF5C0 = _0x0987.CFrame.RightVector * _0xE7DB.DodgeDir
pcall(function() _0x1BC9:Move(_0xF5C0 * _0x91BA.AutoDodgeStrength, false) end)
end
end)
local function _0xF4F0(p)
if not p or not p.Character then return false end
for _, _0x61D9 in ipairs(p.Character:GetChildren()) do
if _0x61D9:IsA("Tool") and (_0x61D9.Name:lower():find("katana") or _0x61D9.Name:lower():find("sword")
or _0x61D9.Name:lower():find("blade") or _0x61D9.Name:lower():find("saber")) then
return true
end
end
local _0xC673 = p:FindFirstChild("Backpack")
if _0xC673 then
for _, _0x61D9 in ipairs(_0xC673:GetChildren()) do
if _0x61D9:IsA("Tool") and (_0x61D9.Name:lower():find("katana") or _0x61D9.Name:lower():find("blade")) then
return true
end
end
end
return false
end
task.spawn(function()
while true do
task.wait(0.1)
if not _0x91BA.AntiKatana then continue end
if _0x38A3 and _0xF4F0(_0x38A3) then
if _0x91BA.AimbotLockedTarget == _0x38A3 then _0x91BA.AimbotLockedTarget = nil end
_0xD326 = nil
_0x6B87 = nil
end
end
end)local _0x9131 = {"adonis","anticheat","detected","kick","ban","exploit","cheat","suspicious","report","flag","watchdog","sentry",
}
local function _0x443F(_0xDA0F)
local _0xBD64 = _0xDA0F:lower()
for _, k in ipairs(_0x9131) do
if _0xBD64:find(k, 1, true) then return true end
end
return false
end
local function _0xB4F5()
if not (_0xF843 and _0x2185 and _0xB52B and _0xD413) then return end
_0xE7DB.AdonisHooks = {}
local function _0xDEF4(p, _0xE41C)
if _0xE41C > 5 then return end
for _, _0x7FB1 in ipairs(p:GetChildren()) do
if (_0x7FB1:IsA("RemoteEvent") or _0x7FB1:IsA("RemoteFunction")) and _0x443F(_0x7FB1.Name) then
table.insert(_0xE7DB.AdonisHooks, _0x7FB1)
end
pcall(_0xDEF4, _0x7FB1, _0xE41C + 1)
end
end
pcall(_0xDEF4, _0xE2F5, 0)
pcall(_0xDEF4, workspace, 0)
local _0x466C, _0xA4FF = pcall(getrawmetatable, game)
if not _0x466C or not _0xA4FF then return end
local _0xB1BC = _0xA4FF.__namecall
if not _0xB1BC then return end
pcall(setreadonly, _0xA4FF, false)
_0xA4FF.__namecall = newcclosure(function(self, ...)
local _0xB618 = getnamecallmethod()
if _0xB618 =="FireServer"or _0xB618 =="InvokeServer"then
for _, _0x96A0 in ipairs(_0xE7DB.AdonisHooks) do
if _0x96A0 == self then return nil end
end
end
return _0xB1BC(self, ...)
end)
pcall(setreadonly, _0xA4FF, true)
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
_0x6EA0("Anti-Cheat", #_0xE7DB.AdonisHooks .." remotes bypass", _0x7082.Success)
end
task.spawn(_0xB4F5)if not _0xE7DB.HitSound then
_0xE7DB.HitSound = _0xC733("Sound", {
SoundId = _0x91BA.HitSoundId,
Volume = _0x91BA.HitSoundVol,
Parent = _0xF726,
})
end
if not _0xE7DB.KillSound then
_0xE7DB.KillSound = _0xC733("Sound", {
SoundId = _0x91BA.KillSoundId,
Volume = _0x91BA.KillSoundVol,
Parent = _0xF726,
})
end
local _0xA305 = _0xC733("ScreenGui", {
Name ="LEOLABAKAKA_HitMarkers",
ResetOnSpawn = false,
IgnoreGuiInset = true,
DisplayOrder = 9999,
Parent = _0x9B21,
})
local function _0x61BE()
if not _0x91BA.HitMarker then return end
local _0xB618 = _0xC733("Frame", {
Size = UDim2.new(0, 24, 0, 24),
Position = UDim2.new(0.5, -12, 0.5, -12),
BackgroundTransparency = 1,
Parent = _0xA305,
})
for _0xBE38 = 1, 4 do
local _0x9BF5 = math.rad((_0xBE38 - 1) * 90 + 45)
local _0xCECB = _0xC733("Frame", {
Size = UDim2.new(0, 2, 0, 8),
BackgroundColor3 = _0x7082.Danger,
BorderSizePixel = 0,
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, math.cos(_0x9BF5) * 8, 0.5, math.sin(_0x9BF5) * 8),
Parent = _0xB618,
})
_0x72EF:Create(_0xCECB, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
Position = UDim2.new(0.5, math.cos(_0x9BF5) * 14, 0.5, math.sin(_0x9BF5) * 14),
BackgroundTransparency = 1,
}):Play()
end
task.delay(0.2, function() if _0xB618 and _0xB618.Parent then _0xB618:Destroy() end end)
end
local function _0xA5DF(amount, pos)
if not _0x91BA.DamageIndicator or not pos then return end
local _0xD772 = _0xC733("TextLabel", {
Size = UDim2.new(0, 60, 0, 24),
Position = UDim2.new(0, pos.X - 30, 0, pos.Y - 20),
BackgroundTransparency = 1,
Text = tostring(math.floor(amount)),
TextColor3 = _0x7082.Warn,
Font = Enum.Font.GothamBlack,
TextSize = 18,
TextStrokeTransparency = 0,
TextStrokeColor3 = Color3.new(0, 0, 0),
Parent = _0xA305,
})
_0x72EF:Create(_0xD772, TweenInfo.new(0.8), {
Position = UDim2.new(0, pos.X - 30, 0, pos.Y - 60),
TextTransparency = 1,
TextStrokeTransparency = 1,
}):Play()
task.delay(0.9, function() if _0xD772 and _0xD772.Parent then _0xD772:Destroy() end end)
end
task.spawn(function()
for _, p in ipairs(_0x0DC7:GetPlayers()) do
if p ~= _0x3B67 then
local _0x1BC9 = _0x4578(p)
if _0x1BC9 then _0xE7DB.LastHealth[p] = _0x1BC9.Health end
end
end
end)
_0x0DC7.PlayerAdded:Connect(function(p)
p.CharacterAdded:Connect(function(_0x0D3B)
task.wait(0.5)
local _0x1BC9 = _0x0D3B:FindFirstChildOfClass("Humanoid")
if _0x1BC9 then _0xE7DB.LastHealth[p] = _0x1BC9.Health end
end)
end)
task.spawn(function()
while true do
task.wait(0.05)
for _, p in ipairs(_0x0DC7:GetPlayers()) do
if p ~= _0x3B67 and _0xBE50(p) then
local _0x1BC9 = _0x4578(p)
if _0x1BC9 then
local _0xFEFD = _0xE7DB.LastHealth[p] or _0x1BC9.Health
if _0x1BC9.Health < _0xFEFD - 1 then
local _0xF3DE = _0xFEFD - _0x1BC9.Health
if _0x91BA.HitSound and _0xE7DB.HitSound then
_0xE7DB.HitSound.SoundId = _0x91BA.HitSoundId
_0xE7DB.HitSound.Volume = _0x91BA.HitSoundVol
pcall(function() _0xE7DB.HitSound:Play() end)
end
_0x61BE()
local _0x3229 = _0x3271(p,"Head")
if _0x3229 then
local _0x4BC5, _0x5594 = _0x4A4A:WorldToViewportPoint(_0x3229.Position)
if _0x5594 then _0xA5DF(_0xF3DE, Vector2.new(_0x4BC5.X, _0x4BC5.Y)) end
end
end
if _0x1BC9.Health <= 0 and _0xFEFD > 0 then
if _0x91BA.KillSound and _0xE7DB.KillSound then
_0xE7DB.KillSound.SoundId = _0x91BA.KillSoundId
_0xE7DB.KillSound.Volume = _0x91BA.KillSoundVol
pcall(function() _0xE7DB.KillSound:Play() end)
end
if _0x91BA.KillEffect then
local _0xB7CA = _0x53E3(p)
if _0xB7CA then
pcall(function()
local _0xA2B2 = _0xC733("Attachment", {Parent = _0xB7CA})
local _0xD387 = _0xC733("ParticleEmitter", {
Parent = _0xA2B2,
Rate = 0,
Lifetime = NumberRange.new(0.5, 1),
Speed = NumberRange.new(15, 25),
SpreadAngle = Vector2.new(180, 180),
Color = ColorSequence.new(_0x7082.Danger, _0x7082.Accent3),
Size = NumberSequence.new(0.4, 0),
Transparency = NumberSequence.new(0, 1),
LightEmission = 1,
})
_0xD387:Emit(30)
_0x5872:AddItem(_0xA2B2, 2)
end)
end
end
end
_0xE7DB.LastHealth[p] = _0x1BC9.Health
end
end
end
end
end)_0x3B67.Idled:Connect(function()
if not _0x91BA.AntiAFK then return end
pcall(function()
_0x5FAD:CaptureController()
_0x5FAD:ClickButton2(Vector2.new())
end)
end)
task.spawn(function()
while true do
task.wait(0.3)
if not _0x91BA.AntiVoid then continue end
local _0xEDA5 = _0x53E3(_0x3B67)
if not _0xEDA5 then continue end
if _0xEDA5.Position.Y < _0x91BA.AntiVoidY then
local _0x4BC5 = workspace:FindFirstChildOfClass("SpawnLocation")
if _0x4BC5 then pcall(function() _0xEDA5.CFrame = _0x4BC5.CFrame + Vector3.new(0, 5, 0) end) end
end
end
end)
_0x4D5E.JumpRequest:Connect(function()
if _0x91BA.InfJump then
local _0x1BC9 = _0x4578()
if _0x1BC9 then pcall(function() _0x1BC9:ChangeState(Enum.HumanoidStateType.Jumping) end) end
end
end)
task.spawn(function()
while true do
task.wait(0.05)
if not _0x91BA.BunnyHop then continue end
local _0x1BC9 = _0x4578()
local _0xB7CA = _0x53E3(_0x3B67)
if _0x1BC9 and _0xB7CA then
local _0x3DEB = _0x1BC9:GetState()
if _0x3DEB == Enum.HumanoidStateType.Landed or _0x3DEB == Enum.HumanoidStateType.Running then
pcall(function() _0x1BC9.JumpPower = _0x91BA.BhopPower end)
pcall(function() _0x1BC9:ChangeState(Enum.HumanoidStateType.Jumping) end)
end
end
end
end)
task.spawn(function()
while true do
task.wait(0.5)
if not _0x91BA.SilentWalk then continue end
if _0x3B67.Character then
for _, _0xE41C in ipairs(_0x3B67.Character:GetDescendants()) do
if _0xE41C:IsA("Sound") and (_0xE41C.Name:lower():find("step") or _0xE41C.Name:lower():find("walk")) then
_0xE41C.Volume = 0
end
end
end
end
end)task.spawn(function()
while true do
task.wait(0.4)
if not _0x91BA.AutoPickup then continue end
local _0xEDA5 = _0x53E3(_0x3B67)
if not _0xEDA5 then continue end
for _, _0xE41C in ipairs(workspace:GetDescendants()) do
if _0xE41C:IsA("BasePart") and (_0xE41C.Name:lower():find("pickup") or _0xE41C.Name:lower():find("loot")) then
if (_0xE41C.Position - _0xEDA5.Position).Magnitude < 8 then
pcall(function()
firetouchinterest(_0xEDA5, _0xE41C, 0)
firetouchinterest(_0xEDA5, _0xE41C, 1)
end)
end
end
end
end
end)
task.spawn(function()
while true do
task.wait(0.15)
if not _0x91BA.AutoReload then continue end
local _0x0D3B = _0x3B67.Character
if not _0x0D3B then continue end
local _0x4C7D = _0x0D3B:FindFirstChildOfClass("Tool")
if _0x4C7D then
for _, prop in ipairs({"Ammo","CurrentAmmo","Clip","Magazine"}) do
local _0x10C0 = _0x4C7D[prop]
if type(_0x10C0) =="number"and _0x10C0 <= 1 then
pcall(function()
if _0x4C7D.Reload then _0x4C7D.Reload() end
_0x4C7D:Activate()
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
if not _0x91BA.AutoEquipBest then continue end
local _0x1BC9 = _0x4578()
if not _0x1BC9 then continue end
local _0x0D3B = _0x3B67.Character
local _0x9FA2 = _0x0D3B and _0x0D3B:FindFirstChildOfClass("Tool")
local _0x2FBF = _0x91BA.BestWeaponKeyword:lower()
local _0xC673 = _0x3B67:FindFirstChild("Backpack")
if _0xC673 then
for _, _0x61D9 in ipairs(_0xC673:GetChildren()) do
if _0x61D9:IsA("Tool") and _0x61D9.Name:lower():find(_0x2FBF, 1, true) then
if not _0x9FA2 or _0x9FA2.Name ~= _0x61D9.Name then
pcall(function() _0x1BC9:EquipTool(_0x61D9) end)
end
break
end
end
end
end
end)task.spawn(function()
while true do
task.wait(0.1)
if not _0x91BA.ThirdPerson then continue end
local _0xEDA5 = _0x53E3(_0x3B67)
if not _0xEDA5 then continue end
_0x4A4A.CameraSubject = _0xEDA5
_0x3B67.CameraMaxZoomDistance = 500
_0x3B67.CameraMinZoomDistance = _0x91BA.ThirdPersonDist
pcall(function() _0x3B67.CameraMode = Enum.CameraMode.Classic end)
end
end)
local function _0x8522()
if _0x91BA.NoFlash then
pcall(function() _0xE3CC.Brightness = math.min(_0xE3CC.Brightness, 2) end)
pcall(function() _0xE3CC.ExposureCompensation = math.clamp(_0xE3CC.ExposureCompensation, -1, 0) end)
end
if _0x91BA.NoFog then
pcall(function()
_0xE3CC.FogEnd = 1e6
_0xE3CC.FogStart = 0
end)
for _, _0x597E in ipairs(_0xE3CC:GetChildren()) do
if _0x597E:IsA("Atmosphere") then _0x597E.Density = 0 end
end
end
end
task.spawn(function()
while true do
task.wait(2)
_0x8522()
end
end)
if _0x91BA.FPSUnlocker then
pcall(function()
if setfpscap then setfpscap(_0x91BA.FPSLimit) end
end)
endlocal _0xB537 = {}
local function _0x54A4(_0xDA60)
if _0xB537[_0xDA60] then return end
_0xB537[_0xDA60] = true
local function _0x02F7()
for _, prop in ipairs({"Recoil","RecoilX","RecoilY","Spread","SpreadX","SpreadY","CameraShake","Shake","Kick","Kickback",
}) do
pcall(function()
if _0xDA60[prop] ~= nil and (_0x91BA.NoRecoil or _0x91BA.NoSpread) then
_0xDA60[prop] = 0
end
end)
end
for _, prop in ipairs({"ReloadTime","ReloadSpeed","ReloadDuration"}) do
pcall(function()
if _0xDA60[prop] ~= nil and _0x91BA.NoReload then _0xDA60[prop] = 0 end
end)
end
for _, prop in ipairs({"FireRate","FireDelay","Cooldown","Debounce"}) do
pcall(function()
if _0xDA60[prop] ~= nil and _0x91BA.RapidFire then
_0xDA60[prop] = _0xDA60[prop] / math.max(1, _0x91BA.RapidFireMulti)
end
end)
end
for _, prop in ipairs({"Ammo","MaxAmmo","ClipSize","Magazine","CurrentAmmo"}) do
pcall(function()
if _0xDA60[prop] ~= nil and _0x91BA.InfiniteAmmo then _0xDA60[prop] = 9999 end
end)
end
end
_0x02F7()
pcall(function()
_0xDA60.ChildAdded:Connect(function() task.wait(0.05); _0x02F7() end)
_0xDA60:GetPropertyChangedSignal("Parent"):Connect(function() task.wait(0.05); _0x02F7() end)
end)
end
local function _0x2A53()
pcall(function()
for _, _0x7FB1 in ipairs(_0x4A4A:GetChildren()) do
if _0x7FB1.Name:lower():find("weapon") or _0x7FB1.Name:lower():find("gun")
or _0x7FB1.Name:lower():find("tool") or _0x7FB1.Name:lower():find("viewmodel") then
_0x54A4(_0x7FB1)
for _, _0xE41C in ipairs(_0x7FB1:GetDescendants()) do
if _0xE41C:IsA("Model") or _0xE41C:IsA("Folder") then _0x54A4(_0xE41C) end
end
end
end
end)
pcall(function()
local _0x0D3B = _0x3B67.Character
if _0x0D3B then
for _, _0x61D9 in ipairs(_0x0D3B:GetChildren()) do
if _0x61D9:IsA("Tool") then _0x54A4(_0x61D9) end
end
end
end)
pcall(function()
local _0xC673 = _0x3B67:FindFirstChild("Backpack")
if _0xC673 then
for _, _0x61D9 in ipairs(_0xC673:GetChildren()) do
if _0x61D9:IsA("Tool") then _0x54A4(_0x61D9) end
end
end
end)
end
task.spawn(function()
while true do
task.wait(1)
_0x2A53()
end
end)task.spawn(function()
while true do
task.wait(0.2)
if _0x91BA.HitboxExpander then
for _, p in ipairs(_0x0DC7:GetPlayers()) do
if _0xBE50(p) and not _0x77CF(p) and not _0xF664(_0x3B67, p) and not _0x65BA(p) then
local _0x0D3B = p.Character
if _0x0D3B then
for _, _0x42C5 in ipairs(_0x0D3B:GetChildren()) do
if _0x42C5:IsA("BasePart")
and (_0x42C5.Name =="Head"or _0x42C5.Name =="Torso"or _0x42C5.Name =="UpperTorso"or _0x42C5.Name =="HumanoidRootPart") then
if not _0xE7DB.Hitboxes[_0x42C5] then
_0xE7DB.Hitboxes[_0x42C5] = {
Size = _0x42C5.Size,
Transparency = _0x42C5.Transparency,
CanCollide = _0x42C5.CanCollide,
Massless = _0x42C5.Massless,
}
end
pcall(function()
_0x42C5.Size = Vector3.new(_0x91BA.HitboxSize, _0x91BA.HitboxSize, _0x91BA.HitboxSize)
_0x42C5.Transparency = _0x91BA.HitboxTransparency
_0x42C5.CanCollide = false
_0x42C5.Massless = true
end)
end
end
end
end
end
else
for _0x42C5, _0xE41C in pairs(_0xE7DB.Hitboxes) do
if _0x42C5 and _0x42C5.Parent then
pcall(function()
_0x42C5.Size = _0xE41C.Size
_0x42C5.Transparency = _0xE41C.Transparency
_0x42C5.CanCollide = _0xE41C.CanCollide
_0x42C5.Massless = _0xE41C.Massless
end)
end
_0xE7DB.Hitboxes[_0x42C5] = nil
end
end
end
end)
task.spawn(function()
while true do
task.wait(0.25)
if _0x91BA.HitboxMega then
for _, p in ipairs(_0x0DC7:GetPlayers()) do
if _0xBE50(p) and not _0x77CF(p) and not _0xF664(_0x3B67, p) and not _0x65BA(p) then
local _0x0D3B = p.Character
if _0x0D3B then
local _0x21ED = _0x91BA.HitboxMegaMultiPart
and {"Head","UpperTorso","Torso","HumanoidRootPart","LowerTorso"}
or {"HumanoidRootPart"}
for _, _0xBD64 in ipairs(_0x21ED) do
local _0x42C5 = _0x0D3B:FindFirstChild(_0xBD64)
if _0x42C5 and _0x42C5:IsA("BasePart") then
if not _0xE7DB.MegaHitboxes[_0x42C5] then
_0xE7DB.MegaHitboxes[_0x42C5] = {
Size = _0x42C5.Size,
Transparency = _0x42C5.Transparency,
CanCollide = _0x42C5.CanCollide,
Massless = _0x42C5.Massless,
}
end
pcall(function()
_0x42C5.Size = Vector3.new(_0x91BA.HitboxMegaSize, _0x91BA.HitboxMegaSize, _0x91BA.HitboxMegaSize)
_0x42C5.Transparency = _0x91BA.HitboxMegaInvisible and 1 or 0.5
_0x42C5.CanCollide = false
_0x42C5.Massless = true
end)
end
end
end
end
end
else
for _0x42C5, _0xE41C in pairs(_0xE7DB.MegaHitboxes) do
if _0x42C5 and _0x42C5.Parent then
pcall(function()
_0x42C5.Size = _0xE41C.Size
_0x42C5.Transparency = _0xE41C.Transparency
_0x42C5.CanCollide = _0xE41C.CanCollide
_0x42C5.Massless = _0xE41C.Massless
end)
end
_0xE7DB.MegaHitboxes[_0x42C5] = nil
end
end
end
end)task.spawn(function()
while true do
task.wait(0.1)
if _0x91BA.FOVChanger then _0x4A4A.FieldOfView = _0x91BA.FOVValue end
end
end)
task.spawn(function()
while true do
task.wait(0.1)
if _0x91BA.SpeedHack then
local _0x1BC9 = _0x4578()
if _0x1BC9 and _0x1BC9.WalkSpeed ~= _0x91BA.SpeedValue then _0x1BC9.WalkSpeed = _0x91BA.SpeedValue end
end
end
end)
_0xDDE4.Stepped:Connect(function()
if not _0x91BA.Noclip then return end
local _0x0D3B = _0x3B67.Character
if not _0x0D3B then return end
for _, p in ipairs(_0x0D3B:GetDescendants()) do
if p:IsA("BasePart") then
p.CanCollide = false
p.CanTouch = false
p.CanQuery = false
end
end
end)local function _0xC362(plr)
if plr == _0x3B67 or _0xE7DB.ESPObjs[plr] then return end
if not _0xF199 then return end
local _0x472D = Drawing.new("Square")
_0x472D.Thickness = 2; _0x472D.Filled = false; _0x472D.Visible = false
local _0x58A7 = Drawing.new("Square")
_0x58A7.Thickness = 4; _0x58A7.Filled = false; _0x58A7.Visible = false; _0x58A7.Transparency = 0.85
local _0xDECB = Drawing.new("Square")
_0xDECB.Thickness = 1; _0xDECB.Filled = true; _0xDECB.Visible = false
_0xDECB.Color = Color3.new(0, 0, 0); _0xDECB.Transparency = 0.4
local _0xDA0F = Drawing.new("Text")
_0xDA0F.Center = true; _0xDA0F.Outline = true; _0xDA0F.Size = 15; _0xDA0F.Visible = false; _0xDA0F.Font = 2
local _0xE62A = Drawing.new("Text")
_0xE62A.Center = true; _0xE62A.Outline = true; _0xE62A.Size = 13; _0xE62A.Visible = false; _0xE62A.Font = 2
local _0x7C8E = Drawing.new("Square")
_0x7C8E.Thickness = 1; _0x7C8E.Filled = true; _0x7C8E.Visible = false
_0x7C8E.Color = Color3.fromRGB(20, 20, 30); _0x7C8E.Transparency = 0.15
local _0x2DF2 = Drawing.new("Square")
_0x2DF2.Thickness = 1; _0x2DF2.Filled = true; _0x2DF2.Visible = false
local _0x0BD5 = Drawing.new("Line")
_0x0BD5.Thickness = 1.5; _0x0BD5.Visible = false
local _0xED7B = Drawing.new("Circle")
_0xED7B.Thickness = 2; _0xED7B.Filled = true; _0xED7B.NumSides = 16; _0xED7B.Radius = 5; _0xED7B.Visible = false
local _0x86F9 = Drawing.new("Square")
_0x86F9.Thickness = 1; _0x86F9.Filled = true
_0x86F9.Color = _0x7082.Accent; _0x86F9.Transparency = 0.78; _0x86F9.Visible = false
local _0xB033 = Drawing.new("Line"); _0xB033.Thickness = 2; _0xB033.Visible = false
local _0xCDE2 = Drawing.new("Line"); _0xCDE2.Thickness = 2; _0xCDE2.Visible = false
local _0x4F91 = Drawing.new("Line"); _0x4F91.Thickness = 2; _0x4F91.Visible = false
local _0x9187 = Drawing.new("Line"); _0x9187.Thickness = 2; _0x9187.Visible = falselocal _0x33DA = Drawing.new("Text")
_0x33DA.Center = true; _0x33DA.Outline = true; _0x33DA.Size = 12; _0x33DA.Visible = false; _0x33DA.Font = 2
_0xE7DB.ESPObjs[plr] = {
Box = _0x472D, BoxGlow = _0x58A7, NameBg = _0xDECB, Name = _0xDA0F, Dist = _0xE62A,
HPBarBg = _0x7C8E, HPBar = _0x2DF2, Tracer = _0x0BD5, HeadDot = _0xED7B, Chams = _0x86F9,
Corner1 = _0xB033, Corner2 = _0xCDE2, Corner3 = _0x4F91, Corner4 = _0x9187,
AllyTag = _0x33DA,
}
end
local function _0xC491(plr)
local _0x597E = _0xE7DB.ESPObjs[plr]
if _0x597E then
for _, _0xE41C in pairs(_0x597E) do pcall(function() _0xE41C:Remove() end) end
end
_0xE7DB.ESPObjs[plr] = nil
end
local function _0xD711(_0x597E)
pcall(function()
_0x597E.Box.Visible = false; _0x597E.BoxGlow.Visible = false; _0x597E.NameBg.Visible = false
_0x597E.Name.Visible = false; _0x597E.Dist.Visible = false; _0x597E.HPBarBg.Visible = false
_0x597E.HPBar.Visible = false; _0x597E.Tracer.Visible = false; _0x597E.HeadDot.Visible = false
_0x597E.Chams.Visible = false; _0x597E.Corner1.Visible = false; _0x597E.Corner2.Visible = false
_0x597E.Corner3.Visible = false; _0x597E.Corner4.Visible = false
if _0x597E.AllyTag then _0x597E.AllyTag.Visible = false end
end)
end
for _, p in ipairs(_0x0DC7:GetPlayers()) do _0xC362(p) end
_0x0DC7.PlayerAdded:Connect(function(p)
task.wait(1)
if p and p.Parent then _0xC362(p) end
end)
_0x0DC7.PlayerRemoving:Connect(function(p) _0xC491(p) end)
_0xDDE4.RenderStepped:Connect(function()
if not _0xF199 then return end
if not _0x91BA.ESP then
for _, _0x597E in pairs(_0xE7DB.ESPObjs) do _0xD711(_0x597E) end
return
end
local _0xFD09 = workspace.CurrentCamera
if not _0xFD09 then return end
local _0xEDA5 = _0x53E3(_0x3B67)
local _0xFE51 = _0xEDA5 and _0xEDA5.Position
for plr, _0x597E in pairs(_0xE7DB.ESPObjs) do
local _0x466C = pcall(function() return _0x597E.Box.Visible end)
if not _0x466C then _0xE7DB.ESPObjs[plr] = nil; continue end
local _0xA553 = _0x65BA(plr) or _0x77CF(plr) or _0xF664(_0x3B67, plr)
local _0xA030 = _0xBE50(plr)
if not _0xA030 and not _0xA553 then
_0xD711(_0x597E)
continue
endif _0x91BA.ESPTeamCheck and _0xA553 and not _0x91BA.ESPAllyColor then
_0xD711(_0x597E)
continue
end
local _0x0D3B = plr.Character
local _0xB7CA = _0x0D3B and _0x0D3B:FindFirstChild("HumanoidRootPart")
local _0x3229 = _0x0D3B and _0x0D3B:FindFirstChild("Head")
local _0xF177 = _0x0D3B and _0x0D3B:FindFirstChildOfClass("Humanoid")
if not (_0xB7CA and _0x3229 and _0xF177 and _0xF177.Health > 0) then
_0xD711(_0x597E)
continue
end
local _0x0862, _0x5932 = _0xFD09:WorldToViewportPoint(_0x3229.Position + Vector3.new(0, 0.5, 0))
local _0x2887, _0x7B60 = _0xFD09:WorldToViewportPoint(_0xB7CA.Position - Vector3.new(0, 3, 0))
if not (_0x5932 or _0x7B60) then
_0xD711(_0x597E)
continue
end
local _0x1BC9 = math.abs(_0x0862.Y - _0x2887.Y)
local _0xDA60 = _0x1BC9 / 2
local _0x71DC = _0x0862.X - _0xDA60 / 2
local _0x0419 = _0x0862.Ylocal _0x8474
if _0xA553 then
_0x8474 = _0x91BA.ESPAllyColor and _0x7082.AllyESP or _0x7082.NeutralESP
else
_0x8474 = _0x91BA.ESPEnemyColor and _0x7082.EnemyESP or _0x7082.Danger
end
if _0x91BA.ESPChams then
pcall(function()
_0x597E.Chams.Size = Vector2.new(_0xDA60 + 8, _0x1BC9 + 8)
_0x597E.Chams.Position = Vector2.new(_0x71DC - 4, _0x0419 - 4)
if _0xA553 then
_0x597E.Chams.Color = _0x7082.AllyESP
elseif _0x91BA.ESPRainbow then
_0x597E.Chams.Color = Color3.fromHSV((tick() * 0.3) % 1, 0.6, 1)
else
_0x597E.Chams.Color = _0x8474
end
_0x597E.Chams.Visible = true
end)
else
pcall(function() _0x597E.Chams.Visible = false end)
end
if _0x91BA.ESPBox then
pcall(function()
_0x597E.BoxGlow.Size = Vector2.new(_0xDA60 + 4, _0x1BC9 + 4)
_0x597E.BoxGlow.Position = Vector2.new(_0x71DC - 2, _0x0419 - 2)
_0x597E.BoxGlow.Color = _0xA553 and _0x7082.AllyESP or (_0x91BA.ESPRainbow and Color3.fromHSV((tick() * 0.4) % 1, 1, 1) or _0x8474)
_0x597E.BoxGlow.Visible = true
_0x597E.Box.Size = Vector2.new(_0xDA60, _0x1BC9)
_0x597E.Box.Position = Vector2.new(_0x71DC, _0x0419)
_0x597E.Box.Color = _0x8474
_0x597E.Box.Visible = true
end)
local _0xDD4C = _0xDA60 * 0.25
pcall(function()
_0x597E.Corner1.From = Vector2.new(_0x71DC, _0x0419)
_0x597E.Corner1.To = Vector2.new(_0x71DC + _0xDD4C, _0x0419)
_0x597E.Corner1.Color = _0x8474; _0x597E.Corner1.Visible = true
_0x597E.Corner2.From = Vector2.new(_0x71DC, _0x0419)
_0x597E.Corner2.To = Vector2.new(_0x71DC, _0x0419 + _0xDD4C)
_0x597E.Corner2.Color = _0x8474; _0x597E.Corner2.Visible = true
_0x597E.Corner3.From = Vector2.new(_0x71DC + _0xDA60, _0x0419 + _0x1BC9)
_0x597E.Corner3.To = Vector2.new(_0x71DC + _0xDA60 - _0xDD4C, _0x0419 + _0x1BC9)
_0x597E.Corner3.Color = _0x8474; _0x597E.Corner3.Visible = true
_0x597E.Corner4.From = Vector2.new(_0x71DC + _0xDA60, _0x0419 + _0x1BC9)
_0x597E.Corner4.To = Vector2.new(_0x71DC + _0xDA60, _0x0419 + _0x1BC9 - _0xDD4C)
_0x597E.Corner4.Color = _0x8474; _0x597E.Corner4.Visible = true
end)
else
pcall(function()
_0x597E.Box.Visible = false; _0x597E.BoxGlow.Visible = false
_0x597E.Corner1.Visible = false; _0x597E.Corner2.Visible = false
_0x597E.Corner3.Visible = false; _0x597E.Corner4.Visible = false
end)
end
if _0x91BA.ESPName then
pcall(function()
_0x597E.Name.Text = plr.Name
_0x597E.Name.Position = Vector2.new(_0x0862.X, _0x0419 - 22)
_0x597E.Name.Color = _0xA553 and _0x7082.AllyESP or _0x7082.Text
_0x597E.Name.Visible = true
_0x597E.NameBg.Size = Vector2.new(_0xDA60 + 30, 18)
_0x597E.NameBg.Position = Vector2.new(_0x0862.X - (_0xDA60 + 30) / 2, _0x0419 - 28)
_0x597E.NameBg.Visible = true
end)
else
pcall(function() _0x597E.Name.Visible = false; _0x597E.NameBg.Visible = false end)
end
if _0xA553 and _0x597E.AllyTag then
pcall(function()
_0x597E.AllyTag.Text ="[ALLY]"_0x597E.AllyTag.Position = Vector2.new(_0x0862.X, _0x0419 - 38)
_0x597E.AllyTag.Color = _0x7082.AllyESP
_0x597E.AllyTag.Visible = true
end)
elseif _0x597E.AllyTag then
pcall(function() _0x597E.AllyTag.Visible = false end)
end
if _0x91BA.ESPHealth then
local _0xC167 = math.clamp(_0xF177.Health / _0xF177.MaxHealth, 0, 1)
pcall(function()
_0x597E.HPBarBg.Size = Vector2.new(6, _0x1BC9 + 2)
_0x597E.HPBarBg.Position = Vector2.new(_0x71DC - 9, _0x0419 - 1)
_0x597E.HPBarBg.Visible = true
_0x597E.HPBar.Size = Vector2.new(4, _0x1BC9 * _0xC167)
_0x597E.HPBar.Position = Vector2.new(_0x71DC - 8, _0x0419 + _0x1BC9 * (1 - _0xC167))
if _0xA553 then
_0x597E.HPBar.Color = _0x7082.AllyESP
elseif _0xC167 > 0.6 then
_0x597E.HPBar.Color = Color3.fromRGB(120, 230, 160)
elseif _0xC167 > 0.3 then
_0x597E.HPBar.Color = Color3.fromRGB(255, 200, 110)
else
_0x597E.HPBar.Color = Color3.fromRGB(255, 100, 120)
end
_0x597E.HPBar.Visible = true
end)
else
pcall(function() _0x597E.HPBar.Visible = false; _0x597E.HPBarBg.Visible = false end)
end
if _0x91BA.ESPDistance and _0xFE51 then
pcall(function()
local _0xE41C = (_0xB7CA.Position - _0xFE51).Magnitude
_0x597E.Dist.Text = string.format("[%.0fm]", _0xE41C)
_0x597E.Dist.Position = Vector2.new(_0x0862.X, _0x0419 + _0x1BC9 + 4)
_0x597E.Dist.Color = _0xA553 and _0x7082.AllyESP or _0x7082.TextDim
_0x597E.Dist.Visible = true
end)
else
pcall(function() _0x597E.Dist.Visible = false end)
end
if _0x91BA.ESPTracer and not _0xA553 then
pcall(function()
_0x597E.Tracer.From = Vector2.new(_0xFD09.ViewportSize.X / 2, _0xFD09.ViewportSize.Y)
_0x597E.Tracer.To = Vector2.new(_0x0862.X, _0x0862.Y)
_0x597E.Tracer.Color = _0x8474
_0x597E.Tracer.Visible = true
end)
else
pcall(function() _0x597E.Tracer.Visible = false end)
end
if _0x91BA.ESPHeadDot then
pcall(function()
_0x597E.HeadDot.Position = Vector2.new(_0x0862.X, _0x0862.Y)
_0x597E.HeadDot.Color = _0xA553 and _0x7082.AllyESP or _0x7082.Warn
_0x597E.HeadDot.Visible = true
end)
else
pcall(function() _0x597E.HeadDot.Visible = false end)
end
end
end)local _0x3A81 = {
{"Head","UpperTorso"}, {"UpperTorso","LowerTorso"},
{"UpperTorso","LeftUpperArm"}, {"LeftUpperArm","LeftLowerArm"},
{"LeftLowerArm","LeftHand"}, {"UpperTorso","RightUpperArm"},
{"RightUpperArm","RightLowerArm"}, {"RightLowerArm","RightHand"},
{"LowerTorso","LeftUpperLeg"}, {"LeftUpperLeg","LeftLowerLeg"},
{"LeftLowerLeg","LeftFoot"}, {"LowerTorso","RightUpperLeg"},
{"RightUpperLeg","RightLowerLeg"}, {"RightLowerLeg","RightFoot"},
}
local _0x0151 = {}
local function _0xDA9C(plr)
if _0x0151[plr] then return _0x0151[plr] end
if not _0xF199 then return nil end
local _0x3E45 = {}
for _0xBE38 = 1, #_0x3A81 do
local _0xCECB = Drawing.new("Line")
_0xCECB.Thickness = 1.5
_0xCECB.Visible = false
_0xCECB.Color = _0x7082.Accent
_0x3E45[_0xBE38] = _0xCECB
end
_0x0151[plr] = _0x3E45
return _0x3E45
end
_0xDDE4.RenderStepped:Connect(function()
if not _0xF199 then return end
if not (_0x91BA.ESP and _0x91BA.ESPSkeleton) then
for _, _0x3E45 in pairs(_0x0151) do
for _, _0xCECB in ipairs(_0x3E45) do pcall(function() _0xCECB.Visible = false end) end
end
return
end
local _0xFD09 = workspace.CurrentCamera
if not _0xFD09 then return end
for plr, _ in pairs(_0xE7DB.ESPObjs) do
local _0xA553 = _0x65BA(plr) or _0x77CF(plr) or _0xF664(_0x3B67, plr)
if _0xBE50(plr) or _0xA553 then
local _0x3E45 = _0xDA9C(plr)
if _0x3E45 then
local _0x0D3B = plr.Character
for _0xBE38, pair in ipairs(_0x3A81) do
local _0x9BF5 = _0x0D3B and _0x0D3B:FindFirstChild(pair[1])
local _0xC475 = _0x0D3B and _0x0D3B:FindFirstChild(pair[2])
if _0x9BF5 and _0xC475 and _0x9BF5:IsA("BasePart") and _0xC475:IsA("BasePart") then
local _0x6607, _0xA938 = _0xFD09:WorldToViewportPoint(_0x9BF5.Position)
local _0xC673, _0x4372 = _0xFD09:WorldToViewportPoint(_0xC475.Position)
if _0xA938 and _0x4372 then
pcall(function()
_0x3E45[_0xBE38].From = Vector2.new(_0x6607.X, _0x6607.Y)
_0x3E45[_0xBE38].To = Vector2.new(_0xC673.X, _0xC673.Y)
if _0xA553 then
_0x3E45[_0xBE38].Color = _0x7082.AllyESP
else
_0x3E45[_0xBE38].Color = Color3.fromHSV((tick() * 0.3 + _0xBE38 * 0.05) % 1, 0.7, 1)
end
_0x3E45[_0xBE38].Visible = true
end)
else
pcall(function() _0x3E45[_0xBE38].Visible = false end)
end
else
pcall(function() _0x3E45[_0xBE38].Visible = false end)
end
end
end
else
local _0x3E45 = _0x0151[plr]
if _0x3E45 then
for _, _0xCECB in ipairs(_0x3E45) do pcall(function() _0xCECB.Visible = false end) end
end
end
end
end)local function _0x8367()
if _0xE7DB.RadarGui and _0xE7DB.RadarGui.Parent then return end
local _0x8807 = _0xC733("ScreenGui", {
Name ="LEOLABAKAKA_Radar",
ResetOnSpawn = false,
IgnoreGuiInset = true,
DisplayOrder = 998,
Parent = _0x9B21,
})
_0xE7DB.RadarGui = _0x8807
local _0xBA2C = _0xC733("Frame", {
Size = UDim2.new(0, 200, 0, 200),
Position = UDim2.new(1, -220, 0, 20),
BackgroundColor3 = _0x7082.BgBase,
BackgroundTransparency = 0.15,
BorderSizePixel = 0,
Parent = _0x8807,
})
_0xC900(_0xBA2C, 14)
_0x7DF4(_0xBA2C, _0x7082.Border, 1, 0.3)
_0x6611(_0xBA2C, {{0, _0x7082.BgBase}, {1, _0x7082.BgDeep}}, 135)
_0xC733("TextLabel", {
Size = UDim2.new(1, 0, 0, 22),
Position = UDim2.new(0, 0, 0, 6),
BackgroundTransparency = 1,
Text ="RADAR",
TextColor3 = _0x7082.Accent,
Font = Enum.Font.GothamBold,
TextSize = 11,
Parent = _0xBA2C,
})
local _0x3190 = _0xC733("Frame", {
Size = UDim2.new(0, 6, 0, 6),
Position = UDim2.new(0.5, -3, 0.5, -3),
BackgroundColor3 = _0x7082.Accent,
BorderSizePixel = 0,
Parent = _0xBA2C,
})
_0xC900(_0x3190, 3)
_0x7DF4(_0x3190, _0x7082.Accent2, 1, 0)
task.spawn(function()
while _0x8807.Parent do
task.wait(0.1)
for _, _0x7FB1 in ipairs(_0xBA2C:GetChildren()) do
if _0x7FB1:IsA("Frame") and _0x7FB1 ~= _0x3190 then _0x7FB1:Destroy() end
end
if _0x91BA.Radar then
local _0xEDA5 = _0x53E3(_0x3B67)
if _0xEDA5 then
for _, p in ipairs(_0x0DC7:GetPlayers()) do
if _0xBE50(p) and not _0x77CF(p) and not _0xF664(_0x3B67, p) and not _0x65BA(p) then
local _0xB7CA = _0x53E3(p)
if _0xB7CA then
local _0x6BE2 = _0xB7CA.Position - _0xEDA5.Position
local _0x1426 = 180 / 300
local _0x82BB = math.clamp(100 + _0x6BE2.X * _0x1426, 6, 194)
local _0xFABE = math.clamp(100 + _0x6BE2.Z * _0x1426, 26, 194)
local _0xB326 = _0xC733("Frame", {
Size = UDim2.new(0, 6, 0, 6),
Position = UDim2.new(0, _0x82BB, 0, _0xFABE),
BackgroundColor3 = _0x7082.Danger,
BorderSizePixel = 0,
Parent = _0xBA2C,
})
_0xC900(_0xB326, 3)
_0x7DF4(_0xB326, _0x7082.Danger, 1, 0.5)
end
elseif _0x65BA(p) then
local _0xB7CA = _0x53E3(p)
if _0xB7CA then
local _0x6BE2 = _0xB7CA.Position - _0xEDA5.Position
local _0x1426 = 180 / 300
local _0x82BB = math.clamp(100 + _0x6BE2.X * _0x1426, 6, 194)
local _0xFABE = math.clamp(100 + _0x6BE2.Z * _0x1426, 26, 194)
local _0xB326 = _0xC733("Frame", {
Size = UDim2.new(0, 6, 0, 6),
Position = UDim2.new(0, _0x82BB, 0, _0xFABE),
BackgroundColor3 = _0x7082.AllyESP,
BorderSizePixel = 0,
Parent = _0xBA2C,
})
_0xC900(_0xB326, 3)
_0x7DF4(_0xB326, _0x7082.AllyESP, 1, 0.5)
end
end
end
end
end
end
end)
endlocal _0x6547 = {
{_0xDA0F ="Default", userId = 1},
{_0xDA0F ="Noob", userId = 261},
{_0xDA0F ="Builderman", userId = 156},
{_0xDA0F ="Shedletsky", userId = 261},
{_0xDA0F ="Pink Girl", userId = 124322466},
{_0xDA0F ="Red Ninja", userId = 19578790},
{_0xDA0F ="Black Suit", userId = 7},
}
local function _0xC055(uid)
pcall(function()
local _0xE41C = _0x0DC7:GetHumanoidDescriptionFromUserId(uid)
local _0x1BC9 = _0x4578(_0x3B67)
if _0x1BC9 and _0xE41C then _0x1BC9:ApplyDescription(_0xE41C) end
end)
end
local function _0x3A4B()
pcall(function()
local _0xE41C = _0x0DC7:GetHumanoidDescriptionFromUserId(_0x3B67.UserId)
local _0x1BC9 = _0x4578(_0x3B67)
if _0x1BC9 and _0xE41C then _0x1BC9:ApplyDescription(_0xE41C) end
end)
end
local function _0x225E()
pcall(function()
local _0x1BC9 = _0x4578(_0x3B67)
if _0x1BC9 then _0x91BA.SavedOutfit = _0x1BC9:GetAppliedDescription() end
end)
end
local function _0x97FF()
if not _0x91BA.SavedOutfit then return end
pcall(function()
local _0x1BC9 = _0x4578(_0x3B67)
if _0x1BC9 then _0x1BC9:ApplyDescription(_0x91BA.SavedOutfit) end
end)
endlocal function _0x3CB6(parent, label, pageId, _0x9B72)
local _0xE4A7 = _0xC733("TextButton", {
Size = UDim2.new(1, 0, 0, 38),
BackgroundColor3 = _0x7082.BgCard,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Text ="",
AutoButtonColor = false,
LayoutOrder = _0x9B72,
Parent = parent,
})
_0xC900(_0xE4A7, 10)
local _0xACBF = _0xC733("Frame", {
Size = UDim2.new(0, 3, 0, 0),
Position = UDim2.new(0, 0, 0.5, 0),
AnchorPoint = Vector2.new(0, 0.5),
BackgroundColor3 = _0x7082.Accent,
BorderSizePixel = 0,
Parent = _0xE4A7,
})
_0xC900(_0xACBF, 2)
local _0xD772 = _0xC733("TextLabel", {
Size = UDim2.new(1, -20, 1, 0),
Position = UDim2.new(0, 16, 0, 0),
BackgroundTransparency = 1,
Text = label,
TextColor3 = _0x7082.TextDim,
Font = Enum.Font.GothamMedium,
TextSize = 12,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = _0xE4A7,
})
local function _0x7C07(active)
if active then
_0x72EF:Create(_0xE4A7, TweenInfo.new(0.25), {BackgroundTransparency = 0.7}):Play()
_0x72EF:Create(_0xACBF, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 3, 0, 22)}):Play()
_0x72EF:Create(_0xD772, TweenInfo.new(0.2), {TextColor3 = _0x7082.Accent}):Play()
else
_0x72EF:Create(_0xE4A7, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
_0x72EF:Create(_0xACBF, TweenInfo.new(0.2), {Size = UDim2.new(0, 3, 0, 0)}):Play()
_0x72EF:Create(_0xD772, TweenInfo.new(0.2), {TextColor3 = _0x7082.TextDim}):Play()
end
end
_0xE4A7.MouseEnter:Connect(function()
if _0x1F65.CurrentPage ~= pageId then
_0x72EF:Create(_0xE4A7, TweenInfo.new(0.15), {BackgroundTransparency = 0.85}):Play()
_0x72EF:Create(_0xD772, TweenInfo.new(0.15), {TextColor3 = _0x7082.Text}):Play()
end
end)
_0xE4A7.MouseLeave:Connect(function()
if _0x1F65.CurrentPage ~= pageId then
_0x72EF:Create(_0xE4A7, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
_0x72EF:Create(_0xD772, TweenInfo.new(0.15), {TextColor3 = _0x7082.TextDim}):Play()
end
end)
_0xE4A7.MouseButton1Click:Connect(function()
_0x1F65.CurrentPage = pageId
for id, fn in pairs(_0x1F65.NavButtons) do fn(id == pageId) end
for _0xDA0F, pg in pairs(_0x1F65.Pages) do pg.frame.Visible = (_0xDA0F == pageId) end
_0x1F65.SelectedIndex = 1
end)
_0x1F65.NavButtons[pageId] = _0x7C07
_0x1F65.NavOrder[#_0x1F65.NavOrder + 1] = {_0xE4A7 = _0xE4A7, _0x1330 = pageId}
return _0xE4A7
end
local function _0x8EF5(parent, _0x9B72, text)
local _0x1BC9 = _0xC733("Frame", {
Size = UDim2.new(1, 0, 0, 26),
BackgroundTransparency = 1,
LayoutOrder = _0x9B72,
Parent = parent,
})
local _0xB326 = _0xC733("Frame", {
Size = UDim2.new(0, 6, 0, 6),
Position = UDim2.new(0, 2, 0.5, 0),
AnchorPoint = Vector2.new(0, 0.5),
BackgroundColor3 = _0x7082.Accent,
BorderSizePixel = 0,
Parent = _0x1BC9,
})
_0xC900(_0xB326, 3)
_0x7DF4(_0xB326, _0x7082.Accent2, 1, 0)
_0xC733("TextLabel", {
Size = UDim2.new(1, 0, 1, 0),
Position = UDim2.new(0, 16, 0, 0),
BackgroundTransparency = 1,
Text = string.upper(text),
TextColor3 = _0x7082.TextFaint,
Font = Enum.Font.GothamBold,
TextSize = 10,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = _0x1BC9,
})
_0xC733("Frame", {
Size = UDim2.new(1, -20, 0, 1),
Position = UDim2.new(0, 16, 1, -1),
BackgroundColor3 = _0x7082.BorderSoft,
BackgroundTransparency = 0.4,
BorderSizePixel = 0,
Parent = _0x1BC9,
})
end
local function _0xC39C(parent, _0x9B72, label, desc, getter, setter)
local _0x5537 = _0xC733("TextButton", {
Size = UDim2.new(1, 0, 0, 52),
BackgroundColor3 = _0x7082.BgCard,
BackgroundTransparency = 0.15,
BorderSizePixel = 0,
Text ="",
AutoButtonColor = false,
LayoutOrder = _0x9B72,
Parent = parent,
})
_0xC900(_0x5537, 12)
_0x7DF4(_0x5537, _0x7082.BorderSoft, 1, 0.3)
local _0x5740 = _0xC733("Frame", {
Size = UDim2.new(0, 3, 0, 28),
Position = UDim2.new(0, 14, 0.5, 0),
AnchorPoint = Vector2.new(0, 0.5),
BackgroundColor3 = getter() and _0x7082.Accent or _0x7082.TextFaint,
BorderSizePixel = 0,
Parent = _0x5537,
})
_0xC900(_0x5740, 2)
_0xC733("TextLabel", {
Size = UDim2.new(1, -100, 0, 16),
Position = UDim2.new(0, 28, 0, 8),
BackgroundTransparency = 1,
Text = label,
TextColor3 = _0x7082.Text,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = _0x5537,
})
_0xC733("TextLabel", {
Size = UDim2.new(1, -100, 0, 14),
Position = UDim2.new(0, 28, 0, 26),
BackgroundTransparency = 1,
Text = desc or"",
TextColor3 = _0x7082.TextFaint,
Font = Enum.Font.Gotham,
TextSize = 10,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = _0x5537,
})
local _0x891C = _0xC733("Frame", {
Size = UDim2.new(0, 38, 0, 20),
Position = UDim2.new(1, -52, 0.5, 0),
AnchorPoint = Vector2.new(0, 0.5),
BackgroundColor3 = getter() and _0x7082.Accent or _0x7082.Border,
BorderSizePixel = 0,
Parent = _0x5537,
})
_0xC900(_0x891C, 10)
local _0x7CF2 = _0xC733("Frame", {
Size = UDim2.new(0, 16, 0, 16),
Position = getter() and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
AnchorPoint = Vector2.new(0, 0.5),
BackgroundColor3 = Color3.new(1, 1, 1),
BorderSizePixel = 0,
Parent = _0x891C,
})
_0xC900(_0x7CF2, 8)
local function _0xF299()
local _0x5594 = getter()
_0x5740.BackgroundColor3 = _0x5594 and _0x7082.Accent or _0x7082.TextFaint
_0x72EF:Create(_0x891C, TweenInfo.new(0.2), {
BackgroundColor3 = _0x5594 and _0x7082.Accent or _0x7082.Border,
}):Play()
_0x72EF:Create(_0x7CF2, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
Position = _0x5594 and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
}):Play()
end
_0x5537.MouseEnter:Connect(function()
_0x72EF:Create(_0x5537, TweenInfo.new(0.15), {
BackgroundColor3 = _0x7082.BgCardHi,
BackgroundTransparency = 0.05,
}):Play()
end)
_0x5537.MouseLeave:Connect(function()
_0x72EF:Create(_0x5537, TweenInfo.new(0.15), {
BackgroundColor3 = _0x7082.BgCard,
BackgroundTransparency = 0.15,
}):Play()
end)
_0x5537.MouseButton1Click:Connect(function()
setter(not getter())
_0xF299()
end)
table.insert(_0x1F65.NavItems, {
_0x5537 = _0x5537,
_0xF299 = _0xF299,
setter = setter,
getter = getter,
})
return _0x5537
end
local function _0x9332(parent, _0x9B72, label, minV, maxV, getter, setter)
local _0x5537 = _0xC733("Frame", {
Size = UDim2.new(1, 0, 0, 52),
BackgroundColor3 = _0x7082.BgCard,
BackgroundTransparency = 0.15,
BorderSizePixel = 0,
LayoutOrder = _0x9B72,
Parent = parent,
})
_0xC900(_0x5537, 12)
_0x7DF4(_0x5537, _0x7082.BorderSoft, 1, 0.3)
_0xC733("TextLabel", {
Size = UDim2.new(0, 160, 0, 14),
Position = UDim2.new(0, 20, 0, 8),
BackgroundTransparency = 1,
Text = label,
TextColor3 = _0x7082.TextDim,
Font = Enum.Font.GothamBold,
TextSize = 10,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = _0x5537,
})
local _0x2EDC = _0xC733("TextLabel", {
Size = UDim2.new(0, 80, 0, 14),
Position = UDim2.new(1, -90, 0, 8),
BackgroundTransparency = 1,
Text = tostring(getter()),
TextColor3 = _0x7082.Accent,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextXAlignment = Enum.TextXAlignment.Right,
Parent = _0x5537,
})
local _0xE414 = _0xC733("Frame", {
Size = UDim2.new(1, -48, 0, 6),
Position = UDim2.new(0, 24, 0, 34),
BackgroundColor3 = _0x7082.BorderSoft,
BorderSizePixel = 0,
Parent = _0x5537,
})
_0xC900(_0xE414, 3)
local _0xC167 = math.clamp((getter() - minV) / (maxV - minV), 0, 1)
local _0x00B0 = _0xC733("Frame", {
Size = UDim2.new(_0xC167, 0, 1, 0),
BackgroundColor3 = _0x7082.Accent,
BorderSizePixel = 0,
Parent = _0xE414,
})
_0xC900(_0x00B0, 3)
local _0x7CF2 = _0xC733("Frame", {
Size = UDim2.new(0, 14, 0, 14),
Position = UDim2.new(_0xC167, 0, 0.5, 0),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = Color3.new(1, 1, 1),
BorderSizePixel = 0,
Parent = _0xE414,
})
_0xC900(_0x7CF2, 7)
_0x7DF4(_0x7CF2, _0x7082.Accent, 2, 0)
local _0xF54E = _0xC733("TextButton", {
Size = UDim2.new(1, -48, 0, 24),
Position = UDim2.new(0, 24, 0, 20),
BackgroundTransparency = 1,
Text ="",
AutoButtonColor = false,
Parent = _0x5537,
})
local _0x1623 = false
local function _0x02F7(xAbs)
local _0xA98A = _0xE414.AbsolutePosition.X
local _0x1C10 = _0xE414.AbsoluteSize.X
if _0x1C10 <= 0 then return end
local _0x96A0 = math.clamp((xAbs - _0xA98A) / _0x1C10, 0, 1)
local _0x10C0 = minV + _0x96A0 * (maxV - minV)
_0x10C0 = math.floor(_0x10C0 * 10 + 0.5) / 10
setter(_0x10C0)
_0x7CF2.Position = UDim2.new(_0x96A0, 0, 0.5, 0)
_0x00B0.Size = UDim2.new(_0x96A0, 0, 1, 0)
_0x2EDC.Text = tostring(_0x10C0)
end
_0xF54E.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then
_0x1623 = true
_0x02F7(input.Position.X)
end
end)
_0xF54E.InputChanged:Connect(function(input)
if _0x1623 and (input.UserInputType == Enum.UserInputType.MouseMovement
or input.UserInputType == Enum.UserInputType.Touch) then
_0x02F7(input.Position.X)
end
end)
_0x4D5E.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then
_0x1623 = false
end
end)
table.insert(_0x1F65.NavItems, {
_0x5537 = _0x5537,
step = function(dir)
local _0x10C0 = getter() + dir * ((maxV - minV) / 20)
_0x10C0 = math.clamp(_0x10C0, minV, maxV)
_0x10C0 = math.floor(_0x10C0 * 10 + 0.5) / 10
setter(_0x10C0)
local _0x96A0 = (_0x10C0 - minV) / (maxV - minV)
_0x7CF2.Position = UDim2.new(_0x96A0, 0, 0.5, 0)
_0x00B0.Size = UDim2.new(_0x96A0, 0, 1, 0)
_0x2EDC.Text = tostring(_0x10C0)
end,
})
return _0x5537
end
local function _0x5F09(parent, _0x9B72, label, desc, color, onClick)
local _0x5537 = _0xC733("TextButton", {
Size = UDim2.new(1, 0, 0, 52),
BackgroundColor3 = _0x7082.BgCard,
BackgroundTransparency = 0.15,
BorderSizePixel = 0,
Text ="",
AutoButtonColor = false,
LayoutOrder = _0x9B72,
Parent = parent,
})
_0xC900(_0x5537, 12)
_0x7DF4(_0x5537, _0x7082.BorderSoft, 1, 0.3)
_0xC733("Frame", {
Size = UDim2.new(0, 3, 0, 28),
Position = UDim2.new(0, 14, 0.5, 0),
AnchorPoint = Vector2.new(0, 0.5),
BackgroundColor3 = color or _0x7082.Accent,
BorderSizePixel = 0,
Parent = _0x5537,
})
_0xC733("TextLabel", {
Size = UDim2.new(1, -60, 0, 16),
Position = UDim2.new(0, 28, 0, 8),
BackgroundTransparency = 1,
Text = label,
TextColor3 = _0x7082.Text,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = _0x5537,
})
_0xC733("TextLabel", {
Size = UDim2.new(1, -60, 0, 14),
Position = UDim2.new(0, 28, 0, 26),
BackgroundTransparency = 1,
Text = desc or"",
TextColor3 = _0x7082.TextFaint,
Font = Enum.Font.Gotham,
TextSize = 10,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = _0x5537,
})
_0x5537.MouseButton1Click:Connect(onClick)
table.insert(_0x1F65.NavItems, {
_0x5537 = _0x5537,
action = function() onClick() end,
})
return _0x5537
endlocal function _0x40C3()
local _0xF67D = _0xC733("ScreenGui", {
Name ="LEOLABAKAKA",
ResetOnSpawn = false,
IgnoreGuiInset = true,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
DisplayOrder = 999,
Parent = _0x9B21,
})
_0x1F65.Gui = _0xF67D
local _0xFC28 = _0xC733("Frame", {
Size = UDim2.new(0, 0, 0, 0),
Position = UDim2.new(0.5, 0, 0.5, 0),
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundColor3 = _0x7082.BgBase,
BorderSizePixel = 0,
Active = true,
Draggable = true,
ClipsDescendants = true,
Parent = _0xF67D,
})
_0xC900(_0xFC28, 16)
_0x7DF4(_0xFC28, _0x7082.Border, 1.2, 0.2)
_0x1F65.Main = _0xFC28
local _0x3351 = _0xC733("Frame", {
Size = UDim2.new(0, 320, 1, -40),
Position = UDim2.new(1, -340, 0, 20),
BackgroundTransparency = 1,
ZIndex = 100,
Parent = _0xF67D,
})
_0xC733("UIListLayout", {
Padding = UDim.new(0, 8),
SortOrder = Enum.SortOrder.LayoutOrder,
VerticalAlignment = Enum.VerticalAlignment.Bottom,
Parent = _0x3351,
})
_0x1F65.ToastHolder = _0x3351
local _0x06ED = _0xC733("Frame", {
Size = UDim2.new(0, 210, 1, 0),
BackgroundColor3 = _0x7082.BgSide,
BackgroundTransparency = 0.2,
BorderSizePixel = 0,
ZIndex = 10,
Parent = _0xFC28,
})
_0xC900(_0x06ED, 16)
_0x7DF4(_0x06ED, _0x7082.BorderSoft, 1, 0.5)
local _0xD58D = _0xC733("Frame", {
Size = UDim2.new(1, 0, 0, 78),
BackgroundTransparency = 1,
ZIndex = 11,
Parent = _0x06ED,
})
local _0x1CAF = _0xC733("Frame", {
Size = UDim2.new(0, 42, 0, 42),
Position = UDim2.new(0, 18, 0, 18),
BackgroundColor3 = _0x7082.Accent,
BorderSizePixel = 0,
ZIndex = 12,
Parent = _0xD58D,
})
_0xC900(_0x1CAF, 12)
_0x6611(_0x1CAF, {{0, _0x7082.Accent}, {1, _0x7082.Accent2}}, 45)
_0x7DF4(_0x1CAF, _0x7082.Accent3, 1, 0.4)
_0xC733("TextLabel", {
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Text ="L",
TextColor3 = Color3.new(1, 1, 1),
Font = Enum.Font.GothamBlack,
TextSize = 22,
ZIndex = 13,
Parent = _0x1CAF,
})
_0xC733("TextLabel", {
Size = UDim2.new(1, -80, 0, 20),
Position = UDim2.new(0, 70, 0, 20),
BackgroundTransparency = 1,
Text ="leolabakaka",
TextColor3 = _0x7082.Text,
Font = Enum.Font.GothamBlack,
TextSize = 15,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 12,
Parent = _0xD58D,
})
_0xC733("TextLabel", {
Size = UDim2.new(1, -80, 0, 14),
Position = UDim2.new(0, 70, 0, 40),
BackgroundTransparency = 1,
Text ="v1 · ".. _0xDE1E,
TextColor3 = _0x7082.TextFaint,
Font = Enum.Font.Gotham,
TextSize = 10,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 12,
Parent = _0xD58D,
})
local _0x9CD2 = _0xC733("ScrollingFrame", {
Size = UDim2.new(1, -20, 1, -160),
Position = UDim2.new(0, 10, 0, 90),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ScrollBarThickness = 2,
ScrollBarImageColor3 = _0x7082.Accent,
CanvasSize = UDim2.new(0, 0, 0, 0),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
ZIndex = 12,
Parent = _0x06ED,
})
_0xC733("UIListLayout", {
Padding = UDim.new(0, 4),
SortOrder = Enum.SortOrder.LayoutOrder,
Parent = _0x9CD2,
})
local _0x081F = _0xC733("Frame", {
Size = UDim2.new(1, -230, 1, -40),
Position = UDim2.new(0, 220, 0, 20),
BackgroundTransparency = 1,
ZIndex = 15,
Parent = _0xFC28,
})
local function _0xE345(id, title)
local _0xD384 = _0xC733("ScrollingFrame", {
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ScrollBarThickness = 4,
ScrollBarImageColor3 = _0x7082.Accent,
CanvasSize = UDim2.new(0, 0, 0, 0),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
Visible = false,
ZIndex = 15,
Parent = _0x081F,
})
local _0x0BD5 = _0xC733("Frame", {
Size = UDim2.new(1, 0, 0, 34),
BackgroundTransparency = 1,
Parent = _0xD384,
})
_0xC733("TextLabel", {
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Text = title,
TextColor3 = _0x7082.Text,
Font = Enum.Font.GothamBold,
TextSize = 20,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = _0x0BD5,
})
local _0x3E23 = _0xC733("Frame", {
Size = UDim2.new(1, -20, 0, 0),
Position = UDim2.new(0, 0, 0, 44),
BackgroundTransparency = 1,
AutomaticSize = Enum.AutomaticSize.Y,
ZIndex = 16,
Parent = _0xD384,
})
_0xC733("UIListLayout", {
Padding = UDim.new(0, 8),
SortOrder = Enum.SortOrder.LayoutOrder,
Parent = _0x3E23,
})
_0x1F65.Pages[id] = {_0xBA2C = _0xD384, _0x3E23 = _0x3E23}
table.insert(_0x1F65.PageOrder, id)
return _0x3E23
end
local _0x9B72 = 0
local function _0x07D1() _0x9B72 = _0x9B72 + 1; return _0x9B72 end
_0x3CB6(_0x9CD2,"Combat","Combat", _0x07D1())
_0x3CB6(_0x9CD2,"ESP","ESP", _0x07D1())
_0x3CB6(_0x9CD2,"Rivals","Rivals", _0x07D1())
_0x3CB6(_0x9CD2,"New","New", _0x07D1())
_0x3CB6(_0x9CD2,"Outfit","Outfit", _0x07D1())
_0x3CB6(_0x9CD2,"Misc","Misc", _0x07D1())local _0xC117 = _0xE345("Combat","Combat")
local _0x830E = 0
local function _0xA655() _0x830E = _0x830E + 1; return _0x830E end
_0x8EF5(_0xC117, _0xA655(),"Aimbot")
_0xC39C(_0xC117, _0xA655(),"Aimbot","Lock tête", function() return _0x91BA.Aimbot end, function(_0x10C0) _0x91BA.Aimbot = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"Aimbot Key LMB","Clic gauche", function() return _0x91BA.AimbotKey end, function(_0x10C0) _0x91BA.AimbotKey = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"Aimbot Master U","Touche U", function() return _0x91BA.AimbotMaster end, function(_0x10C0) _0x91BA.AimbotMaster = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"Lock Full","Instantané", function() return _0x91BA.AimbotLockFull end, function(_0x10C0) _0x91BA.AimbotLockFull = _0x10C0 end)
_0x9332(_0xC117, _0xA655(),"Smooth", 0.05, 1.1, function() return _0x91BA.AimbotSmooth end, function(_0x10C0) _0x91BA.AimbotSmooth = _0x10C0 end)
_0x9332(_0xC117, _0xA655(),"FOV", 50, 1500, function() return _0x91BA.AimbotFOV end, function(_0x10C0) _0x91BA.AimbotFOV = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"Wall Check","OFF = wallbang", function() return _0x91BA.AimbotWallCheck end, function(_0x10C0) _0x91BA.AimbotWallCheck = _0x10C0 end)
_0x9332(_0xC117, _0xA655(),"Prediction", 0, 0.5, function() return _0x91BA.AimbotPrediction end, function(_0x10C0) _0x91BA.AimbotPrediction = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"FOV Circle","Cercle", function() return _0x91BA.AimbotFOVCircle end, function(_0x10C0) _0x91BA.AimbotFOVCircle = _0x10C0 end)
_0x8EF5(_0xC117, _0xA655(),"Silent Aim")
_0xC39C(_0xC117, _0xA655(),"Silent Aim","Silencieux", function() return _0x91BA.SilentAim end, function(_0x10C0) _0x91BA.SilentAim = _0x10C0 end)
_0x9332(_0xC117, _0xA655(),"Silent FOV", 100, 1500, function() return _0x91BA.SilentAimFOV end, function(_0x10C0) _0x91BA.SilentAimFOV = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"Silent Wall Check","OFF = wallbang", function() return _0x91BA.SilentAimWallCheck end, function(_0x10C0) _0x91BA.SilentAimWallCheck = _0x10C0 end)
_0x8EF5(_0xC117, _0xA655(),"Magic Bullet / Wallbang")
_0xC39C(_0xC117, _0xA655(),"Magic Bullet","Multi-angle", function() return _0x91BA.MagicBullet end, function(_0x10C0) _0x91BA.MagicBullet = _0x10C0 end)
_0x9332(_0xC117, _0xA655(),"Magic FOV", 100, 2000, function() return _0x91BA.MagicBulletFOV end, function(_0x10C0) _0x91BA.MagicBulletFOV = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"Wallbang","À travers TOUS les murs", function() return _0x91BA.MagicBulletWall end, function(_0x10C0) _0x91BA.MagicBulletWall = _0x10C0; _0x91BA.Wallbang = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"Angle Spoof","Simule LOS", function() return _0x91BA.MagicBulletAngleSpoof end, function(_0x10C0) _0x91BA.MagicBulletAngleSpoof = _0x10C0 end)
_0x9332(_0xC117, _0xA655(),"Occlusion Offset", 0, 10, function() return _0x91BA.MagicBulletOcclusion end, function(_0x10C0) _0x91BA.MagicBulletOcclusion = _0x10C0 end)
_0x9332(_0xC117, _0xA655(),"Velocity Lead", 0, 0.5, function() return _0x91BA.MagicBulletVelocityLead end, function(_0x10C0) _0x91BA.MagicBulletVelocityLead = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"Anti-Reject","Retry", function() return _0x91BA.MagicBulletAntiReject end, function(_0x10C0) _0x91BA.MagicBulletAntiReject = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"Instant Hit","Balles instantanées", function() return _0x91BA.InstantHit end, function(_0x10C0) _0x91BA.InstantHit = _0x10C0 end)
_0x8EF5(_0xC117, _0xA655(),"Armes")
_0xC39C(_0xC117, _0xA655(),"No Recoil","Sans recul", function() return _0x91BA.NoRecoil end, function(_0x10C0) _0x91BA.NoRecoil = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"No Spread","Sans spread", function() return _0x91BA.NoSpread end, function(_0x10C0) _0x91BA.NoSpread = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"No Reload","Recharge instant", function() return _0x91BA.NoReload end, function(_0x10C0) _0x91BA.NoReload = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"Rapid Fire","Tire vite", function() return _0x91BA.RapidFire end, function(_0x10C0) _0x91BA.RapidFire = _0x10C0 end)
_0x9332(_0xC117, _0xA655(),"Rapid Multi", 1, 10, function() return _0x91BA.RapidFireMulti end, function(_0x10C0) _0x91BA.RapidFireMulti = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"Infinite Ammo","Munitions ∞", function() return _0x91BA.InfiniteAmmo end, function(_0x10C0) _0x91BA.InfiniteAmmo = _0x10C0 end)
_0x8EF5(_0xC117, _0xA655(),"Auto")
_0xC39C(_0xC117, _0xA655(),"Auto Shoot","Auto tire", function() return _0x91BA.AutoShoot end, function(_0x10C0) _0x91BA.AutoShoot = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"Trigger Bot","Trigger", function() return _0x91BA.TriggerBot end, function(_0x10C0) _0x91BA.TriggerBot = _0x10C0 end)
_0x9332(_0xC117, _0xA655(),"Trigger Hit%", 0, 100, function() return _0x91BA.TriggerBotHitChance end, function(_0x10C0) _0x91BA.TriggerBotHitChance = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"Aim Assist","Assistant", function() return _0x91BA.AimAssist end, function(_0x10C0) _0x91BA.AimAssist = _0x10C0 end)
_0x8EF5(_0xC117, _0xA655(),"Hitbox Mega")
_0xC39C(_0xC117, _0xA655(),"Hitbox Expander","Agrandit", function() return _0x91BA.HitboxExpander end, function(_0x10C0) _0x91BA.HitboxExpander = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"Hitbox Mega","Max", function() return _0x91BA.HitboxMega end, function(_0x10C0) _0x91BA.HitboxMega = _0x10C0 end)
_0x9332(_0xC117, _0xA655(),"Mega Size", 4, 25, function() return _0x91BA.HitboxMegaSize end, function(_0x10C0) _0x91BA.HitboxMegaSize = _0x10C0 end)
_0xC39C(_0xC117, _0xA655(),"Invisible Hitbox","Cache", function() return _0x91BA.HitboxMegaInvisible end, function(_0x10C0) _0x91BA.HitboxMegaInvisible = _0x10C0 end)local _0x6987 = _0xE345("ESP","ESP")
_0x830E = 0
_0x8EF5(_0x6987, _0xA655(),"ESP")
_0xC39C(_0x6987, _0xA655(),"ESP Enable","ESP", function() return _0x91BA.ESP end, function(_0x10C0) _0x91BA.ESP = _0x10C0 end)
_0xC39C(_0x6987, _0xA655(),"Box","Cadre", function() return _0x91BA.ESPBox end, function(_0x10C0) _0x91BA.ESPBox = _0x10C0 end)
_0xC39C(_0x6987, _0xA655(),"Name","Nom", function() return _0x91BA.ESPName end, function(_0x10C0) _0x91BA.ESPName = _0x10C0 end)
_0xC39C(_0x6987, _0xA655(),"Health","HP", function() return _0x91BA.ESPHealth end, function(_0x10C0) _0x91BA.ESPHealth = _0x10C0 end)
_0xC39C(_0x6987, _0xA655(),"Distance","Dist", function() return _0x91BA.ESPDistance end, function(_0x10C0) _0x91BA.ESPDistance = _0x10C0 end)
_0xC39C(_0x6987, _0xA655(),"Tracer","Ligne (ennemis)", function() return _0x91BA.ESPTracer end, function(_0x10C0) _0x91BA.ESPTracer = _0x10C0 end)
_0xC39C(_0x6987, _0xA655(),"Skeleton","Squelette", function() return _0x91BA.ESPSkeleton end, function(_0x10C0) _0x91BA.ESPSkeleton = _0x10C0 end)
_0xC39C(_0x6987, _0xA655(),"Chams","Fond", function() return _0x91BA.ESPChams end, function(_0x10C0) _0x91BA.ESPChams = _0x10C0 end)
_0xC39C(_0x6987, _0xA655(),"Head Dot","Dot", function() return _0x91BA.ESPHeadDot end, function(_0x10C0) _0x91BA.ESPHeadDot = _0x10C0 end)
_0xC39C(_0x6987, _0xA655(),"Enemy Color","Rouge ennemis", function() return _0x91BA.ESPEnemyColor end, function(_0x10C0) _0x91BA.ESPEnemyColor = _0x10C0 end)
_0xC39C(_0x6987, _0xA655(),"Ally Color","Vert alliés", function() return _0x91BA.ESPAllyColor end, function(_0x10C0) _0x91BA.ESPAllyColor = _0x10C0 end)
_0xC39C(_0x6987, _0xA655(),"Rainbow","RGB ennemis", function() return _0x91BA.ESPRainbow end, function(_0x10C0) _0x91BA.ESPRainbow = _0x10C0 end)
_0xC39C(_0x6987, _0xA655(),"Team Check","Ignore alliés (si Ally Color OFF)", function() return _0x91BA.ESPTeamCheck end, function(_0x10C0) _0x91BA.ESPTeamCheck = _0x10C0 end)
_0xC39C(_0x6987, _0xA655(),"Radar","Minimap", function() return _0x91BA.Radar end, function(_0x10C0) _0x91BA.Radar = _0x10C0 end)local _0xA667 = _0xE345("Rivals","Rivals")
_0x830E = 0
_0x8EF5(_0xA667, _0xA655(),"Survival")
_0xC39C(_0xA667, _0xA655(),"Forcefield","FF visuel", function() return _0x91BA.ForcefieldLocal end, function(_0x10C0) _0x91BA.ForcefieldLocal = _0x10C0 end)
_0xC39C(_0xA667, _0xA655(),"Auto-Heal","Spam heal", function() return _0x91BA.AutoHeal end, function(_0x10C0) _0x91BA.AutoHeal = _0x10C0 end)
_0x9332(_0xA667, _0xA655(),"Heal Threshold %", 10, 100, function() return _0x91BA.AutoHealThreshold end, function(_0x10C0) _0x91BA.AutoHealThreshold = _0x10C0 end)
_0xC39C(_0xA667, _0xA655(),"Auto-Dodge","Esquive", function() return _0x91BA.AutoDodge end, function(_0x10C0) _0x91BA.AutoDodge = _0x10C0 end)
_0x9332(_0xA667, _0xA655(),"Dodge Range", 20, 200, function() return _0x91BA.AutoDodgeRange end, function(_0x10C0) _0x91BA.AutoDodgeRange = _0x10C0 end)
_0xC39C(_0xA667, _0xA655(),"Anti-Katana","Anti deflect", function() return _0x91BA.AntiKatana end, function(_0x10C0) _0x91BA.AntiKatana = _0x10C0 end)
_0xC39C(_0xA667, _0xA655(),"Adonis Bypass","Anti-cheat", function() return _0x91BA.AdonisBypass end, function(_0x10C0) _0x91BA.AdonisBypass = _0x10C0 end)
_0xC39C(_0xA667, _0xA655(),"No Killcam","Pas killcam", function() return _0x91BA.NoKillcam end, function(_0x10C0) _0x91BA.NoKillcam = _0x10C0 end)
_0xC39C(_0xA667, _0xA655(),"No Flash","Pas flash", function() return _0x91BA.NoFlash end, function(_0x10C0) _0x91BA.NoFlash = _0x10C0 end)
_0xC39C(_0xA667, _0xA655(),"No Fog","Pas brouillard", function() return _0x91BA.NoFog end, function(_0x10C0) _0x91BA.NoFog = _0x10C0 end)
_0x8EF5(_0xA667, _0xA655(),"Feedback")
_0xC39C(_0xA667, _0xA655(),"Hit Sound","Son hit", function() return _0x91BA.HitSound end, function(_0x10C0) _0x91BA.HitSound = _0x10C0 end)
_0xC39C(_0xA667, _0xA655(),"Kill Sound","Son kill", function() return _0x91BA.KillSound end, function(_0x10C0) _0x91BA.KillSound = _0x10C0 end)
_0xC39C(_0xA667, _0xA655(),"Hit Marker","Croix", function() return _0x91BA.HitMarker end, function(_0x10C0) _0x91BA.HitMarker = _0x10C0 end)
_0xC39C(_0xA667, _0xA655(),"Damage Indicator","Dégâts", function() return _0x91BA.DamageIndicator end, function(_0x10C0) _0x91BA.DamageIndicator = _0x10C0 end)
_0xC39C(_0xA667, _0xA655(),"Kill Effect","Particules", function() return _0x91BA.KillEffect end, function(_0x10C0) _0x91BA.KillEffect = _0x10C0 end)local _0x8871 = _0xE345("New","New")
_0x830E = 0
_0x8EF5(_0x8871, _0xA655(),"Invisibilité (Y)")
_0xC39C(_0x8871, _0xA655(),"Invisibilité","Touche Y", function() return _0x91BA.Invisible end,
function(_0x10C0) _0x91BA.Invisible = _0x10C0; _0xA0E7(_0x10C0) end)
_0x8EF5(_0x8871, _0xA655(),"Infinite Jump (I)")
_0xC39C(_0x8871, _0xA655(),"Infinite Jump","Touche I", function() return _0x91BA.InfJump end, function(_0x10C0) _0x91BA.InfJump = _0x10C0 end)
_0x8EF5(_0x8871, _0xA655(),"Speed Boost")
_0xC39C(_0x8871, _0xA655(),"Speed Boost","48 vitesse", function() return _0x91BA.SpeedBoost end,
function(_0x10C0) _0x91BA.SpeedBoost = _0x10C0; _0x6698(_0x10C0) end)
_0x8EF5(_0x8871, _0xA655(),"Select (N)")
_0xC39C(_0x8871, _0xA655(),"Select","Touche N", function() return _0x91BA.SelectActive end, function(_0x10C0) _0x8DC5(_0x10C0) end)
_0x8EF5(_0x8871, _0xA655(),"Fall Player (B)")
_0xC39C(_0x8871, _0xA655(),"Fall Player","Touche B", function() return _0x91BA.FallPlayer end, function(_0x10C0) _0xD45F(_0x10C0) end)
_0x9332(_0x8871, _0xA655(),"Distance", 2, 15, function() return _0x91BA.FallDistance end, function(_0x10C0) _0x91BA.FallDistance = _0x10C0 end)
_0x5F09(_0x8871, _0xA655(),"Reset Fall (C)","Force reset", _0x7082.Danger, function() _0xFBC8() end)local _0x5BC2 = _0xE345("Outfit","Outfit")
_0x830E = 0
_0x8EF5(_0x5BC2, _0xA655(),"Tenues")
for _, out in ipairs(_0x6547) do
_0x5F09(_0x5BC2, _0xA655(), out.name,"Appliquer", _0x7082.Accent, function() _0xC055(out.userId) end)
end
_0x8EF5(_0x5BC2, _0xA655(),"Sauvegarde")
_0x5F09(_0x5BC2, _0xA655(),"Save tenue","Sauvegarde", _0x7082.Success, function() _0x225E() end)
_0x5F09(_0x5BC2, _0xA655(),"Load tenue","Charge", _0x7082.Warn, function() _0x97FF() end)
_0x5F09(_0x5BC2, _0xA655(),"Reset tenue","Reset", _0x7082.Danger, function() _0x3A4B() end)local _0x2BC7 = _0xE345("Misc","Misc")
_0x830E = 0
_0x8EF5(_0x2BC7, _0xA655(),"Vision")
_0xC39C(_0x2BC7, _0xA655(),"FOV Changer","Modifie FOV", function() return _0x91BA.FOVChanger end, function(_0x10C0) _0x91BA.FOVChanger = _0x10C0 end)
_0x9332(_0x2BC7, _0xA655(),"FOV Value", 30, 160, function() return _0x91BA.FOVValue end, function(_0x10C0) _0x91BA.FOVValue = _0x10C0 end)
_0xC39C(_0x2BC7, _0xA655(),"Third Person","3e personne", function() return _0x91BA.ThirdPerson end, function(_0x10C0) _0x91BA.ThirdPerson = _0x10C0 end)
_0x9332(_0x2BC7, _0xA655(),"3P Distance", 4, 30, function() return _0x91BA.ThirdPersonDist end, function(_0x10C0) _0x91BA.ThirdPersonDist = _0x10C0 end)
_0x8EF5(_0x2BC7, _0xA655(),"Movement")
_0xC39C(_0x2BC7, _0xA655(),"Speed Hack","Speed", function() return _0x91BA.SpeedHack end, function(_0x10C0) _0x91BA.SpeedHack = _0x10C0 end)
_0x9332(_0x2BC7, _0xA655(),"Speed Value", 16, 200, function() return _0x91BA.SpeedValue end, function(_0x10C0) _0x91BA.SpeedValue = _0x10C0 end)
_0xC39C(_0x2BC7, _0xA655(),"Infinite Jump","Jump ∞", function() return _0x91BA.InfJump end, function(_0x10C0) _0x91BA.InfJump = _0x10C0 end)
_0xC39C(_0x2BC7, _0xA655(),"No Clip","Traverse murs", function() return _0x91BA.Noclip end, function(_0x10C0) _0x91BA.Noclip = _0x10C0 end)
_0xC39C(_0x2BC7, _0xA655(),"Bunny Hop","Bhop", function() return _0x91BA.BunnyHop end, function(_0x10C0) _0x91BA.BunnyHop = _0x10C0 end)
_0xC39C(_0x2BC7, _0xA655(),"Silent Walk","Pas silencieux", function() return _0x91BA.SilentWalk end, function(_0x10C0) _0x91BA.SilentWalk = _0x10C0 end)
_0x8EF5(_0x2BC7, _0xA655(),"Util")
_0xC39C(_0x2BC7, _0xA655(),"Anti-AFK","Anti kick", function() return _0x91BA.AntiAFK end, function(_0x10C0) _0x91BA.AntiAFK = _0x10C0 end)
_0xC39C(_0x2BC7, _0xA655(),"Anti-Void","Anti vide", function() return _0x91BA.AntiVoid end, function(_0x10C0) _0x91BA.AntiVoid = _0x10C0 end)
_0xC39C(_0x2BC7, _0xA655(),"Auto Pickup","Ramasser", function() return _0x91BA.AutoPickup end, function(_0x10C0) _0x91BA.AutoPickup = _0x10C0 end)
_0xC39C(_0x2BC7, _0xA655(),"Auto Reload","Recharge", function() return _0x91BA.AutoReload end, function(_0x10C0) _0x91BA.AutoReload = _0x10C0 end)
_0xC39C(_0x2BC7, _0xA655(),"Auto Equip Best","Meilleure arme", function() return _0x91BA.AutoEquipBest end, function(_0x10C0) _0x91BA.AutoEquipBest = _0x10C0 end)
_0xC39C(_0x2BC7, _0xA655(),"FPS Unlocker","FPS ∞", function() return _0x91BA.FPSUnlocker end, function(_0x10C0) _0x91BA.FPSUnlocker = _0x10C0 end)
_0x8EF5(_0x2BC7, _0xA655(),"Info")
_0x5F09(_0x2BC7, _0xA655(),"Destroy Menu","Supprime", _0x7082.Danger, function()
if _0x1F65.Gui then _0x1F65.Gui:Destroy() end
if _0xE7DB.RadarGui then _0xE7DB.RadarGui:Destroy() end
if _0xE7DB.FOVCircle then _0xE7DB.FOVCircle:Remove() end
if _0xA305 then _0xA305:Destroy() end
end)_0x1F65.CurrentPage ="Combat"for id, fn in pairs(_0x1F65.NavButtons) do fn(id =="Combat") end
for _0xDA0F, pg in pairs(_0x1F65.Pages) do pg.frame.Visible = (_0xDA0F =="Combat") end
_0xFC28.Size = UDim2.new(0, 0, 0, 0)
_0x72EF:Create(_0xFC28, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
Size = UDim2.new(0, 900, 0, 560),
}):Play()
endlocal function _0xCC2B()
for _0xBE38, _0x6266 in ipairs(_0x1F65.NavItems) do
if _0x6266.card then
if _0xBE38 == _0x1F65.SelectedIndex then
_0x6266.card.BackgroundColor3 = _0x7082.BgHover
_0x6266.card.BackgroundTransparency = 0.05
local _0x3DEB = _0x6266.card:FindFirstChildOfClass("UIStroke")
if _0x3DEB then
_0x3DEB.Color = _0x7082.Accent
_0x3DEB.Transparency = 0.2
end
else
_0x6266.card.BackgroundColor3 = _0x7082.BgCard
_0x6266.card.BackgroundTransparency = 0.15
local _0x3DEB = _0x6266.card:FindFirstChildOfClass("UIStroke")
if _0x3DEB then
_0x3DEB.Color = _0x7082.BorderSoft
_0x3DEB.Transparency = 0.3
end
end
end
end
end
local function _0xBB9B()
for _, _0x6266 in ipairs(_0x1F65.NavItems) do
if _0x6266.refresh then
pcall(function() _0x6266.refresh() end)
end
end
end
local function _0x0BA0()
local _0x1884 = {}
local _0x1330 = _0x1F65.Pages[_0x1F65.CurrentPage]
if not _0x1330 then return _0x1884 end
for _, _0x6266 in ipairs(_0x1F65.NavItems) do
if _0x6266.card and _0x6266.card.Parent == _0x1330.list then
_0x1884[#_0x1884 + 1] = _0x6266
end
end
return _0x1884
end
local function _0xB078()
local _0x1884 = _0x0BA0()
if #_0x1884 == 0 then return end
local _0x9FA2 = _0x1F65.NavItems[_0x1F65.SelectedIndex]
local _0xE5CE = 1
for _0xBE38, _0x597E in ipairs(_0x1884) do
if _0x597E == _0x9FA2 then _0xE5CE = _0xBE38; break end
end
_0xE5CE = math.max(1, _0xE5CE - 1)
for _0xBE38, _0x597E in ipairs(_0x1F65.NavItems) do
if _0x597E == _0x1884[_0xE5CE] then
_0x1F65.SelectedIndex = _0xBE38
break
end
end
_0xCC2B()
end
local function _0xCCE5()
local _0x1884 = _0x0BA0()
if #_0x1884 == 0 then return end
local _0x9FA2 = _0x1F65.NavItems[_0x1F65.SelectedIndex]
local _0xE5CE = 1
for _0xBE38, _0x597E in ipairs(_0x1884) do
if _0x597E == _0x9FA2 then _0xE5CE = _0xBE38; break end
end
_0xE5CE = math.min(#_0x1884, _0xE5CE + 1)
for _0xBE38, _0x597E in ipairs(_0x1F65.NavItems) do
if _0x597E == _0x1884[_0xE5CE] then
_0x1F65.SelectedIndex = _0xBE38
break
end
end
_0xCC2B()
end
local function _0xC770()
local _0x6266 = _0x1F65.NavItems[_0x1F65.SelectedIndex]
if not _0x6266 then return end
if _0x6266.setter and _0x6266.getter then
_0x6266.setter(not _0x6266.getter())
if _0x6266.refresh then _0x6266.refresh() end
elseif _0x6266.action then
pcall(_0x6266.action)
end
end
local function _0x78BD(dir)
local _0x6266 = _0x1F65.NavItems[_0x1F65.SelectedIndex]
if not _0x6266 then return end
if _0x6266.step then
pcall(_0x6266.step, dir)
end
end
local function _0x87CA()
local _0xE5CE = 1
for _0xBE38, id in ipairs(_0x1F65.PageOrder) do
if id == _0x1F65.CurrentPage then _0xE5CE = _0xBE38; break end
end
_0xE5CE = _0xE5CE + 1
if _0xE5CE > #_0x1F65.PageOrder then _0xE5CE = 1 end
_0x1F65.CurrentPage = _0x1F65.PageOrder[_0xE5CE]
for id, fn in pairs(_0x1F65.NavButtons) do fn(id == _0x1F65.CurrentPage) end
for _0xDA0F, pg in pairs(_0x1F65.Pages) do pg.frame.Visible = (_0xDA0F == _0x1F65.CurrentPage) end
_0x1F65.SelectedIndex = 1
_0xCC2B()
end
local function _0x5EFF()
local _0xE5CE = 1
for _0xBE38, id in ipairs(_0x1F65.PageOrder) do
if id == _0x1F65.CurrentPage then _0xE5CE = _0xBE38; break end
end
_0xE5CE = _0xE5CE - 1
if _0xE5CE < 1 then _0xE5CE = #_0x1F65.PageOrder end
_0x1F65.CurrentPage = _0x1F65.PageOrder[_0xE5CE]
for id, fn in pairs(_0x1F65.NavButtons) do fn(id == _0x1F65.CurrentPage) end
for _0xDA0F, pg in pairs(_0x1F65.Pages) do pg.frame.Visible = (_0xDA0F == _0x1F65.CurrentPage) end
_0x1F65.SelectedIndex = 1
_0xCC2B()
end_0x4D5E.InputBegan:Connect(function(input, gp)
if gp then return end
if input.KeyCode == Enum.KeyCode.Y then
_0x91BA.Invisible = not _0x91BA.Invisible
_0xA0E7(_0x91BA.Invisible)
_0xBB9B()
return
end
if input.KeyCode == Enum.KeyCode.I then
_0x91BA.InfJump = not _0x91BA.InfJump
_0xBB9B()
return
end
if input.KeyCode == Enum.KeyCode.N then
_0x8DC5(not _0x91BA.SelectActive)
_0xBB9B()
return
end
if input.KeyCode == Enum.KeyCode.B then
_0xD45F(not _0x91BA.FallPlayer)
_0xBB9B()
return
end
if input.KeyCode == Enum.KeyCode.C then
_0xFBC8()
_0xBB9B()
return
end
if input.KeyCode == Enum.KeyCode.U then
_0x91BA.AimbotMaster = not _0x91BA.AimbotMaster
_0xBB9B()
return
end
if input.KeyCode == Enum.KeyCode.RightShift then
_0x1F65.Visible = not _0x1F65.Visible
if _0x1F65.Main then
if _0x1F65.Visible then
_0x1F65.Main.Visible = true
_0x1F65.Main.Size = UDim2.new(0, 0, 0, 0)
_0x72EF:Create(_0x1F65.Main, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
Size = UDim2.new(0, 900, 0, 560),
}):Play()
else
local _0x1C10 = _0x72EF:Create(_0x1F65.Main, TweenInfo.new(0.2), {
Size = UDim2.new(0, 0, 0, 0),
})
_0x1C10:Play()
_0x1C10.Completed:Connect(function()
if _0x1F65.Main then _0x1F65.Main.Visible = false end
end)
end
end
return
end
if not _0x1F65.Visible then return end
if input.KeyCode == Enum.KeyCode.Up then
_0xB078()
elseif input.KeyCode == Enum.KeyCode.Down then
_0xCCE5()
elseif input.KeyCode == Enum.KeyCode.Left then
_0x78BD(-1)
elseif input.KeyCode == Enum.KeyCode.Right then
_0x78BD(1)
elseif input.KeyCode == Enum.KeyCode.Return or input.KeyCode == Enum.KeyCode.KeypadEnter then
_0xC770()
elseif input.KeyCode == Enum.KeyCode.Space then
_0xC770()
elseif input.KeyCode == Enum.KeyCode.Backspace then
_0x1F65.CurrentPage ="Combat"for id, fn in pairs(_0x1F65.NavButtons) do fn(id =="Combat") end
for _0xDA0F, pg in pairs(_0x1F65.Pages) do pg.frame.Visible = (_0xDA0F =="Combat") end
_0x1F65.SelectedIndex = 1
_0xCC2B()
elseif input.KeyCode == Enum.KeyCode.Q then
_0x5EFF()
elseif input.KeyCode == Enum.KeyCode.E then
_0x87CA()
end
end)_0x3B67.CharacterAdded:Connect(function()
task.wait(0.5)
_0x38A3 = nil
_0xD326 = nil
_0x6B87 = nil
_0x91BA.AimbotLockedTarget = nil
if _0x8409.isInvisible then
_0x8409.isInvisible = false
_0x91BA.Invisible = false
if _0x8409.invisChair then
pcall(function() _0x8409.invisChair:Destroy() end)
_0x8409.invisChair = nil
end
local _0x7FB1 = workspace:FindFirstChild("invischair")
if _0x7FB1 then pcall(function() _0x7FB1:Destroy() end) end
end
if _0x8409.isSpeedBoosted then
_0x8409.isSpeedBoosted = false
_0x91BA.SpeedBoost = false
end
_0xB76C.lastSide = 0
_0xB76C.currentSide = 1
if _0xB76C.active or _0x2868 then
_0xB76C.generation = _0xB76C.generation + 1
_0x2577()
_0x91BA.FallPlayer = false
end
_0xEA9F()
_0x9A67()
end)
_0x0DC7.PlayerRemoving:Connect(function(plr)
if _0xB76C.target == plr then _0xB76C.target = nil end
if _0x59E0.allies[plr.Name] then _0x59E0.allies[plr.Name] = nil end
if _0x59E0.alliesIds[plr.UserId] then _0x59E0.alliesIds[plr.UserId] = nil end
if _0x91BA.AimbotLockedTarget == plr then
_0x91BA.AimbotLockedTarget = nil
_0x38A3 = nil
end
_0xC491(plr)
end)pcall(function()
for _, _0xDA0F in ipairs({"LEOLABAKAKA","ZRXProject","ZeyProject","ZRXRadar","ZeyRadar","LEOLABAKAKA_Radar","LEOLABAKAKA_HitMarkers","VRivMenu","VRivRadar",
}) do
local _0xB1BC = _0x9B21:FindFirstChild(_0xDA0F)
if _0xB1BC then _0xB1BC:Destroy() end
end
end)
_0x8367()
_0x40C3()
_0xCC2B()
pcall(function()
_0xCDE1:SetCore("SendNotification", {
Title ="leolabakaka",
Text ="Y inv · I jump · N select · B fall · C reset · RShift menu · Flèches nav",
Duration = 7,
})
end)
_0x6EA0("leolabakaka chargé","Wallbang ON · Flèches pour naviguer · RShift menu", _0x7082.Success)
