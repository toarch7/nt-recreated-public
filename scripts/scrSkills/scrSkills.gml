globalvar skill_name, skill_text, skill_msnd, skill_tips, maxskill;

function scrSkills() {
    skill_name[0] = ""
    skill_text[0] = ""
    skill_msnd[0] = sndMut
    skill_tips[0] = ""

    skill_name[1] = "RHINO SKIN"
    skill_text[1] = "+4 @rMAX HP"
    skill_msnd[1] = sndMutRhinoSkin
    skill_tips[1] = "thick skin"

    skill_name[2] = "EXTRA FEET"
    skill_text[2] = "MORE @wSPEED#@sWALK NORMALY ON ALL TERRAIN"
    skill_msnd[2] = sndMutExtraFeet
    skill_tips[2] = "run forever"

    skill_name[3] = "PLUTONIUM HUNGER"
    skill_text[3] = "ATTRACT @wDROPS@s AND @gRADS@s FROM FURTHER"
    skill_msnd[3] = sndMutPlutoniumHunger
    skill_tips[3] = "need those rads"

    skill_name[4] = "RABBIT PAW"
    skill_text[4] = "MORE @rHP@s AND @yAMMO@s DROPS"
    skill_msnd[4] = sndMutRabbitPaw
    skill_tips[4] = "feeling lucky"

    skill_name[5] = "THRONE BUTT"
    skill_text[5] = "UPGRADES YOUR @wSPECIAL ABILITY"
	skill_msnd[5] = sndMutThroneButt
    skill_tips[5] = "sit on the throne"

    skill_name[6] = "LUCKY SHOT"
    skill_text[6] = "SOME KILLS REGENERATE @yAMMO"
    skill_msnd[6] = sndMutLuckyShot
    skill_tips[6] = "AMMO everywhere"

    skill_name[7] = "BLOODLUST"
    skill_text[7] = "SOME KILLS REGENERATE @rHP"
    skill_msnd[7] = sndMutBloodLust
    skill_tips[7] = "drink blood"

    skill_name[8] = "GAMMA GUTS"
    skill_text[8] = "@wENEMIES@s TOUCHING YOU TAKE DAMAGE"
    skill_msnd[8] = sndMutGammaGuts
    skill_tips[8] = "skin glows"

    skill_name[9] = "SECOND STOMACH"
    skill_text[9] = "MORE @rHP@s FROM MEDKITS"
    skill_msnd[9] = sndMutSecondStomach
    skill_tips[9] = "stomach rumbles"

    skill_name[10] = "BACK MUSCLE"
    skill_text[10] = "HIGHER @yAMMO@s MAX"
    skill_msnd[10] = sndMutBackMuscle
    skill_tips[10] = "great strength"

    skill_name[11] = "SCARIER FACE"
    skill_text[11] = "LESS @wENEMY @rHP"
    skill_msnd[11] = sndMutScarierFace
    skill_tips[11] = "mirrors will break"

    skill_name[12] = "EUPHORIA"
    skill_text[12] = "SLOWER @wENEMY@s BULLETS"
    skill_msnd[12] = sndMutEuphoria
    skill_tips[12] = "time passes slowly"

    skill_name[13] = "LONG ARMS"
    skill_text[13] = "MORE @wMELEE@s RANGE"
    skill_msnd[13] = sndMutLongArms
    skill_tips[13] = "more reach"

    skill_name[14] = "BOILING VEINS"
    skill_text[14] = "@wNO DAMAGE@s FROM EXPLOSIONS AND FIRE#WHEN UNDER 4 @rHP"
    skill_msnd[14] = sndMutBoilingVeins
    skill_tips[14] = "temperature is rising"

    skill_name[15] = "SHOTGUN SHOULDERS"
    skill_text[15] = "@wSHELLS@s BOUNCE FURTHER"
    skill_msnd[15] = sndMutShotgunFingers
    skill_tips[15] = "shells are friends"

    skill_name[16] = "RECYCLE GLANDS"
    skill_text[16] = "MOST HIT @wBULLETS@s BECOME @yAMMO"
    skill_msnd[16] = sndMutRecycleGland
    skill_tips[16] = "no need to aim"

    skill_name[17] = "LASER BRAIN"
    skill_text[17] = "@wENERGY@s WEAPONS DEAL MORE @wDAMAGE@s"
    skill_msnd[17] = sndMutLaserBrain
    skill_tips[17] = "neurons everywhere"

    skill_name[18] = "LAST WISH"
    skill_text[18] = "GET FULL @rHEALTH @sAND SOME @yAMMO"
    skill_msnd[18] = sndMutLastWish
    skill_tips[18] = "listen"

    skill_name[19] = "EAGLE EYES"
    skill_text[19] = "BETTER ACCURACY"
    skill_msnd[19] = sndMutEagleEyes
    skill_tips[19] = "every shot connects"

    skill_name[20] = "IMPACT WRISTS"
    skill_text[20] = "CORPSES FLY & HIT HARDER"
    skill_msnd[20] = sndMutImpactWrists
    skill_tips[20] = "see them fly"

    skill_name[21] = "BOLT MARROW"
    skill_text[21] = "HOMING @wBOLTS"
    skill_msnd[21] = sndMutBoltMarrow
    skill_tips[21] = "bolts everywhere"

    skill_name[22] = "STRESS"
    skill_text[22] = "HIGHER RATE OF FIRE#AS @rHP@s GETS LOWER"
    skill_msnd[22] = sndMutStress
    skill_tips[22] = "shaking"

    skill_name[23] = "TRIGGER FINGERS"
    skill_text[23] = "KILLS LOWER YOUR RELOAD TIME"
    skill_msnd[23] = sndMutTriggerFingers
    skill_tips[23] = ""

    skill_name[24] = "SHARP TEETH"
    skill_text[24] = "DAMAGE TAKEN IS DEALT TO#ALL ENEMIES ON SCREEN"
    skill_msnd[24] = sndMutSharpTeeth
    skill_tips[24] = ""

    skill_name[25] = "PATIENCE"
    skill_text[25] = "@gMUTATE@s LATER"
    skill_msnd[25] = sndMutPatience
    skill_tips[25] = ""

    skill_name[26] = "HAMMER HEAD"
    skill_text[26] = "BREAK TROUGH LIMITED AMOUNT OF WALLS"
    skill_msnd[26] = sndMutHammerhead
    skill_tips[26] = ""

    skill_name[27] = "STRONG SPIRIT"
    skill_text[27] = "PREVENT DEATH ONCE#RECHARGE AT FULL @rHP@s IN NEXT LEVEL"
    skill_msnd[27] = sndMutStrongSpirit
    skill_tips[27] = "NOT TODAY"

    skill_name[28] = "OPEN MIND"
    skill_text[28] = "EXTRA CHEST SPAWN"
    skill_msnd[28] = sndMutOpenMind
    skill_tips[28] = "DID YOU WAIT FOR IT?"

    skill_name[29] = "HEAVY HEART"
    skill_text[29] = "MORE WEAPON DROPS"
    skill_msnd[29] = sndMutHeavyHeart
    skill_tips[29] = ""

    maxskill = 29
	
	if instance_exists(Player) && instance_exists(GameCont) {
        var _thronebutt_text = ""
		
        if instance_exists(CoopController) {
			with Player {
				var _race_name = loc(scrRaceGetName(race)),
					_butt_text = loc(scrRaceGetThroneButtDescription(race))
				
				_thronebutt_text = _race_name + " - " + _butt_text + "\n"
			}
			_thronebutt_text = string_trim_end(_thronebutt_text)
        }
		else {
			with Player {
				_thronebutt_text = loc(scrRaceGetThroneButtDescription(race))
			}
		}
		
        skill_text[mut_throne_butt] = _thronebutt_text
    }
}

