local points = 0;
local addon, ns = ...
local cfg = ns.cfg

local function update(  )
  -- body
  points = GetComboPoints("player", "target");

  if points > 0 then
    cpFrame.text:SetText(points);
  else
    cpFrame.text:SetText("");
  end

  cpFrame:SetAlpha(1);
  cpFrame:Show();
  cpFrameTime = GetTime();
end

local playerClass, englishClass, classIndex = UnitClass("player");

if classIndex == 4 or classIndex == 11 then
  cpFrame = CreateFrame("Frame");
  cpFrame:ClearAllPoints();
  cpFrame:SetSize(cfg.combopoints.sizeX, cfg.combopoints.sizeY);
  cpFrame:SetScript("OnUpdate", update);
  cpFrame:SetScript("OnEvent", update);
  cpFrame:Hide();
  cpFrame.text = cpFrame:CreateFontString(nil, cfg.combopoints.background, cfg.combopoints.text);
  cpFrame.text:SetAllPoints();
  cpFrame:SetPoint(cfg.combopoints.anch, cfg.combopoints.x, cfg.combopoints.y);
  cpFrameTime = 0;
  cpFrame:RegisterEvent("PLAYER_ENTER_COMBAT");
end
