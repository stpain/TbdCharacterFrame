

local _, addon = ...;

addon.Constants = {}

addon.Constants.NineSliceLayouts = {
    ParentBorder = {
        TopLeftCorner =	{ atlas = "Tooltip-NineSlice-CornerTopLeft", x=-3, y=3 },
        TopRightCorner =	{ atlas = "Tooltip-NineSlice-CornerTopRight", x=3, y=3 },
        BottomLeftCorner =	{ atlas = "Tooltip-NineSlice-CornerBottomLeft", x=-3, y=-3 },
        BottomRightCorner =	{ atlas = "Tooltip-NineSlice-CornerBottomRight", x=3, y=-3 },
        TopEdge = { atlas = "_Tooltip-NineSlice-EdgeTop", },
        BottomEdge = { atlas = "_Tooltip-NineSlice-EdgeBottom", },
        LeftEdge = { atlas = "!Tooltip-NineSlice-EdgeLeft", },
        RightEdge = { atlas = "!Tooltip-NineSlice-EdgeRight", },
    },
    ListviewMetal = {
        TopLeftCorner =	{ atlas = "UI-Frame-DiamondMetal-CornerTopLeft", x=-15, y=15 },
        TopRightCorner =	{ atlas = "UI-Frame-DiamondMetal-CornerTopRight", x=15, y=15 },
        BottomLeftCorner =	{ atlas = "UI-Frame-DiamondMetal-CornerBottomLeft", x=-15, y=-15 },
        BottomRightCorner =	{ atlas = "UI-Frame-DiamondMetal-CornerBottomRight", x=15, y=-15 },
        TopEdge = { atlas = "_UI-Frame-DiamondMetal-EdgeTop", },
        BottomEdge = { atlas = "_UI-Frame-DiamondMetal-EdgeBottom", },
        LeftEdge = { atlas = "!UI-Frame-DiamondMetal-EdgeLeft", },
        RightEdge = { atlas = "!UI-Frame-DiamondMetal-EdgeRight", },
        Center = { layer = "BACKGROUND", atlas = "ClassHall_InfoBoxMission-BackgroundTile", x = -20, y = 20, x1 = 20, y1 = -20 },
    },
	Flyout = {
		TopLeftCorner =	{ atlas = "CharacterCreateDropdown-NineSlice-CornerTopLeft", x = -36, y = 20, },
		TopRightCorner =	{ atlas = "CharacterCreateDropdown-NineSlice-CornerTopRight", x = 36, y = 20, },
		BottomLeftCorner =	{ atlas = "CharacterCreateDropdown-NineSlice-CornerBottomLeft", x = -36, y = -40, },
		BottomRightCorner =	{ atlas = "CharacterCreateDropdown-NineSlice-CornerBottomRight", x = 36, y = -40, },
		TopEdge = { atlas = "_CharacterCreateDropdown-NineSlice-EdgeTop", },
		BottomEdge = { atlas = "_CharacterCreateDropdown-NineSlice-EdgeBottom", },
		LeftEdge = { atlas = "!CharacterCreateDropdown-NineSlice-EdgeLeft", },
		RightEdge = { atlas = "!CharacterCreateDropdown-NineSlice-EdgeRight", },
		Center = { atlas = "CharacterCreateDropdown-NineSlice-Center", },
	},
	Relic = {
		TopLeftCorner =	{ atlas = "Relicforge-Topleft-corner", x = -2, y = 2, },
		TopRightCorner =	{ atlas = "Relicforge-Topright-corner", x = 2, y = 2, },
		BottomLeftCorner =	{ atlas = "Relicforge-Bottomleft-corner", x = -2, y = -2, },
		BottomRightCorner =	{ atlas = "Relicforge-Bottomright-corner", x = 2, y = -2, },
		TopEdge = { atlas = "Relicforge-Topframe", },
		BottomEdge = { atlas = "Relicforge-Bottomframe", },
		LeftEdge = { atlas = "Relicforge-Leftframe", },
		RightEdge = { atlas = "Relicforge-Rightframe", },
		Center = { atlas = "CharacterCreateDropdown-NineSlice-Center", },
	},
}

addon.Constants.PaperdollSlots = {
    { allignment = "left", slotID = 1, },
    { allignment = "left", slotID = 2, },
    { allignment = "left", slotID = 3, },
    { allignment = "left", slotID = 15, },
    { allignment = "left", slotID = 5, },
    { allignment = "left", slotID = 4, },
    { allignment = "left", slotID = 19, },
    { allignment = "left", slotID = 9, },

    { allignment = "right", slotID = 10, },
    { allignment = "right", slotID = 6, },
    { allignment = "right", slotID = 7, },
    { allignment = "right", slotID = 8, },
    { allignment = "right", slotID = 11, },
    { allignment = "right", slotID = 12, },
    { allignment = "right", slotID = 13, },
    { allignment = "right", slotID = 14, },

    { allignment = "left", slotID = 16, },
    { allignment = "right", slotID = 17, },
    { allignment = "right", slotID = 18, },
}

