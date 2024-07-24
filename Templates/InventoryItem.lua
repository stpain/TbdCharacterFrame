

local name, addon = ...;



TbdCharacterFrameItemPortraitIconMixin = {}
function TbdCharacterFrameItemPortraitIconMixin:Init()
    local x, y = self:GetSize()
    self.border:SetSize(x + 22, y + 22)
    self.highlight:SetSize(x + 40, y + 40)
    --self.highlight2:SetSize(200, 40)
    self.iconBorder:SetSize(x + 4, y + 4)
    self.iconBorderMask:SetSize(x + 4, y + 4)
    self.icon:SetSize(x - 2, y - 2)
    self.iconMask:SetSize(x - 6, y - 6)
end



local socketFileIDs = {
    EMPTY_SOCKET_BLUE = 136256,
    EMPTY_SOCKET_META = 136257,
    EMPTY_SOCKET_RED = 136258,
    EMPTY_SOCKET_YELLOW = 136259,
    EMPTY_SOCKET_PRISMATIC = 458977,
}
local socketOrder = {
    [1] = "EMPTY_SOCKET_META",
    [2] = "EMPTY_SOCKET_RED",
    [3] = "EMPTY_SOCKET_YELLOW",
    [4] = "EMPTY_SOCKET_BLUE",
    [5] = "EMPTY_SOCKET_PRISMATIC",
}
local breakLink = function(link)
    return string.match(link, [[|H([^:]*):([^|]*)|h(.*)|h]])
end
local function GetItemSocketInfo(link)
    
    local x, payload = breakLink(link)

    local itemID, enchantID, gem1, gem2, gem3 = strsplit(":", payload)

    enchantID = tonumber(enchantID)
    gem1 = tonumber(gem1)
    gem2 = tonumber(gem2)
    gem3 = tonumber(gem3)

    local gems = { [1] = gem1, [2] = gem2, [3] = gem3, }

    local ret = {
        numSockets = 0,
        numEmptySockets = 0,
        actualSocketString = "",
        missingSocketsString = "",
        itemSocketsOrdered = {},
        sockets = gems,
    }

    local sockets = {}
    local itemSocketsOrderd = {}

    local stats = GetItemStats(link)
    for k, v in pairs(stats) do
        --print(k, v)
        if k:find("SOCKET", nil, true) then
            sockets[k] = tonumber(v)
            ret.numSockets = ret.numSockets + 1;
        end
    end

    if ret.numSockets > 0 then

        for k, socketType in ipairs(socketOrder) do
            if type(sockets[socketType]) == "number" and (sockets[socketType] > 0) then
                for i = 1, sockets[socketType] do
                    table.insert(itemSocketsOrderd, socketFileIDs[socketType])
                end
            end
        end

        ret.itemSocketsOrdered = itemSocketsOrderd

        for i = 1, 3 do

            if type(gems[i]) == "number" then

            elseif type(itemSocketsOrderd[i]) == "number" then
                ret.numEmptySockets = ret.numEmptySockets + 1;
            end
        end
    end

    return ret;
end



local WHITE_COLOR_FADE = CreateColor(1,1,1,0.01)
local WHITE_COLOR = CreateColor(76/255,76/255,76/255,1)

TbdCharacterFrameItemSlotMixin = {}

function TbdCharacterFrameItemSlotMixin:OnLoad()

    self:RegisterEvent("SOCKET_INFO_ACCEPT")
    self:SetScript("OnEvent", function()
        C_Timer.After(0.5, function()
            self:SetItem()
        end)
    end)
    

    --modify the tbd template
    self.flyout:ClearNormalTexture()
    self.flyout:ClearHighlightTexture()

    self.iconFrame:SetScript("OnMouseDown", function()
        self.flyout:Click()
    end)
end
function TbdCharacterFrameItemSlotMixin:SetItem()
    local item = Item:CreateFromEquipmentSlot(self.slotIndex)
    if not item:IsItemEmpty() then
        item:ContinueOnItemLoad(function()
            local rgb = item:GetItemQualityColor()
            local colour = CreateColor(rgb.r, rgb.g, rgb.b, 1)

            -- if self.modelFrame then
            --     self.modelFrame.model:SetItem(item:GetItemID())
            --     self.modelFrame.model:SetRotation(1.57, true)
            --     self.modelFrame.model:SetPortraitZoom(6)
            --     self.modelFrame.model:PlayAnimKit(1)
            -- end

            
            self.iconFrame.iconBorder:SetGradient("VERTICAL", colour, WHITE_COLOR_FADE)
            if self.allignment == "left" then
                self.bottomLine:SetGradient("HORIZONTAL", colour, WHITE_COLOR_FADE)
            else
                self.bottomLine:SetGradient("HORIZONTAL", WHITE_COLOR_FADE, colour)
            end
            self.iconFrame.icon:SetTexture(item:GetItemIcon())
            self.link:SetText(item:GetItemLink())
            self.ilvl:SetText(item:GetCurrentItemLevel())

            self.iconFrame:SetScript("OnLeave", function()
                TbdCharacterFrameTooltip.fadeOut:Play()
                self.iconFrame.rotateWhirl:Stop()
                TbdCharacterFrameTooltip:Hide()
            end)

            self.iconFrame:SetScript("OnEnter", function()
                if self.allignment == "left" then
                    TbdCharacterFrameTooltip:SetOwner(self.iconFrame, "ANCHOR_LEFT", -10, -10)
                else
                    TbdCharacterFrameTooltip:SetOwner(self.iconFrame, "ANCHOR_RIGHT", 10, -10)
                end

                self.iconFrame.rotateWhirl:Play()

                TbdCharacterFrameTooltip:SetHyperlink(item:GetItemLink())
                TbdCharacterFrameTooltip.fadeOut:Stop()
                TbdCharacterFrameTooltip:Show()
                TbdCharacterFrameTooltip.fadeIn:Play()
            end)

            local socketInfo = GetItemSocketInfo(item:GetItemLink())
            if socketInfo then
                for i = 1, 3 do
                    self["socket"..i]:SetSocket({ itemID = socketInfo.sockets[i], colour = socketInfo.itemSocketsOrdered[i], })
                end
            end

            

        end)

    else

        self.iconFrame.icon:SetAtlas("common-icon-redx")
        if self.allignment == "left" then
            self.bottomLine:SetGradient("HORIZONTAL", WHITE_COLOR, WHITE_COLOR_FADE)
        else
            self.bottomLine:SetGradient("HORIZONTAL", WHITE_COLOR_FADE, WHITE_COLOR)
        end

    end
    self.iconFrame:Init()
end
