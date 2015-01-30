local addon, ns = ...
local cfg = ns.cfg

local dl={408,703,1833,84617,1943,91023,16511,}
local lastX = cfg.dbtracker.x;

for i,s in ipairs(dl) do
	local f = CreateFrame("Cooldown", nil, TargetFrame, "CooldownFrameTemplate")
	f:SetFrameLevel(TargetFrame:GetFrameLevel() + 4)
	f:SetDrawEdge(false)
	f:ClearAllPoints()

	f:SetPoint(cfg.dbtracker.anch, "TargetFrame", cfg.dbtracker.anch, lastX, cfg.dbtracker.y)
	f:SetSize(cfg.dbtracker.size, cfg.dbtracker.size)
	f.Icon = CreateFrame("Frame", nil, f)
	f.Icon:SetFrameLevel(f:GetFrameLevel() - 1)
	f.Icon:SetAllPoints()
	f.Icon.Texture = f.Icon:CreateTexture(nil, "ARTWORK")
	f.Icon.Texture:SetPoint("TOPLEFT", -1, 2)
	f.Icon.Texture:SetSize(cfg.dbtracker.size, cfg.dbtracker.size)
	SetPortraitToTexture(f.Icon.Texture, select(3, GetSpellInfo(s)))

	f:RegisterEvent("UNIT_AURA")
	f:SetScript("OnEvent", function(self, event, unit)
	f.CheckAura(unit)
	end)
	function f.CheckAura(unit)
		local spellname = GetSpellInfo(s)
		local _, _, _, _, _, duration, expirationTime, unitCaster, _, _, id = UnitDebuff("target", spellname)
		if id and unitCaster == "player" then
			f:Show()
			f:SetCooldown(expirationTime - duration - 0.5, duration)
		return
	end
	f:Hide()
	end
	lastX = lastX + cfg.dbtracker.size + 2;
end
