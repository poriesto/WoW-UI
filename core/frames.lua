  ---------------------------------------
  -- ACTIONS
  ---------------------------------------
local addon, ns = ...
local cfg = ns.cfg

  -- REMOVING UGLY PARTS OF UI
	local event_frame = CreateFrame('Frame')
	local errormessage_blocks = {
	  'Способность пока недоступна',
	  'Выполняется другое действие',
	  'Невозможно делать это на ходу',
	  'Предмет пока недоступен',
	  'Недостаточно',
	  'Некого атаковать',
	  'Заклинание пока недоступно',
	  'У вас нет цели',
	  'Вы пока не можете этого сделать',
	  'Вы слишком далеко!',
	  'Вне зоны действия.',
	  'Этот прием может только завершать серию.',
	  'Требуется: Незаметность',
	  'Вы смотрите мимо цели',
	  'Уже действует более мощное заклинание',

	  'Ability is not ready yet',
 	  'Another action is in progress',
	  'Can\'t attack while mounted',
	  'Can\'t do that while moving',
	  'Item is not ready yet',
	  'Not enough',
	  'Nothing to attack',
	  'Spell is not ready yet',
	  'You have no target',
	  'You can\'t do that yet',
	}
	local enable
	local onevent
	local uierrorsframe_addmessage
	local old_uierrosframe_addmessage
	function enable ()
  		old_uierrosframe_addmessage = UIErrorsFrame.AddMessage
  		UIErrorsFrame.AddMessage = uierrorsframe_addmessage
	end

	function uierrorsframe_addmessage (frame, text, red, green, blue, id)
  		for i,v in ipairs(errormessage_blocks) do
    			if text and text:match(v) then
      				return
    			end
  		end
  		old_uierrosframe_addmessage(frame, text, red, green, blue, id)
	end

	function onevent (frame, event, ...)
  		if event == 'PLAYER_LOGIN' then
    			enable()
  		end
	end
	event_frame:SetScript('OnEvent', onevent)
	event_frame:RegisterEvent('PLAYER_LOGIN')

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
              		}) do
                 		v:SetVertexColor(.05, .05, .05)
			end
			select(2, TimeManagerClockButton:GetRegions()):SetVertexColor(1,1,1)
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

  -- COLORING FRAMES
	local CF=CreateFrame("Frame")
	CF:RegisterEvent("PLAYER_ENTERING_WORLD")
	CF:SetScript("OnEvent", function(self, event)
		if not (IsAddOnLoaded("Shadowed Unit Frames") or IsAddOnLoaded("PitBull Unit Frames 4.0") or IsAddOnLoaded("X-Perl UnitFrames")) then
                	for i,v in pairs({
				PlayerFrameTexture,
				PlayerFrameAlternateManaBarBorder,	PlayerFrameAlternateManaBarLeftBorder,
				PlayerFrameAlternateManaBarRightBorder,
				AlternatePowerBarBorder, AlternatePowerBarLeftBorder,
				AlternatePowerBarRightBorder, TargetFrameTextureFrameTexture,
  				PetFrameTexture,
				PartyMemberFrame1Texture, PartyMemberFrame2Texture,
				PartyMemberFrame3Texture, PartyMemberFrame4Texture,
				PartyMemberFrame1PetFrameTexture, PartyMemberFrame2PetFrameTexture,
				PartyMemberFrame3PetFrameTexture, PartyMemberFrame4PetFrameTexture,
   				FocusFrameTextureFrameTexture,
   				TargetFrameToTTextureFrameTexture,
   				FocusFrameToTTextureFrameTexture,
				Boss1TargetFrameTextureFrameTexture, Boss2TargetFrameTextureFrameTexture,
				Boss3TargetFrameTextureFrameTexture, Boss4TargetFrameTextureFrameTexture,
				Boss5TargetFrameTextureFrameTexture,
				Boss1TargetFrameSpellBarBorder, Boss2TargetFrameSpellBarBorder,
				Boss3TargetFrameSpellBarBorder, Boss4TargetFrameSpellBarBorder,
				Boss5TargetFrameSpellBarBorder,
				select(5, ShardBarFrameShard1:GetRegions()),
            			select(5, ShardBarFrameShard2:GetRegions()),
            			select(5, ShardBarFrameShard3:GetRegions()),
				select(5, ShardBarFrameShard4:GetRegions()),
				select(1, BurningEmbersBarFrame:GetRegions()),
				select(1, BurningEmbersBarFrameEmber1:GetRegions()),
            			select(1, BurningEmbersBarFrameEmber2:GetRegions()),
            			select(1, BurningEmbersBarFrameEmber3:GetRegions()),
				select(1, BurningEmbersBarFrameEmber4:GetRegions()),
            			select(1, PaladinPowerBar:GetRegions()),
				select(1, ComboPoint1:GetRegions()),
				select(1, ComboPoint2:GetRegions()),
				select(1, ComboPoint3:GetRegions()),
				select(1, ComboPoint4:GetRegions()),
				select(1, ComboPoint5:GetRegions()),
				CastingBarFrameBorder,
				FocusFrameSpellBarBorder,
				TargetFrameSpellBarBorder,
			}) do
                 		v:SetVertexColor(.05, .05, .05)
			end
			for i,v in pairs({
				PlayerPVPIcon,
				TargetFrameTextureFramePVPIcon,
				FocusFrameTextureFramePVPIcon,
			}) do
				v:SetAlpha(0)
			end
			for i=1,4 do
				_G["PartyMemberFrame"..i.."PVPIcon"]:SetAlpha(0)
				_G["PartyMemberFrame"..i.."NotPresentIcon"]:Hide()
				_G["PartyMemberFrame"..i.."NotPresentIcon"].Show = function() end
			end
			PlayerFrameGroupIndicator:SetAlpha(0)
			PlayerHitIndicator:SetText(nil)
			PlayerHitIndicator.SetText = function() end
			PetHitIndicator:SetText(nil)
			PetHitIndicator.SetText = function() end
		else
			CastingBarFrameBorder:SetVertexColor(.05,.05,.05)
		end
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        	CF:SetScript("OnEvent", nil)
	end)

 -- COLORING THE MAIN BAR
	for i,v in pairs({
		SlidingActionBarTexture0, SlidingActionBarTexture1,
        MainMenuBarTexture0, MainMenuBarTexture1,
		MainMenuBarTexture2, MainMenuBarTexture3,
        MainMenuMaxLevelBar0, MainMenuMaxLevelBar1,
		MainMenuMaxLevelBar2, MainMenuMaxLevelBar3,
		MainMenuXPBarTextureLeftCap, MainMenuXPBarTextureRightCap, MainMenuXPBarTextureMid,
		ReputationWatchBarTexture0, ReputationWatchBarTexture1,
		ReputationWatchBarTexture2, ReputationWatchBarTexture3,
		ReputationXPBarTexture0, ReputationXPBarTexture1,
		ReputationXPBarTexture2, ReputationXPBarTexture3,
	}) do

                 v:SetVertexColor(.2, .2, .2)

	end
	for i=1,19 do _G["MainMenuXPBarDiv"..i]:SetTexture(Empty_Art) end
	ExhaustionTick:SetAlpha(0)
        for i,v in pairs({
		MainMenuBarLeftEndCap, MainMenuBarRightEndCap,
		StanceBarLeft, StanceBarMiddle, StanceBarRight,
	}) do
                v:SetVertexColor(.35, .35, .35)
	end

 -- COLORING ARENA FRAMES
	local CF = CreateFrame("Frame")
	local _, instanceType = IsInInstance()
	CF:RegisterEvent("ADDON_LOADED")
	CF:RegisterEvent("PLAYER_ENTERING_WORLD")
	CF:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
        CF:SetScript("OnEvent", function(self, event, addon)
             	if addon == "Blizzard_ArenaUI" and not (IsAddOnLoaded("Shadowed Unit Frames")) then
			for i,v in pairs({
 				ArenaEnemyFrame1Texture, ArenaEnemyFrame2Texture,
				ArenaEnemyFrame3Texture, ArenaEnemyFrame4Texture,
				ArenaEnemyFrame5Texture,
				ArenaEnemyFrame1SpecBorder,	ArenaEnemyFrame2SpecBorder,
				ArenaEnemyFrame3SpecBorder,	ArenaEnemyFrame4SpecBorder,
				ArenaEnemyFrame5SpecBorder,	ArenaEnemyFrame1PetFrameTexture,
				ArenaEnemyFrame2PetFrameTexture, ArenaEnemyFrame3PetFrameTexture,
				ArenaEnemyFrame4PetFrameTexture, ArenaEnemyFrame5PetFrameTexture, }) do
                		v:SetVertexColor(.05, .05, .05)
	      		end
		elseif event == "ARENA_PREP_OPPONENT_SPECIALIZATIONS" or (event == "PLAYER_ENTERING_WORLD" and instanceType == "arena") then
			for i,v in pairs({
				ArenaPrepFrame1Texture, ArenaPrepFrame2Texture,
				ArenaPrepFrame3Texture,	ArenaPrepFrame4Texture,
				ArenaPrepFrame5Texture,
				ArenaPrepFrame1SpecBorder, ArenaPrepFrame2SpecBorder,
				ArenaPrepFrame3SpecBorder, ArenaPrepFrame4SpecBorder,
				ArenaPrepFrame5SpecBorder, }) do
                		v:SetVertexColor(.05, .05, .05)
	      		end
		end
	end)