function scrSkillIsWeaponMutation(_skill) {
	gml_pragma("forceinline")
	return _skill == mut_long_arms
		|| _skill == mut_recycle_gland
		|| _skill == mut_shotgun_shoulders
		|| _skill == mut_boiling_veins
		|| _skill == mut_bolt_marrow
		|| _skill == mut_laser_brain
}

function scr_skill_is_valid(_skill) {
	gml_pragma("forceinline")
	return is_numeric(_skill) && _skill > 0 && _skill <= maxskill
}

function scr_skill_get_name(_skill) {
	gml_pragma("forceinline")
	return scr_skill_is_valid(_skill) ? skill_name[_skill] : "MUT" + string(_skill)
}

function scr_skill_get_text(_skill) {
	gml_pragma("forceinline")
	return scr_skill_is_valid(_skill) ? skill_text[_skill] : "???"
}

function scr_skill_get_sound(_skill) {
	gml_pragma("forceinline")
	return scr_skill_is_valid(_skill) ? skill_msnd[_skill] : -1
}

function scr_skill_get_tips(_skill) {
	gml_pragma("forceinline")
	return scr_skill_is_valid(_skill) ? skill_tips[_skill] : -1
}

function scr_skill_can_appear(_skill) {
	if !scr_skill_is_valid(_skill) return false
	
	if scr_skill_get(_skill) || (_skill == mut_heavy_heart)
		|| (_skill == mut_last_wish && scrCrownCheck(crwn_destiny) && !scrPlayerCountRace(Race.Horror)
	) {
		return false
	}
	
	return true
}

