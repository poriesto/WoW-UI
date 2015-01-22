-- snd tracker
local snd = CreateFrame("Cooldown", nil, PlayerFrame, "CooldownFrameTemplate")
snd:SetFrameLevel(PlayerFrame:GetFrameLevel() + 4)
snd:SetDrawEdge(false)
snd:ClearAllPoints()
snd:SetPoint("TOPLEFT", "PlayerFrame", "TOPLEFT", 39, -8)
snd:SetSize(22,22)
snd.Icon = CreateFrame("Frame", nil, snd)
snd.Icon:SetFrameLevel(snd:GetFrameLevel() - 1)
snd.Icon:SetAllPoints()
snd.Icon.Texture = snd.Icon:CreateTexture(nil, "ARTWORK")
snd.Icon.Texture:SetPoint("TOPLEFT", -1, 2)
snd.Icon.Texture:SetSize(24,24)
SetPortraitToTexture(snd.Icon.Texture, select(3, GetSpellInfo(5171)))
snd.Icon.Border = CreateFrame("Frame", nil, snd.Icon)
snd.Icon.Border:SetFrameLevel(snd:GetFrameLevel() + 1)
snd.Icon.Border:SetAllPoints()
snd.Icon.Border.Texture = snd.Icon.Border:CreateTexture(nil, "ARTWORK")
snd.Icon.Border.Texture:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
if IsAddOnLoaded("Lorti UI") then
snd.Icon.Border.Texture:SetVertexColor(.05,.05,.05)
end
snd.Icon.Border.Texture:SetPoint("TOPLEFT", -7, 7)
snd.Icon.Border.Texture:SetSize(63,63)

snd:RegisterEvent("UNIT_AURA")
snd:SetScript("OnEvent", function(self, event, unit)
snd.CheckAura(unit)
end)
function snd.CheckAura(unit)
local spellname = GetSpellInfo(5171)
local _, _, _, _, _, duration, expirationTime, unitCaster, _, _, id = UnitBuff("player", spellname)
if id and unitCaster == "player" then
snd:Show()
snd:SetCooldown(expirationTime - duration - 0.5, duration)
PlayerPVPTimerText:SetAlpha(0)
return
end
snd:Hide()
PlayerPVPTimerText:SetAlpha(1)
end
-- recuperate tracker
local recup = CreateFrame("Cooldown", nil, PlayerFrame, "CooldownFrameTemplate")
recup:SetFrameLevel(PlayerFrame:GetFrameLevel() + 4)
recup:SetDrawEdge(false)
recup:ClearAllPoints()
recup:SetPoint("TOPLEFT", "PlayerFrame", "TOPLEFT", 89, -8)
recup:SetSize(22,22)
recup.Icon = CreateFrame("Frame", nil, recup)
recup.Icon:SetFrameLevel(recup:GetFrameLevel() - 1)
recup.Icon:SetAllPoints()
recup.Icon.Texture = recup.Icon:CreateTexture(nil, "ARTWORK")
recup.Icon.Texture:SetPoint("TOPLEFT", -1, 2)
recup.Icon.Texture:SetSize(24,24)
SetPortraitToTexture(recup.Icon.Texture, select(3, GetSpellInfo(73651)))
recup.Icon.Border = CreateFrame("Frame", nil, recup.Icon)
recup.Icon.Border:SetFrameLevel(recup:GetFrameLevel() + 1)
recup.Icon.Border:SetAllPoints()
recup.Icon.Border.Texture = recup.Icon.Border:CreateTexture(nil, "ARTWORK")
recup.Icon.Border.Texture:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
if IsAddOnLoaded("Lorti UI") then
recup.Icon.Border.Texture:SetVertexColor(.05,.05,.05)
end
recup.Icon.Border.Texture:SetPoint("TOPLEFT", -7, 7)
recup.Icon.Border.Texture:SetSize(63,63)

recup:RegisterEvent("UNIT_AURA")
recup:SetScript("OnEvent", function(self, event, unit)
recup.CheckAura(unit)
end)
function recup.CheckAura(unit)
local spellname = GetSpellInfo(73651)
local _, _, _, _, _, duration, expirationTime, unitCaster, _, _, id = UnitBuff("player", spellname)
if id and unitCaster == "player" then
recup:Show()
recup:SetCooldown(expirationTime - duration - 0.5, duration)
return
end
recup:Hide()
end