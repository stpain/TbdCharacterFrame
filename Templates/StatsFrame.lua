

local name , addon = ...;


---Taken from the Blizzard PaperDollFrame.lua file
---Modified to work for my stat frame templates
---@param statFrame frame the frame to modify
---@param unit string the unit to use (mostly always "player")
---@param statIndex integer the statIndex to query
local function TbdCharacterFrame_SetStat(statFrame, unit, statIndex)
	local stat;
	local effectiveStat;
	local posBuff;
	local negBuff;
	stat, effectiveStat, posBuff, negBuff = UnitStat(unit, statIndex);
	statFrame.effectiveStat = effectiveStat;
	local statName = _G["SPELL_STAT"..statIndex.."_NAME"];
	statFrame.label:SetText(format(STAT_FORMAT, statName));

	--statFrame.label:SetText(string.format("%s %s", statName, effectiveStat))
	
	-- Set the tooltip text
	local tooltipText = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, statName).." ";

	if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
		statFrame.text:SetText(effectiveStat);
		statFrame.tooltip = tooltipText..effectiveStat..FONT_COLOR_CODE_CLOSE;
	else 
		tooltipText = tooltipText..effectiveStat;
		if ( posBuff > 0 or negBuff < 0 ) then
			tooltipText = tooltipText.." ("..(stat - posBuff - negBuff)..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 ) then
			tooltipText = tooltipText..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..posBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( negBuff < 0 ) then
			tooltipText = tooltipText..RED_FONT_COLOR_CODE.." "..negBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 or negBuff < 0 ) then
			tooltipText = tooltipText..HIGHLIGHT_FONT_COLOR_CODE..")"..FONT_COLOR_CODE_CLOSE;
		end
		statFrame.tooltip = tooltipText;

		-- If there are any negative buffs then show the main number in red even if there are
		-- positive buffs. Otherwise show in green.
		if ( negBuff < 0 ) then
			statFrame.text:SetText(RED_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE);
		else
			statFrame.text:SetText(GREEN_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE);
		end
	end
	statFrame.tooltip2 = _G["DEFAULT_STAT"..statIndex.."_TOOLTIP"];
	
	if (unit == "player") then
		local _, unitClass = UnitClass("player");
		unitClass = strupper(unitClass);
		
		if ( statIndex == LE_UNIT_STAT_STRENGTH ) then
			local attackPower = GetAttackPowerForStat(statIndex,effectiveStat);
			statFrame.tooltip2 = format(statFrame.tooltip2, attackPower);
		elseif ( statIndex == LE_UNIT_STAT_AGILITY ) then
			local attackPower = GetAttackPowerForStat(statIndex,effectiveStat);
			if ( attackPower > 0 ) then
				statFrame.tooltip2 = format(STAT_TOOLTIP_BONUS_AP, attackPower) .. format(statFrame.tooltip2, GetCritChanceFromAgility("player"));
			else
				statFrame.tooltip2 = format(statFrame.tooltip2, GetCritChanceFromAgility("player"));
			end
		elseif ( statIndex == LE_UNIT_STAT_STAMINA ) then
			local baseStam = min(20, effectiveStat);
			local moreStam = effectiveStat - baseStam;
			statFrame.tooltip2 = format(statFrame.tooltip2, (baseStam + (moreStam*UnitHPPerStamina("player")))*GetUnitMaxHealthModifier("player"));
		elseif ( statIndex == LE_UNIT_STAT_INTELLECT ) then
			if ( UnitHasMana("player") ) then
				local baseInt = min(20, effectiveStat);
				local moreInt = effectiveStat - baseInt
				if (GetOverrideSpellPowerByAP() > 0) then
					statFrame.tooltip2 = format(STAT4_NOSPELLPOWER_TOOLTIP, baseInt + moreInt*MANA_PER_INTELLECT, GetSpellCritChanceFromIntellect("player"));
				else
					statFrame.tooltip2 = format(statFrame.tooltip2, baseInt + moreInt*MANA_PER_INTELLECT, max(0, effectiveStat-10), GetSpellCritChanceFromIntellect("player"));
				end
			else
				statFrame.tooltip2 = STAT_USELESS_TOOLTIP;
			end
		elseif ( statIndex == LE_UNIT_STAT_SPIRIT ) then
			-- All mana regen stats are displayed as mana/5 sec.
			if ( UnitHasMana("player") ) then
				local regen = GetUnitManaRegenRateFromSpirit("player");
				regen = floor( regen * 5.0 );
				statFrame.tooltip2 = format(MANA_REGEN_FROM_SPIRIT, regen);
			else
				statFrame.tooltip2 = STAT_USELESS_TOOLTIP;
			end
		end
	elseif (unit == "pet") then
		if ( statIndex == LE_UNIT_STAT_STRENGTH ) then
			local attackPower = effectiveStat-20;
			statFrame.tooltip2 = format(statFrame.tooltip2, attackPower);
		elseif ( statIndex == LE_UNIT_STAT_AGILITY ) then
			statFrame.tooltip2 = format(statFrame.tooltip2, GetCritChanceFromAgility("pet"));
		elseif ( statIndex == LE_UNIT_STAT_STAMINA ) then
			local expectedHealthGain = (((stat - posBuff - negBuff)-20)*10+20)*GetUnitHealthModifier("pet");
			local realHealthGain = ((effectiveStat-20)*10+20)*GetUnitHealthModifier("pet");
			local healthGain = (realHealthGain - expectedHealthGain)*GetUnitMaxHealthModifier("pet");
			statFrame.tooltip2 = format(statFrame.tooltip2, healthGain);
		elseif ( statIndex == LE_UNIT_STAT_INTELLECT ) then
			if ( UnitHasMana("pet") ) then
				local manaGain = ((effectiveStat-20)*15+20)*GetUnitPowerModifier("pet");
				statFrame.tooltip2 = format(statFrame.tooltip2, manaGain, max(0, effectiveStat-10), GetSpellCritChanceFromIntellect("pet"));
			else
				statFrame.tooltip2 = nil;
			end
		elseif ( statIndex == LE_UNIT_STAT_SPIRIT ) then
			statFrame.tooltip2 = "";
			if ( UnitHasMana("pet") ) then
				statFrame.tooltip2 = format(MANA_REGEN_FROM_SPIRIT, GetUnitManaRegenRateFromSpirit("pet"));
			end
		end
	end
