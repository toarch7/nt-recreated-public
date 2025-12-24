globalvar crownmax, crown_name, crown_text, crown_tips, crown_sond;

enum Crown {
    Random = 0,
    None = 1,
    Death = 2,
    Life = 3,
    Haste = 4,
    Guns = 5,
    Hatred = 6,
    Blood = 7,
    Destiny = 8,
    Love = 9,
    Luck = 10,
    Curses = 11,
    Risk = 12,
    Protection = 13
}

function scrCrowns() {
    crown_name[0] = "RANDOM"
    crown_text[0] = "???"
    crown_tips[0] = ""
    crown_sond[0] = sndCrownRandom

    crown_name[1] = "NO CROWN"
    crown_text[1] = "A BARE HEAD#IS A FAIR HEAD"
    crown_tips[1] = ""
    crown_sond[1] = sndCrownNo

    crown_name[2] = "CROWN OF DEATH"
    crown_text[2] = "BIGGER @wEXPLOSIONS#@s-1 @rMAX HP@s"
    crown_tips[2] = choose("boom", "health is important")
    crown_sond[2] = sndCrownDeath

    crown_name[3] = "CROWN OF LIFE"
    crown_text[3] = "NO @rHP DROPS@s#@rBIG HP CHESTS@s MORE COMMON"
    crown_tips[3] = "heart matters"
    crown_sond[3] = sndCrownLife

    crown_name[4] = "CROWN OF HASTE"
    crown_text[4] = "@wPICKUPS@s FADE FAST#ARE WORTH MORE"
    crown_tips[4] = "no time for jokes"
    crown_sond[4] = sndCrownHaste

    crown_name[5] = "CROWN OF GUNS"
    crown_text[5] = "NO @yAMMO DROPS@s#MORE @wWEAPON DROPS"
    crown_tips[5] = "guns are your friend"
    crown_sond[5] = sndCrownGuns

    crown_name[6] = "CROWN OF HATRED"
    crown_text[6] = "TAKE @wDAMAGE@s AND GAIN @gRADS@s#WHEN OPENING @wCHESTS@s"
    crown_tips[6] = "something is wrong"
    crown_sond[6] = sndCrownHatred

    crown_name[7] = "CROWN OF BLOOD"
    crown_text[7] = "MORE @wENEMIES@s#FEWER @gRADS@s"
    crown_tips[7] = choose("get ready", "bring it")
    crown_sond[7] = sndCrownBlood

    crown_name[8] = "CROWN OF DESTINY"
    crown_text[8] = "FREE @gMUTATION@s#NARROW FUTURE"
    crown_tips[8] = "no such thing as free will"
    crown_sond[8] = sndCrownDestiny

    crown_name[9] = "CROWN OF LOVE"
    crown_text[9] = "@yAMMO@s CHESTS ONLY"
    crown_tips[9] = "you really like these @wweapons@s"
    crown_sond[9] = sndCrownLove

    crown_name[10] = "CROWN OF LUCK"
    crown_text[10] = "START @wAREAS@s AT 1 @rHP@s#CHANCE @wENEMIES@s HAVE 1 @rHP@s"
    crown_tips[10] = choose("the future brings death", "it's all the same")
    crown_sond[10] = sndCrownLuck

    crown_name[11] = "CROWN OF CURSES"
    crown_text[11] = "A LOT MORE @pCURSED CHESTS@s"
    crown_tips[11] = "why"
    crown_sond[11] = sndCrownCurses

    crown_name[12] = "CROWN OF RISK"
    crown_text[12] = "MORE @wDROPS@s WHEN AT FULL @rHP@s#LESS @wDROPS@s WHEN NOT"
    crown_tips[12] = "good"
    crown_sond[12] = sndCrownRisk

    crown_name[13] = "CROWN OF PROTECTINON"
    crown_text[13] = "@wWEAPONS@s CONTAIN @rHP@s#INSTEAD OF @yAMMO@s"
    crown_tips[13] = "safety first"
    crown_sond[13] = sndCrownProtection

    crownmax = 13
}

/// @function scrCrownApplyEquipEffect
/// @param {Real|Enum.Crown} crown_id
/// @pram is_equipped
function scrCrownApplyEquipEffect(_crown_id, _is_equipped) {
	var _effect = _is_equipped ? 1 : -1
	
	with GameCont {
		// on-equip and on-unequip effects
		switch _crown_id {
			case Crown.Death:
				with Player {
					max_hp -= _effect
					hp = max(1, hp - _effect)
					lsthealth = hp
				}
				break
			case Crown.Haste:
				scrAmmoUpdateTypeStats()
				break
		}
		
		// only on-equip effects
		if _is_equipped {
			switch _crown_id {
				case Crown.Destiny:
					if !destiny {
						codpick = true
						skillpoints += 1
						destiny = true
						
						if instance_exists(LevCont) {
							scrSavegameSave()
						}
					}
					break
			}
		}
	}
}

/// @function scrCrownUnlock
/// @param {Real|Enum.Race} race_id
/// @param {Real|Enum.Crown} crown_id
function scrCrownUnlock(_race_id, _crown_id) {
	if (scr_loadout_race_is_crown_unlocked(_race_id, _crown_id)
	|| !scr_loadout_is_available_for_race(_race_id))
		return false
	
	scr_loadout_race_unlock_crown(_race_id, _crown_id)
	
    scrShowUnlockPopup(loc_sfmt("@w%@s UNLOCKED#FOR @w%",
		loc(scr_crown_get_name(_crown_id)), loc(scrRaceGetName(_race_id))))
    
	scrSave()
	
	return true
}

function scr_crown_is_valid(_crown) {
	return is_numeric(_crown) && _crown >= 0 && _crown <= crownmax
}

function scr_crown_get_name(_crown) {
	return scr_crown_is_valid(_crown) ? crown_name[_crown] : ("CROWN" + string(_crown))
}

function scr_crown_get_text(_crown) {
	return scr_crown_is_valid(_crown) ? crown_text[_crown] : ""
}

function scr_crown_get_tips(_crown) {
	return scr_crown_is_valid(_crown) ? crown_tips[_crown] : ""
}

function scr_crown_get_sound(_crown) {
	return scr_crown_is_valid(_crown) ? crown_sond[_crown] : -1
}