--set SetTexture
hooksecurefunc(getmetatable(PlayerFrameHealthBar).__index,"Show",function(s)
    if s:GetParent().healthbar then
        if s.st == nil then
            s:SetStatusBarTexture(cfg.textures.frames)
			s:GetStatusBarTexture():SetDesaturated(1)
			s:GetStatusBarTexture():SetTexCoord(0, 1, .609375, .796875)
            s:GetStatusBarTexture():SetHorizTile(true)
            s.st = true
		end
    end
end)


--class color healthbar
local UnitIsPlayer, UnitIsConnected, UnitClass, RAID_CLASS_COLORS =
UnitIsPlayer, UnitIsConnected, UnitClass, RAID_CLASS_COLORS
local _, class, c
local function colour(statusbar, unit)
if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit and UnitClass(unit) then
_, class = UnitClass(unit)
c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
statusbar:SetStatusBarColor(c.r, c.g, c.b)
end
end
hooksecurefunc("UnitFrameHealthBar_Update", colour)
hooksecurefunc("HealthBar_OnValueChanged", function(self)
colour(self, self.unit)
end)
local sb = _G.GameTooltipStatusBar
local addon = CreateFrame("Frame", "StatusColour")
addon:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
addon:SetScript("OnEvent", function()
colour(sb, "mouseover")
end)
local targetPosY = playerPosY;
local targetPosX = playerPosX*(-1) + 255;