end


local function TbdCharacterFrame_SetStatLabels(f, label, text)
	f.label:SetText(label)
	f.text:SetText(text)
end


local function TbdCharacterFrame_FormatStat(name, base, posBuff, negBuff, frame)
	local effective = max(0,base + posBuff + negBuff);
	local text = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT,name).." "..effective;
	if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
		text = text..FONT_COLOR_CODE_CLOSE;
		frame.text:SetText(effective);
	else 
		if ( posBuff > 0 or negBuff < 0 ) then
			text = text.." ("..base..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 ) then
			text = text..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..posBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( negBuff < 0 ) then
			text = text..RED_FONT_COLOR_CODE.." "..negBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 or negBuff < 0 ) then
			text = text..HIGHLIGHT_FONT_COLOR_CODE..")"..FONT_COLOR_CODE_CLOSE;
		end

		-- if there is a negative buff then show the main number in red, even if there are
		-- positive buffs. Otherwise show the number in green
		if ( negBuff < 0 ) then
			frame.text:SetText(RED_FONT_COLOR_CODE..effective..FONT_COLOR_CODE_CLOSE);
		else
			frame.text:SetText(GREEN_FONT_COLOR_CODE..effective..FONT_COLOR_CODE_CLOSE);
		end
	end
	frame.tooltip = text;
end



