

local addonName, addon = ...;

local talentFilePath = "Interface/AddOns/ModernTalents/Media/Talents";
local talentFilePrefix = "TalentsClassBackground";

local rolesAtlasMap = {
    HEALER = "UI-LFG-RoleIcon-Healer-Micro",
    TANK = "UI-LFG-RoleIcon-Tank-Micro",
    DAMAGER = "UI-LFG-RoleIcon-DPS-Micro",
}



















TbdCharacterFrameTooltipMixin = {}
function TbdCharacterFrameTooltipMixin:OnLoad()
    NineSliceUtil.ApplyLayout(self.NineSlice, addon.Constants.NineSliceLayouts.Flyout)
    self.fadeOut:SetScript("OnFinished", function()
        self:Hide()
    end)
end


--[[
bag-arrow
auctionhouse-itemicon-border-gray
auctionhouse-itemicon-border-artifact
honorsystem-prestige-laurel
]]












TbdCharacterFrameMixin = {}

function TbdCharacterFrameMixin:OnLoad()

    self:RegisterForDrag("LeftButton")

    SLASH_TBDCHARACTERFRAME1 = '/tbdcf'
    SlashCmdList['TBDCHARACTERFRAME'] = function(msg)
        if msg == "" then
            self:Show()
        end
    end

    NineSliceUtil.ApplyLayout(self, addon.Constants.NineSliceLayouts.ParentBorder)

    local tabs = {
        {
            label = BAG_FILTER_EQUIPMENT,
            width = 100,
            panel = self.tabContainer.equipment,
        },
        {
            label = REPUTATION_ABBR,
            width = 100,
            panel = self.tabContainer.reputations,
        },
        {
            label = BACKPACK_TOOLTIP,
            width = 100,
            panel = self.tabContainer.containers,
        },
    }
    self.tabContainer:CreateTabButtons(tabs)

    self.tabContainer.equipment:SetScript("OnShow", function()
        self:TabContainerEquipment_OnShow()
    end)

    self.tabContainer.reputations:SetScript("OnShow", function()
        self:InitializeReputations()
    end)


    self.equipmentSlots = {
        left = {},
        right = {},
        bottom = {},
    }
    local yOffset = 30
    local xOffset = -10
    local leftAnimationStartDelayIter, rightAnimationStartDelayIter = 0,0;
    for k, slot in ipairs(addon.Constants.PaperdollSlots) do
        local button;
        if slot.allignment == "left" then
            button = CreateFrame("Button", nil, self.tabContainer.equipment, "TbdCharacterFrameItemSlotTemplate_Left")
            button:SetPoint("TOPLEFT", xOffset, -(#self.equipmentSlots[slot.allignment] * 55) - yOffset)
            -- button.fadeIn.alphaIn:SetStartDelay(leftAnimationStartDelayIter * 0.01)
            -- leftAnimationStartDelayIter = leftAnimationStartDelayIter + 1
        end
        if slot.allignment == "right" then
            button = CreateFrame("Button", nil, self.tabContainer.equipment, "TbdCharacterFrameItemSlotTemplate_Right")
            button:SetPoint("TOPRIGHT", -xOffset, -(#self.equipmentSlots[slot.allignment] * 55) - yOffset)
            -- button.fadeIn.alphaIn:SetStartDelay(rightAnimationStartDelayIter * 0.01)
            -- rightAnimationStartDelayIter = rightAnimationStartDelayIter + 1
        end
        if button then
            button:SetSize(200, 30)
            button.slotIndex = slot.slotID
            button.allignment = slot.allignment
            table.insert(self.equipmentSlots[slot.allignment], button)
        end
    end

end

function TbdCharacterFrameMixin:TabContainerEquipment_OnShow()
    
    for k, button in ipairs(self.equipmentSlots.left) do
        button:SetAlpha(0)
        button.socket1:SetAlpha(0)
        button.socket2:SetAlpha(0)
        button.socket3:SetAlpha(0)
        button.fadeIn:Play()
    end
    for k, button in ipairs(self.equipmentSlots.right) do
        button:SetAlpha(0)
        button.socket1:SetAlpha(0)
        button.socket2:SetAlpha(0)
        button.socket3:SetAlpha(0)
        button.fadeIn:Play()
    end
end

function TbdCharacterFrameMixin:OnShow()
    self.masteryIndex = GetPrimaryTalentTree();
    self:LoadCharacterClassAndSpec()
    self:SetPlayer()
    self:LoadEquipmentData()
    self:UpdateStats()
end

function TbdCharacterFrameMixin:LoadCharacterClassAndSpec()
	if (self.masteryIndex == nil) then

	else
        local specID, specName, description, icon, pointsSpent, background, previewPointsSpent, isUnlocked = GetTalentTabInfo(self.masteryIndex)

        local className, classString, classID = UnitClass("player")
        self.classColour = RAID_CLASS_COLORS[classString];
        self.classString = classString;

        --self.name:SetText(string.format("%s %s %s %s", CreateSimpleTextureMarkup(icon, 32, 32), UnitName("player"), specName, className))
        self.name:SetText(RAID_CLASS_COLORS[classString]:WrapTextInColorCode(string.format("%s %s %s", UnitName("player"), specName, className)))

        local atlas = self:GetClassSpecBackground(classID, specID)

        self.classIcon:SetAtlas(string.format("ClassTrial-%s-Ring", (classString:gsub("^%l", string.upper))))
        local r, g, b = self.classColour:GetRGB()
        self.classIconLine:SetGradient("HORIZONTAL", CreateColor(r, g, b, 0.6), CreateColor(0,0,0,0.01))

        self.background:SetTexture(atlas.filePath)
        self.background:SetTexCoord(atlas.left, atlas.right, atlas.top, atlas.bottom)
	end

    self.characterModelScene.controlFrame:Show();
	self.characterModelScene.controlFrame:SetModelScene(self.characterModelScene);
end

function TbdCharacterFrameMixin:UpdateStats()

    if not self.masteryIndex then
        return
    end

    local role1, role2 = GetTalentTreeRoles(self.masteryIndex);
    local s = "";
    if role1 then
        s = CreateAtlasMarkup(rolesAtlasMap[role1], 20, 20)
    end
    if role2 then
        s = string.format("%s    %s", s, CreateAtlasMarkup(rolesAtlasMap[role2], 20, 20))
    end
    --self.statsParent.specRoles:SetText(s)
    
    local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel();
    self.ilvl:SetText(string.format("%s |cffffffff%s / %s|r", STAT_AVERAGE_ITEM_LEVEL, avgItemLevelEquipped, avgItemLevel))

    local lowCol, highCol = CreateColor(0.25, 0.25, 0.25, 0.1), CreateColor(1, 1, 1, 0.1)

    local dataProvider = CreateTreeDataProvider()
    self.statsParent.treeview.scrollView:SetDataProvider(dataProvider)

    local function UpdateToggledState(frame, node)
        if node:IsCollapsed() then
            frame.parentRight:SetAtlas("Options_ListExpand_Right")
        else
            frame.parentRight:SetAtlas("Options_ListExpand_Right_Expanded")
        end
    end

    local categories = {}
    for i = 1, #addon.StatsSchema do
        local category = addon.StatsSchema[i]

        if not categories[category.header] then
            categories[category.header] = dataProvider:Insert({
                label = category.header,
                text = "",
                atlas = "ui-lfg-roleicon-dps",
                --fontObject = GameFontNormalLarge,
                fontColour = self.classColour,

                onMouseDown = function(f)
                    if categories[category.header]:IsCollapsed() then
                        f.parentRight:SetAtlas("Options_ListExpand_Right")
                    else
                        f.parentRight:SetAtlas("Options_ListExpand_Right_Expanded")
                    end
                end,

                init = function(f)
                    f.border:Hide()
                    f.fill:Hide()
                    f.fillBackground:Hide()
                    f.parentLeft:Show()
                    f.parentRight:Show()
                    f.parentMiddle:Show()
                end,
            })
        end

        for k, stat in ipairs(category.stats) do

            if (self.classString == "DEATHKNIGHT") then
                categories[category.header]:Insert({
                    label = stat.label,
                    init = function(f)
                        f.border:SetAlpha(0)
                        f.fill:SetGradient("HORIZONTAL", lowCol, highCol)
                        stat.update(f, "player")

                        f.border:Show()
                        f.fill:Show()
                        f.fillBackground:Show()
                        f.parentLeft:Hide()
                        f.parentRight:Hide()
                        f.parentMiddle:Hide()
                    end,
                    fontColour = RAID_CLASS_COLORS.PRIEST,
    
                    onEnter = stat.onEnter,
                })

            else

                --this would be the rune regen key/index
                if (i == 2) and (k == 6) then

                else
                    categories[category.header]:Insert({
                        label = stat.label,
                        init = function(f)
                            f.border:SetAlpha(0)
                            f.fill:SetGradient("HORIZONTAL", lowCol, highCol)
                            stat.update(f, "player")

                            f.border:Show()
                            f.fill:Show()
                            f.fillBackground:Show()
                            f.parentLeft:Hide()
                            f.parentRight:Hide()
                            f.parentMiddle:Hide()
                        end,
                        fontColour = RAID_CLASS_COLORS.PRIEST,
        
                        onEnter = stat.onEnter,
                    })
                end
            end

        end
    end
    
end

function TbdCharacterFrameMixin:LoadEquipmentData()


    for k, button in ipairs(self.equipmentSlots.left) do
        button:SetItem()
    end
    for k, button in ipairs(self.equipmentSlots.right) do
        button:SetItem()
    end

--https://warcraft.wiki.gg/wiki/API_GetInventoryItemsForSlot

    
    local equipment = self:GetPlayerEquipment()

    -- if equipment.current then
    --     local dataProvider = CreateDataProvider()
    --     self.equipmentListview.scrollView:SetDataProvider(dataProvider)
    --     for k, v in ipairs(addon.Constants.InventorySlots) do
    --         if equipment.current[v.slot] then
    --             dataProvider:Insert({
    --                 label = equipment.current[v.slot],
    --                 icon = v.icon,
    --                 link = equipment.current[v.slot],
    --                 labelRight = C_Item.GetDetailedItemLevelInfo(equipment.current[v.slot]),
    --                 --backgroundAlpha = 0.6,
    --                 onMouseDown = function()
    --                     if IsControlKeyDown() then
    --                         DressUpItemLink(equipment.current[v.slot])
    --                     elseif IsShiftKeyDown() then
    --                         HandleModifiedItemClick(equipment.current[v.slot])
    --                     end
    --                 end,
    --             })
    --         else
    --             dataProvider:Insert({
    --                 label = "-",
    --                 icon = v.icon,
    --             })
    --         end
    --     end
    -- end
end

function TbdCharacterFrameMixin:GetClassSpecBackground(classID, specID)

    local class;
    if classID == 6 then
        class = "DeathKnight";
    else
        class = select(2, GetClassInfo(classID))
        class = class:lower():gsub("^%l", string.upper)
    end

    local atlasInfo = addon.Constants.TabSpecIdAtlas[specID]

    local filePath = tostring(talentFilePath.."/"..talentFilePrefix..class..atlasInfo[1]..".png");

    return {
        filePath = filePath,
        width = atlasInfo[2],
        height = atlasInfo[3],
        left = atlasInfo[4],
        right = atlasInfo[5],
        top = atlasInfo[6],
        bottom = atlasInfo[7],
    }

end



local CHARACTER_SHEET_MODEL_SCENE_ID = 595;
function TbdCharacterFrameMixin:SetPlayer()
	self.characterModelScene:ReleaseAllActors();
	self.characterModelScene:TransitionToModelSceneID(CHARACTER_SHEET_MODEL_SCENE_ID, CAMERA_TRANSITION_TYPE_IMMEDIATE, CAMERA_MODIFICATION_TYPE_DISCARD, true);

	local form = GetShapeshiftFormID();
	local creatureDisplayID = C_PlayerInfo.GetDisplayID();
	local nativeDisplayID = C_PlayerInfo.GetNativeDisplayID();
	if form and creatureDisplayID ~= 0 and not UnitOnTaxi("player") then
		local actorTag = ANIMAL_FORMS[form] and ANIMAL_FORMS[form].actorTag or nil;
		if actorTag then
			local actor = self.characterModelScene:GetPlayerActor(actorTag);
			if actor then
				-- We need to SetModelByCreatureDisplayID() for Shapeshift forms if:
				-- 1. We have a form active (already checked above)
				-- 2. The display granted by that form is *not* our native Player display (e.g. anything *but* Glyph of Stars)
				-- 3. The Player is *not* mirror imaged
				-- 4. The Player *is* currently their native race (e.g. *not* using a transform Toy of some kind)
				local displayIDIsNative = (creatureDisplayID == nativeDisplayID);
				local displayRaceIsNative = C_PlayerInfo.IsDisplayRaceNative();
				local isMirrorImage = C_PlayerInfo.IsMirrorImage();
				local useShapeshiftDisplayID = (not displayIDIsNative and not isMirrorImage and displayRaceIsNative);
				if useShapeshiftDisplayID then
					actor:SetModelByCreatureDisplayID(creatureDisplayID, true);
					actor:SetAnimationBlendOperation(Enum.ModelBlendOperation.None);
					return;
				end
			end
		end
	end

	local actor = self.characterModelScene:GetPlayerActor();
	if actor then
		local hasAlternateForm, inAlternateForm = C_PlayerInfo.GetAlternateFormInfo();
		local sheatheWeapon = GetSheathState() == 1;
		local autodress = true;
		local hideWeapon = false;
		local useNativeForm = not inAlternateForm;
		actor:SetModelByUnit("player", sheatheWeapon, autodress, hideWeapon, useNativeForm);
		actor:SetAnimationBlendOperation(Enum.ModelBlendOperation.None);
	end
end





function TbdCharacterFrameMixin:GetPlayerEquipment()
    local sets = C_EquipmentSet.GetEquipmentSetIDs();

    local equipment = {
        sets = {},
        current = {},
    };

    for k, v in ipairs(sets) do
        
        local name, iconFileID, setID, isEquipped, numItems, numEquipped, numInInventory, numLost, numIgnored = C_EquipmentSet.GetEquipmentSetInfo(v)

        local setItemIDs = C_EquipmentSet.GetItemIDs(setID)

        equipment.sets[name] = setItemIDs;
    end


    --lets grab the current gear
    local t = {}
    for k, v in ipairs(addon.Constants.InventorySlots) do
        local link = GetInventoryItemLink('player', GetInventorySlotInfo(v.slot)) or false
        if link ~= nil then
            t[v.slot] = link;
        end
    end
    equipment.current = t;

    return equipment;
end



function TbdCharacterFrameMixin:LoadReputations(reps)
    
    self.tabContainer.reputations.gridview:Flush()
    for k, rep in ipairs(reps) do
        self.tabContainer.reputations.gridview:Insert(rep)
    end
end


function TbdCharacterFrameMixin:InitializeReputations()


    self.tabContainer.reputations.gridview:InitFramePool("Frame", "TbdCharacterFrameRepParent")
    self.tabContainer.reputations.gridview:SetFixedColumnCount(4)
    
    local reputations = {};
    local factionMenu = {}
    local numFactions = GetNumFactions()
    local factionIndex = 1
    local preHeader;
    local anchorIter = 0;
    local rowIter = 1;
    while (factionIndex <= numFactions) do
        local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus = GetFactionInfo(factionIndex)
        
        if isHeader then

            if name and (not reputations[name]) then
                reputations[name] = {}
                table.insert(factionMenu, {
                    text = name,
                    func = function()
                        self:LoadReputations(reputations[name])
                    end,
                })
            end

            preHeader = name
            if isCollapsed then
                ExpandFactionHeader(factionIndex)
                numFactions = GetNumFactions()
            end
        end
        if (not isHeader) and reputations[preHeader] then

            local currentValue = (earnedValue-bottomValue)
            local barMaxValue = (topValue-bottomValue)

            table.insert(reputations[preHeader], {
                rep = {
                    factionID = factionID,
                    standingId = standingId,
                    currentValue = currentValue,
                    maxValue = barMaxValue,
                }
            })

        end
        factionIndex = factionIndex + 1
    end

    self.tabContainer.reputations.factionDropdownMenu:SetMenu(factionMenu)

end