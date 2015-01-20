--Nameplates
local fixvalue = function(val)
    if(val >= 1e6) then
        return ('%.2f'..SECOND_NUMBER_CAP):format(val / 1e6):gsub('%.?0+(['..FIRST_NUMBER_CAP..SECOND_NUMBER_CAP..'])$', '%1')
    elseif(val >= 1e4) then
        return ('%.1f'..FIRST_NUMBER_CAP):format(val / 1e3):gsub('%.?0+(['..FIRST_NUMBER_CAP..SECOND_NUMBER_CAP..'])$', '%1')
    else
        return val
    end
end

CreateFrame('frame'):SetScript('OnUpdate', function(self, elapsed)
     for index = 1, select('#', WorldFrame:GetChildren()) do
          local f = select(index, WorldFrame:GetChildren())
          if f:GetName() and f:GetName():find('NamePlate%d') then
               f.h = select(1, select(1, f:GetChildren()):GetChildren())
               if f.h then
                    if not f.h.v then
                         f.h.v = f.h:CreateFontString(nil, "ARTWORK")    
                         f.h.v:SetPoint("CENTER", f.h, 'CENTER')
                         f.h.v:SetFont("Interface\\AddOns\\Lorti UI\\fonts\\ZsRInnho.otf", 9, 'OUTLINE')
                    else
                         local _, maxh = f.h:GetMinMaxValues()
                         local val = f.h:GetValue()
                         f.h.v:SetText(string.format("%d", math.floor((val/maxh)*100)))
                         --f.h.v:SetText(string.format("%s - %d%%", fixvalue(val), math.floor((val/maxh)*100)))
                    end
               end
          end
     end
end)
--Red Hover
hooksecurefunc("ActionButton_OnEvent",function(self, event, ...)
                if ( event == "PLAYER_TARGET_CHANGED" ) then
                        self.newTimer = self.rangeTimer
                end
        end)
 
        hooksecurefunc("ActionButton_UpdateUsable",function(self)
                local icon = _G[self:GetName().."Icon"]
                local valid = IsActionInRange(self.action)
 
                if ( valid == 0 ) then
                        icon:SetVertexColor(1.0, 0.1, 0.1)
                end
        end)
 
        hooksecurefunc("ActionButton_OnUpdate",function(self, elapsed)
                local rangeTimer = self.newTimer
 
                if ( rangeTimer ) then
                        rangeTimer = rangeTimer - elapsed
 
                        if ( rangeTimer <= 0 ) then
                                ActionButton_UpdateUsable(self)
                                rangeTimer = TOOLTIP_UPDATE_TIME
                        end
 
                        self.newTimer = rangeTimer
                end
        end)
--float combat SetText
local f = CreateFrame("FRAME");
f:SetScript("OnEvent", function(self,event,...)
                        local arg1 =...;        
                        if (arg1=="Blizzard_CombatText") then
                          f:UnregisterEvent("ADDON_LOADED");
                          hooksecurefunc("CombatText_UpdateDisplayedMessages",
                          function ()
                                COMBAT_TEXT_LOCATIONS =
                                {startX  = 100,
                                startY = 384 * COMBAT_TEXT_Y_SCALE,
                                endX =200,
                                endY = 609 * COMBAT_TEXT_Y_SCALE};
                          end);
                        end
                        end);
f:RegisterEvent("ADDON_LOADED");

local fontName = "Interface\\AddOns\\Lorti UI\\fonts\\ZsRInnho.otf"
local fontHeight = 40
local fFlags = ""
local function FS_SetFont()
	DAMAGE_TEXT_FONT = fontName
	COMBAT_TEXT_HEIGHT = fontHeight
	COMBAT_TEXT_CRIT_MAXHEIGHT = fontHeight + 2
	COMBAT_TEXT_CRIT_MINHEIGHT = fontHeight - 2
	local fName, fHeight, fFlags = CombatTextFont:GetFont()
	CombatTextFont:SetFont(fontName, fontHeight, fFlags)
end
FS_SetFont()