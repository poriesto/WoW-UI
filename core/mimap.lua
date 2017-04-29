	
  -- REWORKING THE MINIMAP
	local CF=CreateFrame("Frame")
	CF:RegisterEvent("PLAYER_ENTERING_WORLD")
	CF:SetScript("OnEvent", function(self, event)
		if not (IsAddOnLoaded("SexyMap")) then
			for i,v in pairs({
				MinimapBorder,
				MiniMapMailBorder,
				QueueStatusMinimapButtonBorder,
				select(1, TimeManagerClockButton:GetRegions()), 
				select(1, GameTimeFrame:GetRegions()),
              		}) do
                 		v:SetVertexColor(.05, .05, .05)
			end    
			MinimapBorderTop:Hide()
			MinimapZoomIn:Hide()
			MinimapZoomOut:Hide()
			MiniMapWorldMapButton:Hide()
			GameTimeFrame:Hide()
			GameTimeFrame:UnregisterAllEvents()
			GameTimeFrame.Show = kill
			MiniMapTracking:Hide()
			MiniMapTracking.Show = kill
			MiniMapTracking:UnregisterAllEvents()
			Minimap:EnableMouseWheel(true)
			Minimap:SetScript("OnMouseWheel", function(self, z)
				local c = Minimap:GetZoom()
				if(z > 0 and c < 5) then
					Minimap:SetZoom(c + 1)
				elseif(z < 0 and c > 0) then
					Minimap:SetZoom(c - 1)
				end
			end)
			Minimap:SetScript("OnMouseUp", function(self, btn)
				if btn == "RightButton" then
					_G.GameTimeFrame:Click()
				elseif btn == "MiddleButton" then
					_G.ToggleDropDownMenu(1, nil, _G.MiniMapTrackingDropDown, self)
				else
					_G.Minimap_OnClick(self)
				end
			end)
		end
	end)

for i = 1, NUM_CHAT_WINDOWS do local eb = _G['ChatFrame'..i..'EditBox'] eb:Hide()eb:HookScript('OnEnterPressed', function(s)s:Hide() end)end;ChatFrame1:SetClampedToScreen(nil)
ChatFrame1EditBox:SetPoint("TOPLEFT",GeneralDockManager,"TOPLEFT");
ChatFrame1EditBox:EnableMouse(false);
ChatFrame1:EnableMouse(false)
ChatFrame1Tab:ClearAllPoints();
ChatFrame1Tab:SetPoint("CENTER", UIParent, "CENTER", -990, -990);
ChatFrame1Tab.SetPoint = function() end
ChatFrame1:SetFont("Fonts\\ARIALN.TTF", 13, "OUTLINE");