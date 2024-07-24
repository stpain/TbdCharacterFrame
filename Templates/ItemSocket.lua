

local name, addon = ...;

local socketFlyouts = {}

local function HideFlyouts(flyout)

    if flyout then
        local mouseIsOver = flyout:IsMouseOver()
        for _, frame in ipairs(flyout.gemListFrames) do
            if frame:IsMouseOver() then
                mouseIsOver = true;
            end
        end
        if flyout:GetParent():IsMouseOver() then
            mouseIsOver = true
        end
        if mouseIsOver == false then
            flyout.fadeOut:Play()
            for _, frame in ipairs(flyout.gemListFrames) do
                frame.fadeIn:Stop()
                frame:SetAlpha(0)
            end
        end
        return

    else

        for k, flyout in ipairs(socketFlyouts) do

            local mouseIsOver = flyout:IsMouseOver()
            for _, frame in ipairs(flyout.gemListFrames) do
                if frame:IsMouseOver() then
                    mouseIsOver = true;
                end
            end
            if flyout:GetParent():IsMouseOver() then
                mouseIsOver = true
            end
            if mouseIsOver == false then
                flyout.fadeOut:Play()
                for _, frame in ipairs(flyout.gemListFrames) do
                    frame.fadeIn:Stop()
                    frame:SetAlpha(0)
                end
            end
    
        end
    end


end


SocketFlyoutItemMixin = {}
function SocketFlyoutItemMixin:SetGem(gem)
    self.gem = gem
    self.gemIcon:SetTexture(gem.icon)
    self.link:SetText(gem.link)

    self:SetScript("OnMouseDown", gem.onMouseDown)

    local flyout = self:GetParent()
    local width = self.link:GetUnboundedStringWidth()
    local flyoutWidth = flyout:GetWidth()
    if width > (flyoutWidth + 20) then
        flyout:SetWidth(width + 20)
    end
end
function SocketFlyoutItemMixin:Reset()
    self.gemIcon:SetTexture(nil)
    self.link:SetText("")
end
function SocketFlyoutItemMixin:OnEnter()
    if self.gem then
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetHyperlink(self.gem.link)
        GameTooltip:Show()
    end
end
function SocketFlyoutItemMixin:OnLeave()
    GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
    HideFlyouts()
end


TbdCharacterFrameItemSocketButtonMixin = {}
function TbdCharacterFrameItemSocketButtonMixin:OnLoad()
    self:RegisterForDrag("LeftButton");
    self:RegisterEvent("SOCKET_INFO_UPDATE");

    --NineSliceUtil.ApplyLayout(self.flyout, addon.Constants.NineSliceLayouts.ParentBorder) --NineSliceLayouts.Dialog

    table.insert(socketFlyouts, self.flyout)

    self.flyout:SetScript("OnLeave", function()
    end)

    self.flyout.fadeOut:SetScript("OnFinished", function()
        self.flyout:Hide()
    end)

    self.flyout.gemListFrames = {}

end

function TbdCharacterFrameItemSocketButtonMixin:ShowFlyout()

    HideFlyouts()
    --self.flyout:SetAlpha(0)
    self.flyout:Show()
    
    if #self.gemsInBags > 0 then
        local iters = #self.gemsInBags
        local i = 1
        C_Timer.NewTicker(0.09, function()
            if self.flyout.gemListFrames[i] then
                self.flyout.gemListFrames[i].fadeIn:Play()
            end
            i = i + 1;
        end, iters)
    end
end

function TbdCharacterFrameItemSocketButtonMixin:SetSocket(info)

    self:Hide()
    
    if type(info.itemID) == "number" then
        self.socketItemID = info.itemID
        self:SetNormalTexture(select(5, GetItemInfoInstant(info.itemID)))
        self:Show()
    
    elseif type(info.colour) == "number" then
        self.socketItemID = nil
        self:SetNormalTexture(info.colour)
        self:Show()
    end