addon.Constants.InventorySlots = {
    {
        slot = "HEADSLOT",
        icon = 136516,
    },
    {
        slot = "NECKSLOT",
        icon = 136519,
    },
    {
        slot = "SHOULDERSLOT",
        icon = 136526,
    },
    {
        slot = "BACKSLOT",
        icon = 136521,
    },
    {
        slot = "SHIRTSLOT",
        icon = 136525,
    },
    {
        slot = "CHESTSLOT",
        icon = 136512,
    },
    {
        slot = "WAISTSLOT",
        icon = 136529,
    },
    {
        slot = "LEGSSLOT",
        icon = 136517,
    },
    {
        slot = "FEETSLOT",
        icon = 136513,
    },
    {
        slot = "WRISTSLOT",
        icon = 136530,
    },
    {
        slot = "HANDSSLOT",
        icon = 136515,
    },
    {
        slot = "FINGER0SLOT",
        icon = 136514,
    },
    {
        slot = "FINGER1SLOT",
        icon = 136523,
    },
    {
        slot = "TRINKET0SLOT",
        icon = 136528,
    },
    {
        slot = "TRINKET1SLOT",
        icon = 136528,
    },
    {
        slot = "MAINHANDSLOT",
        icon = 136518,
    },
    {
        slot = "SECONDARYHANDSLOT",
        icon = 136524,
    },
    {
        slot = "RANGEDSLOT",
        icon = 136520,
    },
    {
        slot = "TABARDSLOT",
        icon = 136527,
    },
    -- {
    --     slot = "RELICSLOT",
    --     icon = 136522,
    -- },
}