----focus
FocusFrame:SetScale(Scale)

local frames = {"PlayerFrame", "TargetFrame"};
for i = 1, #frames do
	local FrameName = frames[i]
	_G[FrameName]:SetScale(Scale);
	_G[FrameName]:SetMovable(true);
	_G[FrameName]:ClearAllPoints();
	if i > 1 then
		_G[FrameName]:SetPoint(frameAnch, targetPosX, targetPosY);
	else
		_G[FrameName]:SetPoint(frameAnch, playerPosX, playerPosY);
	end
	_G[FrameName]:SetUserPlaced(true);
	_G[FrameName]:SetMovable(false);
end

--merchant tweak
local g = CreateFrame("Frame")
g:RegisterEvent("MERCHANT_SHOW")

g:SetScript("OnEvent", function()
        local bag, slot
        for bag = 0, 4 do
                for slot = 0, GetContainerNumSlots(bag) do
                        local link = GetContainerItemLink(bag, slot)
                        if link and (select(3, GetItemInfo(link)) == 0) then
                                UseContainerItem(bag, slot)
                        end
                end
        end

        if(CanMerchantRepair()) then
                local cost = GetRepairAllCost()
                if cost > 0 then
                        local money = GetMoney()
                        if IsInGuild() then
                                local guildMoney = GetGuildBankWithdrawMoney()
                                if guildMoney > GetGuildBankMoney() then
                                        guildMoney = GetGuildBankMoney()
                                end
                                if guildMoney > cost and CanGuildBankRepair() then
                                        RepairAllItems(1)
                                        print(format("|cfff07100Repair cost covered by G-Bank: %.1fg|r", cost * 0.0001))
                                        return
                                end
                        end
                        if money > cost then
                                RepairAllItems()
                                print(format("|cffead000Repair cost: %.1fg|r", cost * 0.0001))
                        else
                                print("Not enough gold to cover the repair cost.")
                        end
                end
        end
end)

local FrameList = {"Player", "Target", "Focus"}
local function UpdateHealthValues(...)
	for i = 1, #FrameList do
		local FrameName = FrameList[i]
		local Health = AbbreviateLargeNumbers(UnitHealth(FrameName))
		local HealthMax = AbbreviateLargeNumbers(UnitHealthMax(FrameName))
		local HealthPercent = (UnitHealth(FrameName)/UnitHealthMax(FrameName))*100
		local powerType, powerTypeString = UnitPowerType(FrameName)
		local Power = UnitPower(FrameName, powerType)
		_G[FrameName.."FrameHealthBar"].TextString:SetText(Health.." | "..format("%.0f",HealthPercent).."%")
		_G[FrameName.."FrameManaBar"].TextString:SetText(Power)
	end
end
hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateHealthValues)