addon.StatsSchema = {
    {
        header = STAT_CATEGORY_ATTRIBUTES,
        stats = {
            {
				label = ITEM_MOD_STRENGTH_SHORT,
				update = function(f, unit)
					TbdCharacterFrame_SetStat(f, unit, LE_UNIT_STAT_STRENGTH)
				end,
                onEnter = PaperDollStatTooltip,
			},
            { 
				label = ITEM_MOD_AGILITY_SHORT,
				update = function(f, unit)
					TbdCharacterFrame_SetStat(f, unit, LE_UNIT_STAT_AGILITY)
				end,
                onEnter = PaperDollStatTooltip,
			},
            { 
				label = ITEM_MOD_STAMINA_SHORT,
				update = function(f, unit)
					TbdCharacterFrame_SetStat(f, unit, LE_UNIT_STAT_STAMINA)
				end,
                onEnter = PaperDollStatTooltip,
			},
            { 
				label = ITEM_MOD_INTELLECT_SHORT,
				update = function(f, unit)
					TbdCharacterFrame_SetStat(f, unit, LE_UNIT_STAT_INTELLECT)
				end,
                onEnter = PaperDollStatTooltip,
			},
            { 
				label = ITEM_MOD_SPIRIT_SHORT,
				update = function(f, unit)
					TbdCharacterFrame_SetStat(f, unit, LE_UNIT_STAT_SPIRIT)
				end,
                onEnter = PaperDollStatTooltip,
			},
        },
    },
	{
		header = STAT_CATEGORY_MELEE,
		stats = {
			{
				label = DAMAGE,
				update = function(statFrame, unit)
					local speed, offhandSpeed = UnitAttackSpeed(unit);
	
					local minDamage, maxDamage, minOffHandDamage, maxOffHandDamage, physicalBonusPos, physicalBonusNeg, percent = UnitDamage(unit);
				
					-- remove decimal points for display values
					local displayMin = max(floor(minDamage),1);
					local displayMinLarge = BreakUpLargeNumbers(displayMin);
					local displayMax = max(ceil(maxDamage),1);
					local displayMaxLarge = BreakUpLargeNumbers(displayMax);
				
					-- calculate base damage
					minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
					maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;
				
					local baseDamage = (minDamage + maxDamage) * 0.5;
					local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
					local totalBonus = (fullDamage - baseDamage);
					local damagePerSecond = (max(fullDamage,1) / speed);
					-- set tooltip text with base damage
					local damageTooltip = BreakUpLargeNumbers(max(floor(minDamage),1)).." - "..BreakUpLargeNumbers(max(ceil(maxDamage),1));
					
					local colorPos = "|cff20ff20";
					local colorNeg = "|cffff2020";
				
					-- epsilon check
					if ( totalBonus < 0.1 and totalBonus > -0.1 ) then
						totalBonus = 0.0;
					end
				
					local value;
					if ( totalBonus == 0 ) then
						if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
							value = displayMinLarge.." - "..displayMaxLarge;
						else
							value = displayMinLarge.."-"..displayMaxLarge;
						end
					else
						-- set bonus color and display
						local color;
						if ( totalBonus > 0 ) then
							color = colorPos;
						else
							color = colorNeg;
						end
						if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
							value = color..displayMinLarge.." - "..displayMaxLarge.."|r";
						else
							value = color..displayMinLarge.."-"..displayMaxLarge.."|r";
						end
						if ( physicalBonusPos > 0 ) then
							damageTooltip = damageTooltip..colorPos.." +"..physicalBonusPos.."|r";
						end
						if ( physicalBonusNeg < 0 ) then
							damageTooltip = damageTooltip..colorNeg.." "..physicalBonusNeg.."|r";
						end
						if ( percent > 1 ) then
							damageTooltip = damageTooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
						elseif ( percent < 1 ) then
							damageTooltip = damageTooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
						end
						
					end


					TbdCharacterFrame_SetStatLabels(statFrame, DAMAGE, value);

					statFrame.damage = damageTooltip;
					statFrame.attackSpeed = speed;
					statFrame.dps = damagePerSecond;
					statFrame.unit = unit;
					
					-- If there's an offhand speed then add the offhand info to the tooltip
					if ( offhandSpeed and minOffHandDamage and maxOffHandDamage ) then
						minOffHandDamage = (minOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;
						maxOffHandDamage = (maxOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;
				
						local offhandBaseDamage = (minOffHandDamage + maxOffHandDamage) * 0.5;
						local offhandFullDamage = (offhandBaseDamage + physicalBonusPos + physicalBonusNeg) * percent;
						local offhandDamagePerSecond = (max(offhandFullDamage,1) / offhandSpeed);
						local offhandDamageTooltip = BreakUpLargeNumbers(max(floor(minOffHandDamage),1)).." - "..BreakUpLargeNumbers(max(ceil(maxOffHandDamage),1));
						if ( physicalBonusPos > 0 ) then
							offhandDamageTooltip = offhandDamageTooltip..colorPos.." +"..physicalBonusPos.."|r";
						end
						if ( physicalBonusNeg < 0 ) then
							offhandDamageTooltip = offhandDamageTooltip..colorNeg.." "..physicalBonusNeg.."|r";
						end
						if ( percent > 1 ) then
							offhandDamageTooltip = offhandDamageTooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
						elseif ( percent < 1 ) then
							offhandDamageTooltip = offhandDamageTooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
						end
						statFrame.offhandDamage = offhandDamageTooltip;
						statFrame.offhandAttackSpeed = offhandSpeed;
						statFrame.offhandDps = offhandDamagePerSecond;
					else
						statFrame.offhandAttackSpeed = nil;
					end
					
					statFrame:SetScript("OnEnter", CharacterDamageFrame_OnEnter);
				end,
                --onEnter = PaperDollStatTooltip,
			},
			{
				label = STAT_DPS_SHORT,
				update = function(statFrame, unit)
                    local speed, offhandSpeed = UnitAttackSpeed(unit);
	
                    local minDamage;
                    local maxDamage; 
                    local minOffHandDamage;
                    local maxOffHandDamage; 
                    local physicalBonusPos;
                    local physicalBonusNeg;
                    local percent;
                    minDamage, maxDamage, minOffHandDamage, maxOffHandDamage, physicalBonusPos, physicalBonusNeg, percent = UnitDamage(unit);
                    local displayMin = max(floor(minDamage),1);
                    local displayMax = max(ceil(maxDamage),1);
                
                    minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
                    maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;
                
                    local baseDamage = (minDamage + maxDamage) * 0.5;
                    local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
                    local totalBonus = (fullDamage - baseDamage);
                    local damagePerSecond = (max(fullDamage,1) / speed);
                    local damageTooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
                    
                    local colorPos = "|cff20ff20";
                    local colorNeg = "|cffff2020";
                    local text;
                
                    -- epsilon check
                    if ( totalBonus < 0.1 and totalBonus > -0.1 ) then
                        totalBonus = 0.0;
                    end
                
                    if ( totalBonus == 0 ) then
                        text = format("%.1F", damagePerSecond);
                    else
                        local color;
                        if ( totalBonus > 0 ) then
                            color = colorPos;
                        else
                            color = colorNeg;
                        end
                        text = color..format("%.1F", damagePerSecond).."|r";
                    end
                    
                    -- If there's an offhand speed then add the offhand info
                    if ( offhandSpeed ) then
                        minOffHandDamage = (minOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;
                        maxOffHandDamage = (maxOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;
                
                        local offhandBaseDamage = (minOffHandDamage + maxOffHandDamage) * 0.5;
                        local offhandFullDamage = (offhandBaseDamage + physicalBonusPos + physicalBonusNeg) * percent;
                        local offhandDamagePerSecond = (max(offhandFullDamage,1) / offhandSpeed);
                        local offhandTotalBonus = (offhandFullDamage - offhandBaseDamage);
                        
                        -- epsilon check
                        if ( offhandTotalBonus < 0.1 and offhandTotalBonus > -0.1 ) then
                            offhandTotalBonus = 0.0;
                        end
                        local separator = " / ";
                        if (damagePerSecond > 1000 and offhandDamagePerSecond > 1000) then
                            separator = "/";
                        end
                        if ( offhandTotalBonus == 0 ) then
                            text = text..separator..format("%.1F", offhandDamagePerSecond);
                        else
                            local color;
                            if ( offhandTotalBonus > 0 ) then
                                color = colorPos;
                            else
                                color = colorNeg;
                            end
                            text = text..separator..color..format("%.1F", offhandDamagePerSecond).."|r";	
                        end
                    end
                    
                    --statFrame.Value:SetText(text);
                    TbdCharacterFrame_SetStatLabels(statFrame, DAMAGE_PER_SECOND, text)
                    statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..DAMAGE_PER_SECOND..FONT_COLOR_CODE_CLOSE;
				end,
                onEnter = PaperDollStatTooltip,
			},
            {
                label = MELEE_ATTACK_POWER,
                update = function(statFrame, unit)
                    local base, posBuff, negBuff = UnitAttackPower(unit);

                    TbdCharacterFrame_FormatStat(MELEE_ATTACK_POWER, base, posBuff, negBuff, statFrame);
                    local damageBonus = max((base+posBuff+negBuff), 0)/ATTACK_POWER_MAGIC_NUMBER;
                    local effectiveAP = max(0,base + posBuff + negBuff);
                    if (GetOverrideSpellPowerByAP() > 0) then
                        statFrame.tooltip2 = format(MELEE_ATTACK_POWER_SPELL_POWER_TOOLTIP, damageBonus, effectiveAP * GetOverrideSpellPowerByAP() + 0.5);
                    else
                        statFrame.tooltip2 = format(MELEE_ATTACK_POWER_TOOLTIP, damageBonus);
                    end
                end,
                onEnter = PaperDollStatTooltip
            },
			{
				label = ATTACK_SPEED,
				update = function(statFrame, unit)
					local speed, offhandSpeed = UnitAttackSpeed(unit);

					local displaySpeed = format("%.2F", speed);
					if ( offhandSpeed ) then
						offhandSpeed = format("%.2F", offhandSpeed);
					end
					if ( offhandSpeed ) then
						displaySpeed =  displaySpeed.." / ".. offhandSpeed;
					end
					TbdCharacterFrame_SetStatLabels(statFrame, WEAPON_SPEED, displaySpeed) --, false, speed);
				
					statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, ATTACK_SPEED).." "..displaySpeed..FONT_COLOR_CODE_CLOSE;
				end,
				onEnter = PaperDollStatTooltip
			},
			{
				label = STAT_HASTE,
				update = function(statFrame, unit)
					if ( unit ~= "player" ) then
						statFrame:Hide();
						return;
					end
					
					local haste = GetMeleeHaste();
					if (haste < 0) then
						haste = RED_FONT_COLOR_CODE..format("%.2F%%", haste)..FONT_COLOR_CODE_CLOSE;
					else
						haste = "+"..format("%.2F%%", haste);
					end
					
					-- _G[statFrame:GetName().."Label"]:SetText(format(STAT_FORMAT, STAT_HASTE));	
					-- local text = _G[statFrame:GetName().."StatText"];
					-- text:SetText(haste);

					TbdCharacterFrame_SetStatLabels(statFrame, STAT_HASTE, haste)
					statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_HASTE) .. " " .. haste .. FONT_COLOR_CODE_CLOSE;
					
					local _, class = UnitClass(unit);	
					statFrame.tooltip2 = _G["STAT_HASTE_MELEE_"..class.."_TOOLTIP"];
					if (not statFrame.tooltip2) then
						statFrame.tooltip2 = STAT_HASTE_MELEE_TOOLTIP;
					end
					statFrame.tooltip2 = statFrame.tooltip2 .. format(STAT_HASTE_BASE_TOOLTIP, GetCombatRating(CR_HASTE_MELEE), GetCombatRatingBonus(CR_HASTE_MELEE));
				end,
				onEnter = PaperDollStatTooltip
			},
			{
				label = STAT_RUNE_REGEN,
				update = function(statFrame, unit)
					-- if ( unit ~= "player" ) then
					-- 	statFrame:Hide();
					-- 	return;
					-- end
					
					-- local _, class = UnitClass(unit);
					-- if (class ~= "DEATHKNIGHT") then
					-- 	statFrame:Hide();
					-- 	return;
					-- end
					
					local _, regenRate = GetRuneCooldown(1); -- Assuming they are all the same for now
					local regenRateText = (format(STAT_RUNE_REGEN_FORMAT, regenRate));
					TbdCharacterFrame_SetStatLabels(statFrame, STAT_RUNE_REGEN, regenRateText) --, false, regenRate);
					statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_RUNE_REGEN).." "..regenRateText..FONT_COLOR_CODE_CLOSE;
					statFrame.tooltip2 = STAT_RUNE_REGEN_TOOLTIP;
				end,
				onEnter = PaperDollStatTooltip
			},
			{
				label = STAT_HIT_CHANCE,
				update = function(statFrame, unit)
					-- if ( unit ~= "player" ) then
					-- 	statFrame:Hide();
					-- 	return;
					-- end
					

					local hitChance = GetCombatRatingBonus(CR_HIT_MELEE) + GetHitModifier();
					if (hitChance >= 0) then
						hitChance = format("+%.2F%%", hitChance);
					else
						hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
					end

					TbdCharacterFrame_SetStatLabels(statFrame, STAT_HIT_CHANCE, hitChance)
					--statFrame:SetScript("OnEnter", MeleeHitChance_OnEnter);
				end,
				onEnter = MeleeHitChance_OnEnter
			},
			{
				label = MELEE_CRIT_CHANCE,
				update = function(statFrame, unit)

					local critChance = GetCritChance();
					critChance = format("%.2F%%", critChance);
					TbdCharacterFrame_SetStatLabels(statFrame, MELEE_CRIT_CHANCE, critChance)
					statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, MELEE_CRIT_CHANCE).." "..critChance..FONT_COLOR_CODE_CLOSE;
					statFrame.tooltip2 = format(CR_CRIT_MELEE_TOOLTIP, GetCombatRating(CR_CRIT_MELEE), GetCombatRatingBonus(CR_CRIT_MELEE));
				end,
				onEnter = PaperDollStatTooltip,
			},
			{
				label = STAT_EXPERTISE,
				update = function(statFrame, unit)

					local expertisePct, offhandExpertisePct = GetExpertise();
					local speed, offhandSpeed = UnitAttackSpeed(unit);
					local text;
					if( offhandSpeed ) then
						text = expertisePct.." / "..offhandExpertisePct;
					else
						text = expertisePct;
					end
					TbdCharacterFrame_SetStatLabels(statFrame, STAT_EXPERTISE, text) --, true, expertisePct);
				end,
				onEnter = Expertise_OnEnter,
			},
			{
				label = STAT_MASTERY,
				update = function(statFrame, unit)

					local mastery = GetMastery();
					mastery = format("%.2F", mastery);
					TbdCharacterFrame_SetStatLabels(statFrame, STAT_MASTERY, mastery) --, true, expertisePct);
				end,
				onEnter = Mastery_OnEnter
				,
			},
		}
	},
	{
		header = STAT_CATEGORY_RANGED,
		stats = {
			{
				label = DAMAGE,
				update = function(statFrame, unit)
					-- If no ranged attack then set to n/a
					local hasRelic = UnitHasRelicSlot(unit);	
					local rangedTexture = GetInventoryItemTexture("player", 18);
					if ( rangedTexture and not hasRelic ) then
						PaperDollFrame.noRanged = nil;
					else
						statFrame.text:SetText(NOT_APPLICABLE);
						PaperDollFrame.noRanged = 1;
						statFrame.damage = nil;
						return;
					end

					local rangedAttackSpeed, minDamage, maxDamage, physicalBonusPos, physicalBonusNeg, percent = UnitRangedDamage(unit);
					
					-- Round to the third decimal place (i.e. 99.9 percent)
					percent = math.floor(percent  * 10^3 + 0.5) / 10^3
					local displayMin = max(floor(minDamage),1);
					local displayMax = max(ceil(maxDamage),1);

					local baseDamage;
					local fullDamage;
					local totalBonus;
					local damagePerSecond;
					local tooltip;

					if ( HasWandEquipped() ) then
						baseDamage = (minDamage + maxDamage) * 0.5;
						fullDamage = baseDamage * percent;
						totalBonus = 0;
						if( rangedAttackSpeed == 0 ) then
							damagePerSecond = 0;
						else
							damagePerSecond = (max(fullDamage,1) / rangedAttackSpeed);
						end
						tooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
					else
						minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
						maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;

						baseDamage = (minDamage + maxDamage) * 0.5;
						fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
						totalBonus = (fullDamage - baseDamage);
						if( rangedAttackSpeed == 0 ) then
							damagePerSecond = 0;
						else
							damagePerSecond = (max(fullDamage,1) / rangedAttackSpeed);
						end
						tooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
					end

					if ( totalBonus == 0 ) then
						if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
							statFrame.text:SetText(displayMin.." - "..displayMax);	
						else
							statFrame.text:SetText(displayMin.."-"..displayMax);
						end
					else
						local colorPos = "|cff20ff20";
						local colorNeg = "|cffff2020";
						local color;
						if ( totalBonus > 0 ) then
							color = colorPos;
						else
							color = colorNeg;
						end
						if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
							statFrame.text:SetText(color..displayMin.." - "..displayMax.."|r");	
						else
							statFrame.text:SetText(color..displayMin.."-"..displayMax.."|r");
						end
						if ( physicalBonusPos > 0 ) then
							tooltip = tooltip..colorPos.." +"..physicalBonusPos.."|r";
						end
						if ( physicalBonusNeg < 0 ) then
							tooltip = tooltip..colorNeg.." "..physicalBonusNeg.."|r";
						end
						if ( percent > 1 ) then
							tooltip = tooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
						elseif ( percent < 1 ) then
							tooltip = tooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
						end
						statFrame.tooltip = tooltip.." "..format(DPS_TEMPLATE, damagePerSecond);
					end
					statFrame.attackSpeed = rangedAttackSpeed;
					statFrame.damage = tooltip;
					statFrame.dps = damagePerSecond;
				end,
				onEnter = CharacterRangedDamageFrame_OnEnter,
			},
			{
				label = STAT_DPS_SHORT,
				update = function(statFrame, unit)
					-- If no ranged attack then set to n/a
					local hasRelic = UnitHasRelicSlot(unit);	
					local rangedTexture = GetInventoryItemTexture("player", 18);
					if ( rangedTexture and not hasRelic ) then
						PaperDollFrame.noRanged = nil;
					else
						statFrame.text:SetText(NOT_APPLICABLE);
						PaperDollFrame.noRanged = 1;
						statFrame.damage = nil;
						return;
					end

					local rangedAttackSpeed, minDamage, maxDamage, physicalBonusPos, physicalBonusNeg, percent = UnitRangedDamage(unit);
					
					-- Round to the third decimal place (i.e. 99.9 percent)
					percent = math.floor(percent  * 10^3 + 0.5) / 10^3
					local displayMin = max(floor(minDamage),1);
					local displayMax = max(ceil(maxDamage),1);

					local baseDamage;
					local fullDamage;
					local totalBonus;
					local damagePerSecond;
					local tooltip;

					if ( HasWandEquipped() ) then
						baseDamage = (minDamage + maxDamage) * 0.5;
						fullDamage = baseDamage * percent;
						totalBonus = 0;
						if( rangedAttackSpeed == 0 ) then
							damagePerSecond = 0;
						else
							damagePerSecond = (max(fullDamage,1) / rangedAttackSpeed);
						end
						tooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
					else
						minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
						maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;

						baseDamage = (minDamage + maxDamage) * 0.5;
						fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
						totalBonus = (fullDamage - baseDamage);
						if( rangedAttackSpeed == 0 ) then
							damagePerSecond = 0;
						else
							damagePerSecond = (max(fullDamage,1) / rangedAttackSpeed);
						end
						tooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
					end

					if ( totalBonus == 0 ) then
						statFrame.text:SetText( format("%.1F", damagePerSecond));
					else
						local colorPos = "|cff20ff20";
						local colorNeg = "|cffff2020";
						local color;
						if ( totalBonus > 0 ) then
							color = colorPos;
						else
							color = colorNeg;
						end
						statFrame.text:SetText(color..format("%.1F", damagePerSecond).."|r");
						if ( physicalBonusPos > 0 ) then
							tooltip = tooltip..colorPos.." +"..physicalBonusPos.."|r";
						end
						if ( physicalBonusNeg < 0 ) then
							tooltip = tooltip..colorNeg.." "..physicalBonusNeg.."|r";
						end
						if ( percent > 1 ) then
							tooltip = tooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
						elseif ( percent < 1 ) then
							tooltip = tooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
						end
						--statFrame.tooltip2 = tooltip.." "..format(DPS_TEMPLATE, damagePerSecond);
					end

					statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..DAMAGE_PER_SECOND..FONT_COLOR_CODE_CLOSE;
				end,
				onEnter = PaperDollStatTooltip
			},
			{
				label = STAT_ATTACK_POWER,
				update = function(statFrame, unit)
					local base, posBuff, negBuff = UnitRangedAttackPower(unit);

					TbdCharacterFrame_FormatStat(RANGED_ATTACK_POWER, base, posBuff, negBuff, statFrame);
					local totalAP = base+posBuff+negBuff;
					statFrame.tooltip2 = format(RANGED_ATTACK_POWER_TOOLTIP, max((totalAP), 0)/ATTACK_POWER_MAGIC_NUMBER);
					local petAPBonus = ComputePetBonus( "PET_BONUS_RAP_TO_AP", totalAP );
					if( petAPBonus > 0 ) then
						statFrame.tooltip2 = statFrame.tooltip2 .. "\n" .. format(PET_BONUS_TOOLTIP_RANGED_ATTACK_POWER, petAPBonus);
					end
					
					local petSpellDmgBonus = ComputePetBonus( "PET_BONUS_RAP_TO_SPELLDMG", totalAP );
					if( petSpellDmgBonus > 0 ) then
						statFrame.tooltip2 = statFrame.tooltip2 .. "\n" .. format(PET_BONUS_TOOLTIP_SPELLDAMAGE, petSpellDmgBonus);
					end
				end,
				onEnter = PaperDollStatTooltip
			},
			{
				label = WEAPON_SPEED,
				update = function(statFrame, unit)
					local base, posBuff, negBuff = UnitRangedAttackPower(unit);

					local displaySpeed;

					-- If no ranged attack then set to n/a
					if ( PaperDollFrame.noRanged ) then
						displaySpeed = NOT_APPLICABLE;
						statFrame.tooltip = nil;
					else
						local attackTime, _, _, _, _, _ = UnitRangedDamage(unit);
						displaySpeed = format("%.2F", attackTime);
						statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, ATTACK_SPEED).." "..displaySpeed..FONT_COLOR_CODE_CLOSE;
					end
					TbdCharacterFrame_SetStatLabels(statFrame, WEAPON_SPEED, displaySpeed) --, false, attackTime);
				end,
				onEnter = PaperDollStatTooltip
			},
			{
				label = STAT_HASTE,
				update = function(statFrame, unit)
					local haste = GetRangedHaste();
					if (haste < 0) then
						haste = RED_FONT_COLOR_CODE..format("%.2F%%", haste)..FONT_COLOR_CODE_CLOSE;
					else
						haste = "+"..format("%.2F%%", haste);
					end
					
					statFrame.text:SetText(haste);
					statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_HASTE) .. " " .. haste .. FONT_COLOR_CODE_CLOSE;
				
					local _, class = UnitClass(unit);	
					statFrame.tooltip2 = _G["STAT_HASTE_RANGED_"..class.."_TOOLTIP"];
					if (not statFrame.tooltip2) then
						statFrame.tooltip2 = STAT_HASTE_RANGED_TOOLTIP;
					end
					statFrame.tooltip2 = statFrame.tooltip2 .. format(STAT_HASTE_BASE_TOOLTIP, GetCombatRating(CR_HASTE_RANGED), GetCombatRatingBonus(CR_HASTE_RANGED));
				end,
				onEnter = PaperDollStatTooltip
			},
			{
				label = STAT_HIT_CHANCE,
				update = function(statFrame, unit)
					local hitChance = GetCombatRatingBonus(CR_HIT_RANGED) + GetHitModifier();
					if (hitChance >= 0) then
						hitChance = format("+%.2F%%", hitChance);
					else
						hitChance = RED_FONT_COLOR_CODE..format("%.2F%%", hitChance)..FONT_COLOR_CODE_CLOSE;
					end
					TbdCharacterFrame_SetStatLabels(statFrame, STAT_HIT_CHANCE, hitChance)
				end,
				onEnter = RangedHitChance_OnEnter
			},
			{
				label = RANGED_CRIT_CHANCE,
				update = function(statFrame, unit)

					local critChance = GetRangedCritChance();
					critChance = format("%.2F%%", critChance);

					statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, RANGED_CRIT_CHANCE).." "..critChance..FONT_COLOR_CODE_CLOSE;
					statFrame.tooltip2 = format(CR_CRIT_RANGED_TOOLTIP, GetCombatRating(CR_CRIT_RANGED), GetCombatRatingBonus(CR_CRIT_RANGED));

					TbdCharacterFrame_SetStatLabels(statFrame, RANGED_CRIT_CHANCE, critChance)
				end,
				onEnter = PaperDollStatTooltip
			}
		}
	}
}



TbdCharacterFrameStatsFrameMixin = {}
function TbdCharacterFrameStatsFrameMixin:OnLoad()

end
function TbdCharacterFrameStatsFrameMixin:OnLeave()
    GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
end
function TbdCharacterFrameStatsFrameMixin:SetDataBinding(binding, height)
    self:SetHeight(height)
    if binding.init then
        binding.init(self)
    end
    if binding.fontObject then
        self.label:SetFontObject(binding.fontObject)
    end
    if binding.label then
        self.label:SetText(binding.label)
    end
    if binding.text then
        self.text:SetText(binding.text)
    end
    if binding.fontColour then
        self.label:SetTextColor(binding.fontColour:GetRGB())
    end
    if binding.onEnter then
        self:SetScript("OnEnter", binding.onEnter)
    end
    if binding.onMouseDown then
        self:HookScript("OnMouseDown", binding.onMouseDown)
    end
end
function TbdCharacterFrameStatsFrameMixin:ResetDataBinding()
    
end