--[[
local talentFilePath = "Interface/AddOns/TbdCharacterFrame/Media/Talents",
local talentFilePrefix = "TalentsClassBackground",
]]
addon.Constants.TabSpecIdAtlas = {

    --png id, width, height, left, left, top, bottom

    --dk
    [398] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
    [399] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
    [400] = { 2, 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },

    --druid
    [752] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
    [750] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
    --[398] = { 2, 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
    [748] = { 2, 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },

    --hunter
    [811] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
    [807] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
    [809] = { 2, 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },

    --mage
    [799] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
    [851] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
    [823] = { 2, 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },

    --[[
	["interface/talentframe/talentsclassbackgroundmonk1"] = {
		["talents-background-monk-brewmaster"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-background-monk-mistweaver"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsclassbackgroundmonk2"] = {
		["talents-background-monk-windwalker"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },
	},
    ]]

    --paladin
    [831] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
    [839] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
    [855] = { 2, 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },

    --priest
    [760] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
    [813] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
    [795] = { 2, 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },

    --rogue
    [182] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
    [181] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
    [183] = { 2, 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },

    --shaman
    [261] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
    [263] = { 1,  1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
    [262] = { 2, 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },

    --warlock
    [871] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
    [867] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
    [765] = { 2, 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },

    --warrior
    [746] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
    [815] = { 1, 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
    [845] = { 2, 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },
}

addon.Constants.Atlas = {
    ["interface/talentframe/specialization"] = {
		["spec-background"] = { 1612, 856, 0.00048828125, 0.78759765625, 0.00048828125, 0.41845703125, false, false },
		["spec-columndivider"] = { 7, 856, 0.982421875, 0.98583984375, 0.00048828125, 0.41845703125, false, false },
		["spec-dividerline"] = { 254, 2, 0.00048828125, 0.12451171875, 0.93798828125, 0.93896484375, false, false },
		["spec-hover-background"] = { 395, 856, 0.78857421875, 0.9814453125, 0.00048828125, 0.41845703125, false, false },
		["spec-role-dps"] = { 29, 29, 0.15869140625, 0.1728515625, 0.86865234375, 0.8828125, false, false },
		["spec-role-heal"] = { 29, 29, 0.173828125, 0.18798828125, 0.86865234375, 0.8828125, false, false },
		["spec-role-tank"] = { 29, 29, 0.15869140625, 0.1728515625, 0.8837890625, 0.89794921875, false, false },
		["spec-sampleabilityring"] = { 62, 60, 0.15869140625, 0.18896484375, 0.83837890625, 0.86767578125, false, false },
		["spec-selected-background1"] = { 395, 856, 0.00048828125, 0.193359375, 0.41943359375, 0.83740234375, false, false },
		["spec-selected-background2"] = { 395, 856, 0.1943359375, 0.38720703125, 0.41943359375, 0.83740234375, false, false },
		["spec-selected-background3"] = { 395, 856, 0.38818359375, 0.5810546875, 0.41943359375, 0.83740234375, false, false },
		["spec-selected-background4"] = { 395, 856, 0.58203125, 0.77490234375, 0.41943359375, 0.83740234375, false, false },
		["spec-selected-background5"] = { 395, 856, 0.77587890625, 0.96875, 0.41943359375, 0.83740234375, false, false },
		["spec-thumbnailborder-off"] = { 322, 202, 0.00048828125, 0.15771484375, 0.83837890625, 0.93701171875, false, false },
		["spec-thumbnailborder-on"] = { 322, 202, 0.1943359375, 0.3515625, 0.83837890625, 0.93701171875, false, false },
	},
	["interface/talentframe/specialization2"] = {
		["spec-animations-mask-filigree-activate"] = { 2048, 1024, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/specializationclassthumbnails"] = {
		["spec-thumbnail-deathknight-blood"] = { 306, 186, 0.00048828125, 0.14990234375, 0.00048828125, 0.09130859375, false, false },
		["spec-thumbnail-deathknight-frost"] = { 306, 186, 0.15087890625, 0.30029296875, 0.00048828125, 0.09130859375, false, false },
		["spec-thumbnail-deathknight-unholy"] = { 306, 186, 0.30126953125, 0.45068359375, 0.00048828125, 0.09130859375, false, false },
		["spec-thumbnail-demonhunter-havoc"] = { 306, 186, 0.45166015625, 0.60107421875, 0.00048828125, 0.09130859375, false, false },
		["spec-thumbnail-demonhunter-vengeance"] = { 306, 186, 0.60205078125, 0.75146484375, 0.00048828125, 0.09130859375, false, false },
		["spec-thumbnail-druid-balance"] = { 306, 186, 0.75244140625, 0.90185546875, 0.00048828125, 0.09130859375, false, false },
		["spec-thumbnail-druid-feral"] = { 306, 186, 0.00048828125, 0.14990234375, 0.09228515625, 0.18310546875, false, false },
		["spec-thumbnail-druid-guardian"] = { 306, 186, 0.15087890625, 0.30029296875, 0.09228515625, 0.18310546875, false, false },
		["spec-thumbnail-druid-restoration"] = { 306, 186, 0.30126953125, 0.45068359375, 0.09228515625, 0.18310546875, false, false },
		["spec-thumbnail-evoker-augmentation"] = { 306, 186, 0.60205078125, 0.75146484375, 0.45947265625, 0.55029296875, false, false },
		["spec-thumbnail-evoker-devastation"] = { 306, 186, 0.45166015625, 0.60107421875, 0.09228515625, 0.18310546875, false, false },
		["spec-thumbnail-evoker-preservation"] = { 306, 186, 0.60205078125, 0.75146484375, 0.09228515625, 0.18310546875, false, false },
		["spec-thumbnail-hunter-beastmastery"] = { 306, 186, 0.75244140625, 0.90185546875, 0.09228515625, 0.18310546875, false, false },
		["spec-thumbnail-hunter-marksmanship"] = { 306, 186, 0.00048828125, 0.14990234375, 0.18408203125, 0.27490234375, false, false },
		["spec-thumbnail-hunter-survival"] = { 306, 186, 0.15087890625, 0.30029296875, 0.18408203125, 0.27490234375, false, false },
		["spec-thumbnail-mage-arcane"] = { 306, 186, 0.30126953125, 0.45068359375, 0.18408203125, 0.27490234375, false, false },
		["spec-thumbnail-mage-fire"] = { 306, 186, 0.45166015625, 0.60107421875, 0.18408203125, 0.27490234375, false, false },
		["spec-thumbnail-mage-frost"] = { 306, 186, 0.60205078125, 0.75146484375, 0.18408203125, 0.27490234375, false, false },
		["spec-thumbnail-monk-brewmaster"] = { 306, 186, 0.75244140625, 0.90185546875, 0.18408203125, 0.27490234375, false, false },
		["spec-thumbnail-monk-mistweaver"] = { 306, 186, 0.00048828125, 0.14990234375, 0.27587890625, 0.36669921875, false, false },
		["spec-thumbnail-monk-windwalker"] = { 306, 186, 0.15087890625, 0.30029296875, 0.27587890625, 0.36669921875, false, false },
		["spec-thumbnail-paladin-holy"] = { 306, 186, 0.30126953125, 0.45068359375, 0.27587890625, 0.36669921875, false, false },
		["spec-thumbnail-paladin-protection"] = { 306, 186, 0.45166015625, 0.60107421875, 0.27587890625, 0.36669921875, false, false },
		["spec-thumbnail-paladin-retribution"] = { 306, 186, 0.60205078125, 0.75146484375, 0.27587890625, 0.36669921875, false, false },
		["spec-thumbnail-priest-discipline"] = { 306, 186, 0.75244140625, 0.90185546875, 0.27587890625, 0.36669921875, false, false },
		["spec-thumbnail-priest-holy"] = { 306, 186, 0.00048828125, 0.14990234375, 0.36767578125, 0.45849609375, false, false },
		["spec-thumbnail-priest-shadow"] = { 306, 186, 0.15087890625, 0.30029296875, 0.36767578125, 0.45849609375, false, false },
		["spec-thumbnail-rogue-assassination"] = { 306, 186, 0.30126953125, 0.45068359375, 0.36767578125, 0.45849609375, false, false },
		["spec-thumbnail-rogue-outlaw"] = { 306, 186, 0.45166015625, 0.60107421875, 0.36767578125, 0.45849609375, false, false },
		["spec-thumbnail-rogue-subtlety"] = { 306, 186, 0.60205078125, 0.75146484375, 0.36767578125, 0.45849609375, false, false },
		["spec-thumbnail-shaman-elemental"] = { 306, 186, 0.75244140625, 0.90185546875, 0.36767578125, 0.45849609375, false, false },
		["spec-thumbnail-shaman-enhancement"] = { 306, 186, 0.00048828125, 0.14990234375, 0.45947265625, 0.55029296875, false, false },
		["spec-thumbnail-shaman-restoration"] = { 306, 186, 0.00048828125, 0.14990234375, 0.55126953125, 0.64208984375, false, false },
		["spec-thumbnail-warlock-affliction"] = { 306, 186, 0.00048828125, 0.14990234375, 0.64306640625, 0.73388671875, false, false },
		["spec-thumbnail-warlock-demonology"] = { 306, 186, 0.00048828125, 0.14990234375, 0.73486328125, 0.82568359375, false, false },
		["spec-thumbnail-warlock-destruction"] = { 306, 186, 0.00048828125, 0.14990234375, 0.82666015625, 0.91748046875, false, false },
		["spec-thumbnail-warrior-arms"] = { 306, 186, 0.15087890625, 0.30029296875, 0.45947265625, 0.55029296875, false, false },
		["spec-thumbnail-warrior-fury"] = { 306, 186, 0.30126953125, 0.45068359375, 0.45947265625, 0.55029296875, false, false },
		["spec-thumbnail-warrior-protection"] = { 306, 186, 0.45166015625, 0.60107421875, 0.45947265625, 0.55029296875, false, false },
	},
	["interface/talentframe/talentframeatlas"] = {
		["_Talent-blue-glow"] = { 16, 16, 0, 0.0625, 0.0009765625, 0.0166015625, true, false },
		["_Talent-Bottom-Tile"] = { 64, 5, 0, 0.25, 0.0771484375, 0.08203125, true, false },
		["_Talent-green-glow"] = { 16, 16, 0, 0.0625, 0.083984375, 0.099609375, true, false },
		["_Talent-Top-Tile"] = { 64, 13, 0, 0.25, 0.0625, 0.0751953125, true, false },
		["pvptalents-background"] = { 131, 379, 0.00390625, 0.515625, 0.5546875, 0.9248046875, false, false },
		["pvptalents-list-background"] = { 147, 40, 0.19921875, 0.7734375, 0.1474609375, 0.1865234375, false, false },
		["pvptalents-list-background-mouseover"] = { 147, 40, 0.26171875, 0.8359375, 0.1962890625, 0.2353515625, false, false },
		["pvptalents-list-background-selected"] = { 147, 40, 0.27734375, 0.8515625, 0.251953125, 0.291015625, false, false },
		["pvptalents-list-checkmark"] = { 28, 26, 0.78125, 0.890625, 0.1474609375, 0.1728515625, false, false },
		["pvptalents-selectedarrow"] = { 43, 44, 0.79296875, 0.9609375, 0.455078125, 0.498046875, false, false },
		["pvptalents-talentborder"] = { 58, 58, 0.5234375, 0.75, 0.634765625, 0.69140625, false, false },
		["pvptalents-talentborder-empty"] = { 80, 80, 0.5234375, 0.8359375, 0.5546875, 0.6328125, false, false },
		["pvptalents-talentborder-glow"] = { 68, 68, 0.00390625, 0.26953125, 0.302734375, 0.369140625, false, false },
		["pvptalents-talentborder-locked"] = { 58, 58, 0.7578125, 0.984375, 0.634765625, 0.69140625, false, false },
		["pvptalents-warmode-firecover"] = { 127, 73, 0.00390625, 0.5, 0.9267578125, 0.998046875, false, false },
		["pvptalents-warmode-glow"] = { 105, 110, 0.5234375, 0.93359375, 0.693359375, 0.80078125, false, false },
		["pvptalents-warmode-incentive-ring"] = { 48, 48, 0.00390625, 0.19140625, 0.1474609375, 0.1943359375, false, false },
		["pvptalents-warmode-orb"] = { 80, 84, 0.32421875, 0.63671875, 0.37109375, 0.453125, false, false },
		["pvptalents-warmode-ring"] = { 80, 84, 0.64453125, 0.95703125, 0.37109375, 0.453125, false, false },
		["pvptalents-warmode-ring-disabled"] = { 80, 84, 0.00390625, 0.31640625, 0.37109375, 0.453125, false, false },
		["pvptalents-warmode-swords"] = { 46, 43, 0.75390625, 0.93359375, 0.1015625, 0.1435546875, false, false },
		["pvptalents-warmode-swords-disabled"] = { 46, 43, 0.79296875, 0.97265625, 0.302734375, 0.3447265625, false, false },
		["Talent-Background"] = { 32, 43, 0, 0.125, 0.0185546875, 0.060546875, true, false },
		["Talent-BottomLeftCurlies"] = { 65, 55, 0.5234375, 0.77734375, 0.921875, 0.9755859375, false, false },
		["Talent-BottomRightCurlies"] = { 65, 55, 0.27734375, 0.53125, 0.302734375, 0.3564453125, false, false },
		["Talent-Highlight"] = { 200, 53, 0.00390625, 0.78515625, 0.455078125, 0.5068359375, false, false },
		["Talent-RingWithDot"] = { 121, 120, 0.5234375, 0.99609375, 0.802734375, 0.919921875, false, false },
		["Talent-Selection"] = { 190, 45, 0.00390625, 0.74609375, 0.1015625, 0.1455078125, false, false },
		["Talent-Selection-Legendary"] = { 190, 45, 0.00390625, 0.74609375, 0.5087890625, 0.552734375, false, false },
		["Talent-Separator"] = { 68, 50, 0.00390625, 0.26953125, 0.251953125, 0.30078125, false, false },
		["Talent-TopLeftCurlies"] = { 63, 55, 0.5390625, 0.78515625, 0.302734375, 0.3564453125, false, false },
		["Talent-TopRightCurlies"] = { 64, 55, 0.00390625, 0.25390625, 0.1962890625, 0.25, false, false },
	},
	["interface/talentframe/talents"] = {
		["talents-arrow-head-ghost"] = { 14, 12, 0.94384765625, 0.95751953125, 0.0009765625, 0.0244140625, false, false },
		["talents-arrow-head-gray"] = { 14, 12, 0.95849609375, 0.97216796875, 0.0009765625, 0.0244140625, false, false },
		["talents-arrow-head-locked"] = { 14, 12, 0.97314453125, 0.98681640625, 0.0009765625, 0.0244140625, false, false },
		["talents-arrow-head-red"] = { 14, 12, 0.96630859375, 0.97998046875, 0.0380859375, 0.0615234375, false, false },
		["talents-arrow-head-yellow"] = { 14, 12, 0.98095703125, 0.99462890625, 0.0380859375, 0.0615234375, false, false },
		["talents-background-bottombar"] = { 1612, 82, 0.00048828125, 0.78759765625, 0.0009765625, 0.0810546875, false, false },
		["talents-button-reset"] = { 20, 20, 0.94580078125, 0.96533203125, 0.0380859375, 0.0771484375, false, false },
		["talents-button-undo"] = { 21, 20, 0.92431640625, 0.94482421875, 0.0380859375, 0.0771484375, false, false },
		["talents-gate"] = { 84, 14, 0.00048828125, 0.08251953125, 0.9658203125, 0.9931640625, false, false },
		["talents-gate-open"] = { 84, 14, 0.8837890625, 0.9658203125, 0.0830078125, 0.1103515625, false, false },
		["talents-icon-learnableplus"] = { 19, 18, 0.92431640625, 0.94287109375, 0.0009765625, 0.0361328125, false, false },
		["talents-node-choice-ghost"] = { 60, 52, 0.36865234375, 0.42724609375, 0.1708984375, 0.2724609375, false, false },
		["talents-node-choice-gray"] = { 58, 52, 0.36865234375, 0.42529296875, 0.2744140625, 0.3759765625, false, false },
		["talents-node-choice-green"] = { 58, 52, 0.36865234375, 0.42529296875, 0.3779296875, 0.4794921875, false, false },
		["talents-node-choice-greenglow"] = { 88, 84, 0.13623046875, 0.22216796875, 0.3681640625, 0.5322265625, false, false },
		["talents-node-choice-locked"] = { 58, 52, 0.36865234375, 0.42529296875, 0.4814453125, 0.5830078125, false, false },
		["talents-node-choice-red"] = { 58, 52, 0.36865234375, 0.42529296875, 0.5849609375, 0.6865234375, false, false },
		["talents-node-choice-shadow"] = { 76, 76, 0.693359375, 0.73046875, 0.0830078125, 0.1572265625, false, false },
		
		
		["talents-node-choice-yellow"] = { 58, 52, 0.36865234375, 0.42529296875, 0.6884765625, 0.7900390625, false, false },
		["talents-node-choiceflyout-circle-ghost"] = { 68, 68, 0.13623046875, 0.20263671875, 0.8564453125, 0.9892578125, false, false },
		["talents-node-choiceflyout-circle-gray"] = { 64, 64, 0.09326171875, 0.12451171875, 0.9306640625, 0.9931640625, false, false },
		["talents-node-choiceflyout-circle-green"] = { 64, 64, 0.30517578125, 0.33642578125, 0.9228515625, 0.9853515625, false, false },
		["talents-node-choiceflyout-circle-greenglow"] = { 108, 108, 0.42822265625, 0.48095703125, 0.4814453125, 0.5869140625, false, false },
		["talents-node-choiceflyout-circle-locked"] = { 64, 64, 0.42822265625, 0.45947265625, 0.7958984375, 0.8583984375, false, false },
		["talents-node-choiceflyout-circle-red"] = { 64, 64, 0.42822265625, 0.45947265625, 0.8603515625, 0.9228515625, false, false },
		["talents-node-choiceflyout-circle-shadow"] = { 154, 154, 0.22900390625, 0.30419921875, 0.1708984375, 0.3212890625, false, false },
		["talents-node-choiceflyout-circle-yellow"] = { 64, 64, 0.42822265625, 0.45947265625, 0.9248046875, 0.9873046875, false, false },
		["talents-node-choiceflyout-square-ghost"] = { 76, 76, 0.22900390625, 0.30322265625, 0.3232421875, 0.4716796875, false, false },
		["talents-node-choiceflyout-square-gray"] = { 64, 64, 0.22900390625, 0.29150390625, 0.4736328125, 0.5986328125, false, false },
		["talents-node-choiceflyout-square-green"] = { 64, 64, 0.22900390625, 0.29150390625, 0.6005859375, 0.7255859375, false, false },
		["talents-node-choiceflyout-square-greenglow"] = { 108, 108, 0.00048828125, 0.10595703125, 0.5556640625, 0.7666015625, false, false },
		["talents-node-choiceflyout-square-locked"] = { 64, 64, 0.22900390625, 0.29150390625, 0.7275390625, 0.8525390625, false, false },
		["talents-node-choiceflyout-square-red"] = { 64, 64, 0.22900390625, 0.29150390625, 0.8544921875, 0.9794921875, false, false },
		["talents-node-choiceflyout-square-shadow"] = { 158, 158, 0.13623046875, 0.21337890625, 0.7001953125, 0.8544921875, false, false },
		["talents-node-choiceflyout-square-yellow"] = { 64, 64, 0.30517578125, 0.36767578125, 0.1708984375, 0.2958984375, false, false },
		["talents-node-circle-ghost"] = { 52, 52, 0.42822265625, 0.47900390625, 0.5888671875, 0.6904296875, false, false },
		["talents-node-circle-gray"] = { 40, 40, 0.10693359375, 0.13134765625, 0.5556640625, 0.6044921875, false, false },
		["talents-node-circle-green"] = { 40, 40, 0.10693359375, 0.13134765625, 0.6064453125, 0.6552734375, false, false },
		["talents-node-circle-greenglow"] = { 82, 82, 0.09326171875, 0.13330078125, 0.7685546875, 0.8486328125, false, false },
		["talents-node-circle-locked"] = { 40, 40, 0.10693359375, 0.13134765625, 0.6572265625, 0.7060546875, false, false },
		["talents-node-circle-red"] = { 40, 40, 0.10693359375, 0.13134765625, 0.7080078125, 0.7568359375, false, false },
		["talents-node-circle-shadow"] = { 76, 76, 0.7314453125, 0.7685546875, 0.0830078125, 0.1572265625, false, false },
		["talents-node-circle-yellow"] = { 40, 40, 0.8837890625, 0.908203125, 0.1123046875, 0.1611328125, false, false },
		["talents-node-pvp-filled"] = { 58, 52, 0.36865234375, 0.42529296875, 0.7919921875, 0.8935546875, false, false },
		
		
		["talents-node-pvp-green"] = { 58, 52, 0.36865234375, 0.42529296875, 0.8955078125, 0.9970703125, false, false },
		["talents-node-pvp-inspect"] = { 58, 52, 0.42822265625, 0.48486328125, 0.1708984375, 0.2724609375, false, false },
		
		
		["talents-node-pvp-inspect-empty"] = { 58, 52, 0.42822265625, 0.48486328125, 0.2744140625, 0.3759765625, false, false },
		["talents-node-pvp-locked"] = { 58, 52, 0.42822265625, 0.48486328125, 0.3779296875, 0.4794921875, false, false },
		["talents-node-pvp-shadow"] = { 78, 77, 0.654296875, 0.6923828125, 0.0830078125, 0.158203125, false, false },
		["talents-node-pvpflyout-green"] = { 38, 38, 0.76953125, 0.806640625, 0.0830078125, 0.1572265625, false, false },
		["talents-node-pvpflyout-yellow"] = { 38, 38, 0.8076171875, 0.8447265625, 0.0830078125, 0.1572265625, false, false },
		["talents-node-pvpflyout-yellow-dimmed"] = { 38, 38, 0.845703125, 0.8828125, 0.0830078125, 0.1572265625, false, false },
		["talents-node-square-ghost"] = { 52, 52, 0.42822265625, 0.47900390625, 0.6923828125, 0.7939453125, false, false },
		["talents-node-square-gray"] = { 40, 40, 0.09326171875, 0.13232421875, 0.8505859375, 0.9287109375, false, false },
		["talents-node-square-green"] = { 40, 40, 0.455078125, 0.494140625, 0.0830078125, 0.1611328125, false, false },
		["talents-node-square-greenglow"] = { 84, 84, 0.13623046875, 0.21826171875, 0.5341796875, 0.6982421875, false, false },
		["talents-node-square-locked"] = { 40, 40, 0.4951171875, 0.5341796875, 0.0830078125, 0.1611328125, false, false },
		["talents-node-square-red"] = { 40, 40, 0.53515625, 0.57421875, 0.0830078125, 0.1611328125, false, false },
		["talents-node-square-shadow"] = { 78, 78, 0.615234375, 0.6533203125, 0.0830078125, 0.1591796875, false, false },
		["talents-node-square-yellow"] = { 40, 40, 0.5751953125, 0.6142578125, 0.0830078125, 0.1611328125, false, false },
		["talents-pvpflyout-background-bottom"] = { 276, 36, 0.78857421875, 0.92333984375, 0.0009765625, 0.0361328125, false, false },
		["talents-pvpflyout-background-middle"] = { 276, 482, 0.00048828125, 0.13525390625, 0.0830078125, 0.5537109375, false, false },
		["talents-pvpflyout-background-top"] = { 276, 29, 0.78857421875, 0.92333984375, 0.0380859375, 0.06640625, false, false },
		["talents-pvpflyout-rowhighlight"] = { 276, 44, 0.13623046875, 0.40576171875, 0.0830078125, 0.1689453125, false, false },
		["talents-search-exactmatch"] = { 63, 63, 0.30517578125, 0.36669921875, 0.2978515625, 0.4208984375, false, false },
		["talents-search-match"] = { 63, 63, 0.30517578125, 0.36669921875, 0.4228515625, 0.5458984375, false, false },
		["talents-search-notonactionbar"] = { 63, 63, 0.30517578125, 0.36669921875, 0.5478515625, 0.6708984375, false, false },
		["talents-search-notonactionbarhidden"] = { 63, 63, 0.30517578125, 0.36669921875, 0.6728515625, 0.7958984375, false, false },
		["talents-search-relatedmatch"] = { 63, 63, 0.30517578125, 0.36669921875, 0.7978515625, 0.9208984375, false, false },
		["talents-search-suggestion-itemborder"] = { 18, 18, 0.96630859375, 0.97509765625, 0.0634765625, 0.0810546875, false, false },
		["talents-search-suggestion-magnifyingglass"] = { 12, 12, 0.98779296875, 0.99951171875, 0.0009765625, 0.0244140625, false, false },
		["talents-warmode-indent"] = { 97, 87, 0.40673828125, 0.4541015625, 0.0830078125, 0.16796875, false, false },
		["talents-warmode-ring"] = { 94, 100, 0.00048828125, 0.09228515625, 0.7685546875, 0.9638671875, false, false },
		["talents-warmode-ring-disabled"] = { 94, 100, 0.13623046875, 0.22802734375, 0.1708984375, 0.3662109375, false, false },
	},
	["interface/talentframe/talentsanimations2"] = {
		["talents-animations-activationgrid"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-animations-class-evoker"] = { 461, 461, 0.64013671875, 0.865234375, 0.37939453125, 0.6044921875, false, false },
		["talents-animations-particles"] = { 1308, 774, 0.00048828125, 0.63916015625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsanimations3"] = {
		["talents-animations-class-deathknight"] = { 461, 461, 0.50146484375, 0.7265625, 0.00048828125, 0.2255859375, false, false },
		["talents-animations-class-demonhunter"] = { 461, 461, 0.7275390625, 0.95263671875, 0.00048828125, 0.2255859375, false, false },
		["talents-animations-class-druid"] = { 461, 461, 0.50146484375, 0.7265625, 0.2265625, 0.45166015625, false, false },
		["talents-animations-class-hunter"] = { 461, 461, 0.7275390625, 0.95263671875, 0.2265625, 0.45166015625, false, false },
		["talents-animations-class-mage"] = { 461, 461, 0.00048828125, 0.2255859375, 0.50146484375, 0.7265625, false, false },
		["talents-animations-class-monk"] = { 461, 461, 0.00048828125, 0.2255859375, 0.7275390625, 0.95263671875, false, false },
		["talents-animations-class-paladin"] = { 461, 461, 0.2265625, 0.45166015625, 0.50146484375, 0.7265625, false, false },
		["talents-animations-class-priest"] = { 461, 461, 0.2265625, 0.45166015625, 0.7275390625, 0.95263671875, false, false },
		["talents-animations-class-rogue"] = { 461, 461, 0.45263671875, 0.677734375, 0.50146484375, 0.7265625, false, false },
		["talents-animations-class-shaman"] = { 461, 461, 0.45263671875, 0.677734375, 0.7275390625, 0.95263671875, false, false },
		["talents-animations-class-warlock"] = { 461, 461, 0.6787109375, 0.90380859375, 0.50146484375, 0.7265625, false, false },
		["talents-animations-class-warrior"] = { 461, 461, 0.6787109375, 0.90380859375, 0.7275390625, 0.95263671875, false, false },
		["talents-animations-gridburst"] = { 1024, 1024, 0.00048828125, 0.50048828125, 0.00048828125, 0.50048828125, false, false },
	},
	["interface/talentframe/talentsanimations4"] = {
		["talents-animations-titans"] = { 972, 810, 0.0009765625, 0.9501953125, 0.0009765625, 0.7919921875, false, false },
	},
	["interface/talentframe/talentsanimationsmaskfiligree"] = {
		["talents-animations-mask-filigree"] = { 2048, 1024, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmaskfiligreeactivate"] = {
		["talents-animations-mask-filigree-activate"] = { 2048, 1024, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmaskfull"] = {
		["talents-animations-mask-full"] = { 1024, 1024, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmasknodesheenchoice"] = {
		["talents-node-choice-sheenmask"] = { 64, 64, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmasknodesheenchoiceflyoutcircle"] = {
		["talents-node-choiceflyout-circle-sheenmask"] = { 64, 64, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmasknodesheenchoiceflyoutsquare"] = {
		["talents-node-choiceflyout-square-sheenmask"] = { 64, 64, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmasknodesheencircle"] = {
		["talents-node-circle-sheenmask"] = { 64, 64, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmasknodesheensquare"] = {
		["talents-node-square-sheenmask"] = { 64, 64, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmaskspecart"] = {
		["talents-animations-mask-specart"] = { 2048, 1024, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmaskspecartmid"] = {
		["talents-animations-mask-specart-mid"] = { 2048, 1024, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationssheen"] = {
		["talents-animations-clouds"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-animations-sheen"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsarrowline"] = {
		["talents-arrow-line-ghost"] = { 8, 8, 0, 1, 0.0078125, 0.1328125, true, false },
		["talents-arrow-line-gray"] = { 8, 8, 0, 1, 0.1484375, 0.2734375, true, false },
		["talents-arrow-line-locked"] = { 8, 8, 0, 1, 0.2890625, 0.4140625, true, false },
		["talents-arrow-line-red"] = { 8, 8, 0, 1, 0.5703125, 0.6953125, true, false },
		["talents-arrow-line-yellow"] = { 8, 8, 0, 1, 0.4296875, 0.5546875, true, false },
	},
	["interface/talentframe/talentsmasknodechoice"] = {
		["talents-node-choice-mask"] = { 64, 64, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsmasknodechoiceflyout"] = {
		["talents-node-choiceflyout-mask"] = { 64, 64, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsmasknodechoicehalf"] = {
		["talents-node-choice-mask-half"] = { 64, 64, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsmasknodecircle"] = {
		["talents-node-circle-mask"] = { 64, 64, 0, 1, 0, 1, false, false },
	}
}


addon.Constants.MagicResistances = {
    {
        icon = 136222, --136116
        name = "arcane",
        id = 6,
    },
    {
        icon = 135813,
        name = "fire",
        id = 3,
    },
    {
        icon = 136074,
        name = "nature",
        id = 3,
    },
    {
        icon = 135849,
        name = "frost",
        id = 4,
    },
    {
        icon = 135945,
        name = "shadow",
        id = 5,
    },
}