end

function TbdCharacterFrameItemSocketButtonMixin:OnDragStart()
    StaticPopup_Hide("DELETE_ITEM");
    StaticPopup_Hide("DELETE_QUEST_ITEM");
    StaticPopup_Hide("DELETE_GOOD_ITEM");
    StaticPopup_Hide("DELETE_GOOD_QUEST_ITEM");
    ClickSocketButton(self:GetID());
end
function TbdCharacterFrameItemSocketButtonMixin:OnReceiveDrag()
    StaticPopup_Hide("DELETE_ITEM");
    StaticPopup_Hide("DELETE_QUEST_ITEM");
    StaticPopup_Hide("DELETE_GOOD_ITEM");
    StaticPopup_Hide("DELETE_GOOD_QUEST_ITEM");
    SocketInventoryItem(self:GetParent().slotIndex)
    ClickSocketButton(self:GetID());
end
function TbdCharacterFrameItemSocketButtonMixin:OnLeave()
    GameTooltip:Hide();
    ShoppingTooltip1:Hide();
    HideFlyouts(self.flyout)
end

function TbdCharacterFrameItemSocketButtonMixin:InitializeSocketFlyoutMenu()

    self.gemsInBags = {}

    for bag = 0, 4 do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            local slotInfo = C_Container.GetContainerItemInfo(bag, slot)
            if slotInfo and slotInfo.hyperlink then
                local _, _, _, _, icon, classID, subClassID = GetItemInfoInstant(slotInfo.hyperlink)
                if classID == 3 and subClassID ~= 7 then
                    table.insert(self.gemsInBags, {

                        label = slotInfo.hyperlink,
                        link = slotInfo.hyperlink,
                        icon = icon,

                        onMouseDown = function()
                            ItemSocketingFrame:SetAlpha(0)
                            SocketInventoryItem(self:GetParent().slotIndex)
                            C_Container.PickupContainerItem(bag, slot)
                            ClickSocketButton(self:GetID());
                            AcceptSockets()
                            HideUIPanel(ItemSocketingFrame)
                            ItemSocketingFrame:SetAlpha(1)
                            C_Timer.After(0.1, function()
                                HideFlyouts()
                            end)
                        end,
                    })
                end

            end
        end
    end

    for k, gem in ipairs(self.gemsInBags) do
        if not self.flyout.gemListFrames[k] then
            local f = CreateFrame ("Frame", nil, self.flyout, "SocketFlyoutItemTemplate")
            self.flyout.gemListFrames[k] = f;
        end

        local f = self.flyout.gemListFrames[k]
        f.fadeIn:Stop()
        f:SetAlpha(0)
        f:SetGem(gem)
        f:SetPoint("TOP", 1, ((k-1) * -32) - 1)
    end

    self.flyout:SetSize(200, (#self.gemsInBags * 32) + 2)
    self:ShowFlyout()

end


function TbdCharacterFrameItemSocketButtonMixin:OnEnter(motion)
    ItemSocketingSocketButton_OnEnter(self, motion);

    if self.socketItemID then
        GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
        GameTooltip:SetItemByID(self.socketItemID)
        GameTooltip:Show()
    end
    self:InitializeSocketFlyoutMenu()
end
function TbdCharacterFrameItemSocketButtonMixin:OnClick(button)

    if button == "RightButton" then

        self:InitializeSocketFlyoutMenu()
    else
        if ( IsModifiedClick() ) then
            local link = GetNewSocketLink(self:GetID()) or
                         GetExistingSocketLink(self:GetID());
            HandleModifiedItemClick(link);
        else
            StaticPopup_Hide("DELETE_ITEM");
            StaticPopup_Hide("DELETE_QUEST_ITEM");
            StaticPopup_Hide("DELETE_GOOD_ITEM");
            StaticPopup_Hide("DELETE_GOOD_QUEST_ITEM");
            ClickSocketButton(self:GetID());
        end
    end

end
