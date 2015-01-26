local addon, ns = ...
local cfg = ns.cfg

local bl={114015,5171,73651,5277,114018,84745, 84746, 84747, 13750, 13877,51713,31223,32645,}
local lastX =  cfg.tracker.x;

for i,s in ipairs(bl) do
	local f = CreateFrame("Cooldown", nil, PlayerFrame, "CooldownFrameTemplate")
	f:SetFrameLevel(PlayerFrame:GetFrameLevel() + 4)
	f:SetDrawEdge(false)
	f:ClearAllPoints()
	
	f:SetPoint(cfg.tracker.anch, "PlayerFrame", cfg.tracker.anch, lastX, cfg.tracker.y)
	
	f:SetSize(cfg.tracker.size, cfg.tracker.size)
	f.Icon = CreateFrame("Frame", nil, f)
	f.Icon:SetFrameLevel(f:GetFrameLevel() - 1)
	f.Icon:SetAllPoints()
	f.Icon.Texture = f.Icon:CreateTexture(nil, "ARTWORK")
	f.Icon.Texture:SetPoint("TOPLEFT", -1, 2)
	f.Icon.Texture:SetSize(cfg.tracker.size, cfg.tracker.size)
	SetPortraitToTexture(f.Icon.Texture, select(3, GetSpellInfo(s)))
	f.Icon.Border = CreateFrame("Frame", nil, f.Icon)
	f.Icon.Border:SetFrameLevel(f:GetFrameLevel() + 1)
	f.Icon.Border:SetAllPoints()
	f.Icon.Border.Texture = f.Icon.Border:CreateTexture(nil, "ARTWORK")
	f.Icon.Border.Texture:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	if IsAddOnLoaded("Lorti UI") then
	f.Icon.Border.Texture:SetVertexColor(.05,.05,.05)
	end
	f.Icon.Border.Texture:SetPoint("TOPLEFT", -7, 7)
	f.Icon.Border.Texture:SetSize(63,63)

	f:RegisterEvent("UNIT_AURA")
	f:SetScript("OnEvent", function(self, event, unit)
	f.CheckAura(unit)
	end)
	function f.CheckAura(unit)
		local spellname = GetSpellInfo(s)
		local _, _, _, _, _, duration, expirationTime, unitCaster, _, _, id = UnitBuff("player", spellname)
		if id and unitCaster == "player" then
			f:Show()
			f:SetCooldown(expirationTime - duration - 0.5, duration)
		return
	end
	f:Hide()
	end
	lastX = lastX + cfg.tracker.size + 2;
end
