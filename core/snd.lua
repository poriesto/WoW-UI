local addon, ns = ...
local cfg = ns.cfg
local lastX =  cfg.tracker.x;
local lastY = cfg.tracker.y;
local br = 0;
local bl = {}
local function clear( ... )
	-- body
	bl = {};
	br = 0;
	lastX = cfg.tracker.x;
	lastY = cfg.tracker.y;
end

local function check()
	-- body
	bl = {}
	br = 0
	local spec = GetSpecialization()
	local specID = spec and select(1, GetSpecializationInfo(spec)) or 0
	if specID == 259 then
		bl = {114015, 73651, 32645};
	elseif specID == 261 then
		bl = {114015, 5171, 73651, 51713, 31223}
	elseif specID == 260 then
		bl = {114015, 5171, 73651, 84745, 84746, 84747, 13750, 13877} 	
	end
end

local function blTrack( ... )
	clear();
	check();
	for i,s in ipairs(bl) do
		local f = CreateFrame("Cooldown", nil, PlayerFrame, "CooldownFrameTemplate")
		f:SetFrameLevel(PlayerFrame:GetFrameLevel() + 4)
		f:SetDrawEdge(false)
		f:ClearAllPoints()
		if br > 3 then
			lastY = lastY - cfg.tracker.size;
			br = 0;
			lastX = cfg.tracker.x;
		end
		f:SetPoint(cfg.tracker.anch, nil, cfg.tracker.anch, lastX, lastY)
		
		f:SetSize(cfg.tracker.size, cfg.tracker.size)
		f.Icon = CreateFrame("Frame", nil, f)
		f.Icon:SetFrameLevel(f:GetFrameLevel() - 1)
		f.Icon:SetAllPoints()
		f.Icon.Texture = f.Icon:CreateTexture(nil, "ARTWORK")
		f.Icon.Texture:SetPoint("TOPLEFT", -1, 2)
		f.Icon.Texture:SetSize(cfg.tracker.size, cfg.tracker.size)
		f.text = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
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
			local count = select(4, UnitBuff("player", spellname))
			
			if id and unitCaster == "player" then
				f:Show()
				f:SetCooldown(expirationTime - duration - 0.5, duration)
				if count > 0 then
					f.text:SetPoint("TOPLEFT",0,0);
					f.text:SetText(count);
				else 
					f.text:SetPoint("TOPLEFT",0,0);
					f.text:SetText(nil);
				end
				return
			end
			f:Hide()
		end
		
		--some hardcode for rogue
		if s == 84745 or s == 84746 then
			lastX = lastX;
			br = br;
		else
			lastX = lastX + cfg.tracker.size;
			br = br + 1;
		end
	end
	clear();
end

local Btracker = CreateFrame("Frame")
Btracker:RegisterEvent("PLAYER_ENTER_COMBAT");
Btracker:SetScript("OnEvent", blTrack);
