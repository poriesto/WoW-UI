local addon, ns = ...
local cfg = ns.cfg
local lastX =  cfg.dbtracker.x;
local lastY = cfg.dbtracker.y;
local dr = 0;
local db = {1943, 84617, 91021};
for i,s in ipairs(db) do 
	print(s);
end
local function blTrack( ... )
	for i,s in ipairs(db) do
		print(s);
		local f = CreateFrame("Cooldown", nil, PlayerFrame, "CooldownFrameTemplate")
		f:SetFrameLevel(PlayerFrame:GetFrameLevel() + 4)
		f:SetDrawEdge(false)
		f:ClearAllPoints()
		if dr > 3 then
			lastY = lastY - cfg.dbtracker.size;
			br = 0;
			lastX = cfg.dbtracker.x;
		end
		f:SetPoint(cfg.dbtracker.anch, nil, cfg.dbtracker.anch, lastX, lastY)
		
		f:SetSize(cfg.dbtracker.size, cfg.dbtracker.size)
		f.Icon = CreateFrame("Frame", nil, f)
		f.Icon:SetFrameLevel(f:GetFrameLevel() - 1)
		f.Icon:SetAllPoints()
		f.Icon.Texture = f.Icon:CreateTexture(nil, "ARTWORK")
		f.Icon.Texture:SetPoint("TOPLEFT", -1, 2)
		f.Icon.Texture:SetSize(cfg.dbtracker.size, cfg.dbtracker.size)
		f.text = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		SetPortraitToTexture(f.Icon.Texture, select(3, GetSpellInfo(s)))

		f:RegisterEvent("UNIT_AURA")
		f:SetScript("OnEvent", function(self, event, unit)
		f.CheckAura(unit)
		end)
		
		function f.CheckAura(unit)
			local spellname = GetSpellInfo(s)
			local duration = select(6, UnitDebuff("target", spellname))
			local expirationTime = select(7,UnitDebuff("target", spellname))
			local unitCaster = select(8, UnitDebuff("target", spellname))
			local id = select(11, UnitDebuff("target",spellname))
			local count = select(4, UnitDebuff("target", spellname))
			
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
		lastX = lastX - cfg.dbtracker.size;
		br = br + 1;
	end
end

local Btracker = CreateFrame("Frame")
Btracker:RegisterEvent("PLAYER_ENTER_COMBAT");
Btracker:SetScript("OnEvent", blTrack);
