local addon, ns = ...
local cfg = ns.cfg
local lastX =  cfg.tracker.x;
local bl = {}

local function check()
	-- body
	bl = {}
	lastX = cfg.tracker.x
	local spec = GetSpecialization()
	print(GetSpecializationInfo(spec));
	local specID = spec and select(1, GetSpecializationInfo(spec)) or 0
	if specID == 259 then
		bl = {114015, 73651, 32645};
	elseif specID == 261 then
		bl = {114015, 5171, 73651, 51713, 31223}
	else
		bl = {114015, 5171, 73651, 84745, 84746, 84747, 13750, 13877} 	
	end
	for i,s in ipairs(bl) do
		print(s);
	end
end
local function blTrack( ... )
	-- body
	for i,s in ipairs(bl) do
	local f = CreateFrame("Cooldown", nil, PlayerFrame, "CooldownFrameTemplate")
	f:SetFrameLevel(PlayerFrame:GetFrameLevel() + 4)
	f:SetDrawEdge(false)
	f:ClearAllPoints()
	f:SetPoint(cfg.tracker.anch, "PlayerFrame", cfg.tracker.anch, lastX, cfg.tracker.y)
	print(s)
	f:SetSize(cfg.tracker.size, cfg.tracker.size)
	f.Icon = CreateFrame("Frame", nil, f)
	f.Icon:SetFrameLevel(f:GetFrameLevel() - 1)
	f.Icon:SetAllPoints()
	f.Icon.Texture = f.Icon:CreateTexture(nil, "ARTWORK")
	f.Icon.Texture:SetPoint("TOPLEFT", -1, 2)
	f.Icon.Texture:SetSize(cfg.tracker.size, cfg.tracker.size)
	SetPortraitToTexture(f.Icon.Texture, select(3, GetSpellInfo(s)))

	f:RegisterEvent("UNIT_AURA")
	f:SetScript("OnEvent", function(self, event, unit)
	f.CheckAura(unit)
	end)
	function f.CheckAura(unit)
		local spellname = GetSpellInfo(s)
		local duration = select(6, UnitBuff("player", spellname))
		local expirationTime = select(7,UnitBuff("player", spellname))
		local unitCaster = select(8, UnitBuff("player", spellname))
		local id = select(11, UnitBuff("player",spellname))
		if id and unitCaster == "player" then
			f:Show()
			f:SetCooldown(expirationTime - duration - 0.5, duration)
		return
	end
	f:Hide()
	end
	--some hardcode for rogue
	if s == 84745 or s == 84746 then
		lastX = lastX;
	else
		lastX = lastX + (cfg.tracker.size + 2);
	end
end
end

local checkSpec = CreateFrame("Frame")
checkSpec:RegisterEvent("PLAYER_ENTERING_WORLD")
checkSpec:SetScript("OnEvent", check)
--checkSpec:UnregisterEvent("PLAYER_ENTERING_WORLD")
--checkSpec:SetScript("OnEvent", nil)
checkSpec:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
checkSpec:SetScript("OnEvent", check);

local Btracker = CreateFrame("Frame")
Btracker:RegisterEvent("PLAYER_ENTER_COMBAT")
Btracker:SetScript("OnEvent", blTrack);