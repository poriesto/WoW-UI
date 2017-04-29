<<<<<<< HEAD
local animationsCount, animations = 5, {}
local animationNum = 1
local frame, texture, alpha1, scale1, scale2, rotation2
for i = 1, animationsCount do
frame = CreateFrame("Frame")
texture = frame:CreateTexture() texture:SetTexture('Interface\\Cooldown\\star4') texture:SetAlpha(0) texture:SetAllPoints() texture:SetBlendMode("ADD")
animationGroup = texture:CreateAnimationGroup()
alpha1 = animationGroup:CreateAnimation("Alpha") alpha1:SetFromAlpha(0) alpha1:SetToAlpha(1) alpha1:SetDuration(0) alpha1:SetOrder(1)
scale1 = animationGroup:CreateAnimation("Scale") scale1:SetScale(1.0, 1.0) scale1:SetDuration(0) scale1:SetOrder(1)
scale2 = animationGroup:CreateAnimation("Scale") scale2:SetScale(1.5, 1.5) scale2:SetDuration(0.3) scale2:SetOrder(2)
rotation2 = animationGroup:CreateAnimation("Rotation") rotation2:SetDegrees(90) rotation2:SetDuration(0.3) rotation2:SetOrder(2)
animations[i] = {frame = frame, animationGroup = animationGroup}
end
local AnimateButton = function(self)
if not self:IsVisible() then return true end
local animation = animations[animationNum]
local frame = animation.frame
local animationGroup = animation.animationGroup
frame:SetFrameStrata("HIGH")
frame:SetFrameLevel(20)
frame:SetAllPoints(self)
animationGroup:Stop()
animationGroup:Play()
animationNum = (animationNum % animationsCount) + 1
return true
end

hooksecurefunc('MultiActionButtonDown', function(bname, id)
AnimateButton(_G[bname..'Button'..id])
end)

hooksecurefunc('PetActionButtonDown', function(id)
local button
if PetActionBarFrame then
if id > NUM_PET_ACTION_SLOTS then return end
button = _G["PetActionButton"..id]
if not button then return end
end
return
AnimateButton(button)
end)

hooksecurefunc('ActionButtonDown', function(id)
local button
if C_PetBattles.IsInBattle() then
if PetBattleFrame then
if id > NUM_BATTLE_PET_HOTKEYS then return end
button = PetBattleFrame.BottomFrame.abilityButtons[id]
if id == BATTLE_PET_ABILITY_SWITCH then
button = PetBattleFrame.BottomFrame.SwitchPetButton;
elseif id == BATTLE_PET_ABILITY_CATCH then
button = PetBattleFrame.BottomFrame.CatchButton;
end
if not button then return end
end
return
end
if OverrideActionBar and OverrideActionBar:IsShown() then
if id > NUM_OVERRIDE_BUTTONS then return end
button = _G["OverrideActionBarButton"..id]
else
button = _G["ActionButton"..id]
end
if not button then return end
AnimateButton(button)
end)
=======
local animationsCount, animations = 5, {}
local animationNum = 1
local replace = string.gsub
local frame, texture, animationGroup, alpha1, scale1, scale2, rotation2

for i = 1, animationsCount do
     frame = CreateFrame("Frame")

     texture = frame:CreateTexture()
     texture:SetTexture([[Interface\Cooldown\star4]])
     texture:SetAlpha(0)
     texture:SetAllPoints()
     texture:SetBlendMode("ADD")

     animationGroup = texture:CreateAnimationGroup()

     alpha1 = animationGroup:CreateAnimation("Alpha")
     alpha1:SetChange(1)
     alpha1:SetDuration(0)
     alpha1:SetOrder(1)

     scale1 = animationGroup:CreateAnimation("Scale")
     scale1:SetScale(1.5, 1.5)
     scale1:SetDuration(0)
     scale1:SetOrder(1)

     scale2 = animationGroup:CreateAnimation("Scale")
     scale2:SetScale(0, 0)
     scale2:SetDuration(0.3)
     scale2:SetOrder(2)

     rotation2 = animationGroup:CreateAnimation("Rotation")
     rotation2:SetDegrees(90)
     rotation2:SetDuration(0.3)
     rotation2:SetOrder(2)

     animations[i] = {frame = frame, animationGroup = animationGroup}
end

local animate = function(button)
     if not button:IsVisible() then return true end
     local animation = animations[animationNum]
     local frame = animation.frame
     local animationGroup = animation.animationGroup
     frame:SetFrameStrata(button:GetFrameStrata())
     frame:SetFrameLevel(button:GetFrameLevel() + 10)
     frame:SetAllPoints(button)
     animationGroup:Stop()
     animationGroup:Play()
     animationNum = (animationNum % animationsCount) + 1
     return true
end

local function Anum(button, buttonType)
	if InCombatLockdown() then return end
	     if not button.hooked then
	          local id, actionButtonType, key
	          if not actionButtonType then
	               actionButtonType = string.upper(button:GetName())
	               actionButtonType = replace(actionButtonType, 'BOTTOMLEFT', '1')
	               actionButtonType = replace(actionButtonType, 'BOTTOMRIGHT', '2')
	               actionButtonType = replace(actionButtonType, 'RIGHT', '3')
	               actionButtonType = replace(actionButtonType, 'LEFT', '4')
	               actionButtonType = replace(actionButtonType, 'MULTIBAR', 'MULTIACTIONBAR')
	          end

	          local key = GetBindingKey(actionButtonType)
	          if key then
	               button:RegisterForClicks("AnyDown")
	               SetOverrideBinding(button, true, key, 'CLICK '..button:GetName()..':LeftButton')
	          end
	          button.AnimateThis = animate
	          SecureHandlerWrapScript(button, "OnClick", button, [[ control:CallMethod("AnimateThis", self) ]])
	          button.hooked = true
	     end
end

hooksecurefunc('ActionButton_OnUpdate', Anum)
--hooksecurefunc('ActionButton_UpdateAction', Anum)
--hooksecurefunc('ActionButton_UpdateFlash', Anum)
--hooksecurefunc('ActionButton_UpdateUsable', Anum)
--hooksecurefunc('ActionButton_UpdateHotkeys', Anum)
>>>>>>> 76485017c94a865c32ea2efa64a426bbb1229165
