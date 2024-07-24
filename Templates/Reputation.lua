

local addonName, addon = ...;



local standingInfo = {
    [1] = {
        name = FACTION_STANDING_LABEL1,
        maxRep = 36000,
        colour = CreateColorFromHexString("ffcc0000"),
    },
    [2] = {
        name = FACTION_STANDING_LABEL2,
        maxRep = 36000,
        colour = CreateColorFromHexString("ffff0000"),
    },
    [3] = {
        name = FACTION_STANDING_LABEL3,
        maxRep = 36000,
        colour = CreateColorFromHexString("fff26000"),
    },
    [4] = {
        name = FACTION_STANDING_LABEL4,
        maxRep = 3000,
        colour = CreateColorFromHexString("ffe4e400"),
    },
    [5] = {
        name = FACTION_STANDING_LABEL5,
        maxRep = 6000,
        colour = CreateColorFromHexString("ff33ff33"),
    },
    [6] = {
        name = FACTION_STANDING_LABEL6,
        maxRep = 12000,
        colour = CreateColorFromHexString("ff5fe65d"),
    },
    [7] = {
        name = FACTION_STANDING_LABEL7,
        maxRep = 21000,
        colour = CreateColorFromHexString("ff53e9bc"),
    },
    [8] = {
        name = FACTION_STANDING_LABEL8,
        maxRep = 1000,
        colour = CreateColorFromHexString("ff2ee6e6"),
    },
}



local repIcons = {
    [1168] = 514261, --guild
    [1106] = 236690, --argent crusade
    [1098] = 236694, --ebon blade
    [942] = 133663, --cenarion exp
    [946] = 134502, --honor hold
    [970] = 132371, -- sporeagar

    [930] = 236715, -- exodar
    [69] = 236740, -- darnassus
    [1134] = 462338, -- gilneas
    [54] = 255139, --gnomergan
    [47] = 236805, --ironforge
    [72] = 236761, --elwynn

    [933] = 1711338, --consortium
    [932] = 134552, --aldor
    [1101] = 1, --lower city
    --[609] = 
}



TbdCharacterFrameRepParentMixin = {}
function TbdCharacterFrameRepParentMixin:OnLoad()
    self:SetScript("OnLeave", function()
        GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
    end)
end
function TbdCharacterFrameRepParentMixin:SetDataBinding(binding, height)

    self.repRing:SetReputation(binding.rep)

    local name, desc = GetFactionInfoByID(binding.rep.factionID)
    self.standingLabel:SetText(binding.rep.factionID.." "..name)

    self.standingInfo:SetText(standingInfo[binding.rep.standingId].colour:WrapTextInColorCode(standingInfo[binding.rep.standingId].name))

    self:SetScript("OnEnter", function()
        local name, desc = GetFactionInfoByID(binding.rep.factionID)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:AddLine(name)
        GameTooltip:AddLine(desc, 1,1,1,true)
        GameTooltip_AddBlankLinesToTooltip(GameTooltip, 1);
        GameTooltip:AddDoubleLine(
            RAID_CLASS_COLORS.PRIEST:WrapTextInColorCode(COMBAT_FACTION_CHANGE),
            REPUTATION_PROGRESS_FORMAT:format(binding.rep.currentValue, binding.rep.maxValue)
        )
        GameTooltip_ShowProgressBar(GameTooltip, 0, binding.rep.maxValue, binding.rep.currentValue, string.format("%.1f%%", (binding.rep.currentValue / binding.rep.maxValue) * 100))
        GameTooltip:Show()
    end)

end
function TbdCharacterFrameRepParentMixin:ResetDataBinding()
    self.standingLabel:SetText("")
    self.standingInfo:SetText("")
end




local SWIPE = {
	lowTexCoords = {
		x = 1 / 256, -- left 0.00390625
		y = 1 / 128, -- top 0.0078125
	},
	highTexCoords =
	{
		x = 97 / 256, -- right 0.37890625
		y = 97 / 128, -- bottom 0.7578125
	}
}

TbdCharacterFrameRepDialMixin = {}
function TbdCharacterFrameRepDialMixin:OnLoad()
    self.cooldown:SetRotation(math.rad(180))
    self.cooldown:SetTexCoordRange(SWIPE.lowTexCoords, SWIPE.highTexCoords)
end
function TbdCharacterFrameRepDialMixin:SetValue(cur, max)
    if not cur or not max or max == 0 then 
        return 
    end
    local i = 0
    local percent = (cur/max) * 100
    local step = percent / 33
    local ticker = C_Timer.NewTicker(0.001, function()
        CooldownFrame_SetDisplayAsPercentage(self.cooldown, i / 100)
        i = i + (step)
    end, 33)
end

function TbdCharacterFrameRepDialMixin:SetIcon(icon)
    if type(icon) == "string" then
        self.icon:SetAtlas(icon)
    elseif type(icon) == "number" then
        self.icon:SetTexture(icon)
    else
        self.icon:SetTexture(nil)
    end
end

function TbdCharacterFrameRepDialMixin:SetColor(r, g, b)
    self.cooldown:SetSwipeColor(r, g, b, 1)
end

function TbdCharacterFrameRepDialMixin:SetReputation(rep)

    self:SetValue(rep.currentValue, rep.maxValue)

    if repIcons[rep.factionID] then
        self:SetIcon(repIcons[rep.factionID])
    else
        self:SetIcon()
    end

    local r, g, b = standingInfo[rep.standingId].colour:GetRGB()
    self:SetColor(r, g, b)
end