/// @description scr_skill_set(skill, value)
/// @param skill
/// @param value
function scr_skill_set(_skill, _value) {
	var _previous = scr_skill_get(_skill)
	if (_previous == _value) exit
	
	var _is_removed = false
	
	#region process application
	if _value {
		var _skill_index = ds_list_find_index(GameCont.skills, _skill)
		if (_skill_index >= 0) {
			ds_list_set(GameCont.skills, _skill, _value)
		}
		else {
			ds_list_add(GameCont.skills, _skill)
		}
		
	    if instance_exists(LevCont) && LevCont.placeonpatience {
	        GameCont.patienceskill = _skill
		}
		
		if scrSkillIsWeaponMutation(_skill) {
			GameCont.heavyheart ++
		}
		
		_is_removed = false
	}
	#endregion
	
	#region process removal
	if !_value {
		var _skill_index = ds_list_find_index(GameCont.skills, _skill)
		if (_skill_index >= 0) ds_list_delete(GameCont.skills, _skill_index)
		
		if GameCont.patienceskill == _skill {
			GameCont.patienceskill = 0
		}
		
		if scrSkillIsWeaponMutation(_skill) {
			GameCont.heavyheart --
		}
		
		_is_removed = true
	}
	#endregion
	
	var _effect = _value - _previous
	
	switch _skill {
		case mut_rhino_skin:
			with Player {
				max_hp += 4 * _effect
				hp += 4 * _effect
				if (!hp) hp = 1
				lsthealth = hp
			}
			break
		case mut_extra_feet:
			with Player {
				maxspeed += 0.5 * _effect
				footextra += _effect
			}
			break
		case mut_back_muscle:
			scrAmmoUpdateTypeStats()
			break
		case mut_last_wish:
			with Player {
				if (_is_removed) break
				
				scrPlayerGiveAmmo(id, Ammo.Bullets, 200)
				
				for(var _ammo_type = Ammo.Shells; _ammo_type < Ammo.NUM_AMMO_TYPES; ++_ammo_type) { 
					scrPlayerGiveAmmo(id, _ammo_type, 20)
				}
				
				hp = max_hp
				
				if headloses > 0 {
					max_hp += headloses
					headloses = 0
				}
				
				scrPlayerUncurse(all)
				
				if race == Race.Rogue {
					rogue_ammo = rogue_ammo_max
				}
			}
			break
		case mut_eagle_eyes:
			with (Player) {
				if _is_removed {
					accuracy /= 0.4
				}
				else accuracy *= 0.4
			}
			break
		case mut_strong_spirit:
			with Player {
				spirit += _effect
			}
			break
	}
}

/// @description scr_skill_get(skill)
/// @param skill
function scr_skill_get(_skill) {
	gml_pragma("forceinline")
    return instance_exists(GameCont)
		&& scr_skill_is_valid(_skill)
		&& ds_list_find_index(GameCont.skills, _skill) >= 0
}