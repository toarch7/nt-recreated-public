enum Race {
    Random = 0, // technical
    CoopUltra = 0, // technical
    Fish = 1,
    Crystal = 2,
    Eyes = 3,
    Melting = 4,
    Plant = 5,
    Venuz = 6,
    Steroids = 7,
    Robot = 8,
    Chicken = 9,
    Rebel = 10,
    Horror = 11,
    Rogue = 12,
    BigDog = 13,
    Skeleton = 14,
    Frog = 15,
    Cuz = 16,
    NUM_ALL_RACE_TYPES,
	
	Reserved17 = 17,
	Reserved18 = 18,
}

enum SkinLetter {
	A,
	B,
	C,
	D
}

/// @function scr_race_is_unlocked
/// @param {Real|Enum.Race} race
function scr_race_is_unlocked(_race) {
	with UberCont return cgot[_race]
}

/// @function scr_race_set_unlocked
/// @param {Real|Enum.Race} race
/// @param is_unlocked=true
function scr_race_set_unlocked(_race, _unlocked = true) {
	with UberCont cgot[_race] = _unlocked
}

/// @function scr_race_is_skin_unlocked
/// @param {Real|Enum.Race} race
/// @param {Real|Enum.SkinLetter} skin=SkinLetter.B
function scr_race_is_skin_unlocked(_race, _skin = 1) {
	with UberCont {
		return _skin <= 0 || (array_length(cskingot[_race]) > _skin && cskingot[_race, _skin])
	}
}

/// @function scr_race_set_skin_unlocked
/// @param {Real|Enum.Race} race
/// @param {Real|Enum.SkinLetter} skin=SkinLetter.B
/// @param is_unlocked=true
function scr_race_set_skin_unlocked(_race, _skin=SkinLetter.B, _unlock=true) {
	with UberCont cskingot[_race, _skin] = _unlock
}

/// @function scr_race_get_sprite
/// @param {Real|Enum.Race|String} race
/// @param sprite_name
/// @param {Asset.GMSprite} default=-1
/// @param {Real|Enum.SkinLetter} skin_id=SkinLetter.A
function scr_race_get_sprite(_race, _sprite_name, _default = -1, _skin = SkinLetter.A) {
	repeat 2 {
		var _name = is_numeric(_race)
			? $"sprMutant{_race}{scr_race_get_skin_letter(_skin, false)}{_sprite_name}"
			: $"spr{_race}{_sprite_name}"
		
		var _asset = asset_get_index(_name)
		
		if sprite_exists(_asset) return _asset
		
		if _skin != 0 && is_numeric(_race) {
			_skin = 0
		}
		else break
	}
	
	return _default
}

/// @function scr_race_get_sound
/// @param {Real|Enum.Race|String} race
/// @param sound_name
/// @param {Asset.GMSound} default=-1
function scr_race_get_sound(_race, _sound_name, _default = -1) {
	var _name = is_numeric(_race)
			? $"sndMutant{_race}{_sound_name}"
			: $"snd{_race}{_sound_name}"
	
	var _asset = asset_get_index(_name)
	
	if audio_exists(_asset) return _asset
	
	if _race == Race.Skeleton {
		if _sound_name == "Slct" return sndBloodGamble
		else if _sound_name == "Cnfm" return sndMutant14Turn
	}
	
	return _default
}

/// @function scr_race_get_skin_subimage
/// @param {Real|Enum.Race} race
/// @param skin
function scr_race_get_skin_subimage(_race, _skin) {
	if (_skin >= 2) return (_skin * 16) + (_race - 1)
	return _race > 0 ? ((_race - 1) * 2 + _skin) : -1
}

/// @function scr_race_get_skin_letter
/// @param skin_id
/// @param return_A=false
function scr_race_get_skin_letter(_skin_id, _return_a = false) {
	if _skin_id > 0 || (_skin_id == 0 && _return_a) {
		return chr(ord("A") + _skin_id)
	}
	
	return ""
}


/// @function scrRaceGetStringID
/// @param {Real|Enum.Race} race_numeric_id
/// @param include_capitalization
function scrRaceGetStringID(_race_number_id, _capitalization = false) {
	var _result = undefined
	
	switch _race_number_id {
		case Race.Fish: _result = "Fish" break
		case Race.Crystal: _result = "Crystal" break
		case Race.Eyes: _result = "Eyes" break
		case Race.Melting: _result = "Melting" break
		case Race.Plant: _result = "Plant" break
		case Race.Venuz: _result = "Venuz" break
		case Race.Steroids: _result = "Steroids" break
		case Race.Robot: _result = "Robot" break
		case Race.Chicken: _result = "Chicken" break
		case Race.Rebel: _result = "Rebel" break
		case Race.Horror: _result = "Horror" break
		case Race.Rogue: _result = "Rogue" break
		case Race.BigDog: _result = "BigDog" break
		case Race.Skeleton: _result = "Skeleton" break
		case Race.Frog: _result = "Frog" break
		case Race.Cuz: _result = "Cuz" break
	}
	
	if is_string(_result) && !_capitalization {
		return string_lower(_result)
	}
	
	return _result
}

/// @function scrRaceGetNumericID
/// @param {String} race_string_id
function scrRaceGetNumericID(_race_string_id) {
	switch string_lower(_race_string_id) {
		case "fish": return Race.Fish
		case "crystal": return Race.Crystal
		case "eyes": return Race.Eyes
		case "melting": return Race.Melting
		case "plant": return Race.Plant
		case "venuz": return Race.Venuz
		case "steroids": return Race.Steroids
		case "robot": return Race.Robot
		case "chicken": return Race.Chicken
		case "rebel": return Race.Rebel
		case "horror": return Race.Horror
		case "rogue": return Race.Rogue
		case "bigdog": return Race.BigDog
		case "skeleton": return Race.Skeleton
		case "frog": return Race.Frog
		case "cuz": return Race.Cuz
	}
	
	return undefined
}

/// @function scrRaceGetName
/// @param {Real|Enum.Race} race_id
function scrRaceGetName(_race) {
    switch _race {
        case Race.Random: return "RANDOM"
        case Race.Fish: return "FISH"
        case Race.Crystal: return "CRYSTAL"
        case Race.Eyes: return "EYES"
        case Race.Melting: return "MELTING"
        case Race.Plant: return "PLANT"
        case Race.Venuz: return "Y.V."
        case Race.Steroids: return "STEROIDS"
        case Race.Robot: return "ROBOT"
        case Race.Chicken: return "CHICKEN"
        case Race.Rebel: return "REBEL"
        case Race.Horror: return "HORROR"
        case Race.Rogue: return "ROGUE"
        case Race.BigDog: return "BIG DOG"
        case Race.Skeleton: return "SKELETON"
        case Race.Frog: return "FROG"
        case Race.Cuz: return "CUZ"
    }
    
    return "UNKNOWN"
}

/// @function scrRaceGetStarterWeapon
/// @param {Real|Enum.Race} race_id
function scrRaceGetStarterWeapon(_race) {
    switch _race {
        case Race.Fish: return wep_revolver
        case Race.Crystal: return wep_revolver
        case Race.Eyes: return wep_revolver
        case Race.Melting: return wep_revolver
        case Race.Plant: return wep_revolver
        case Race.Venuz: return wep_golden_revolver
        case Race.Steroids: return wep_revolver
        case Race.Robot: return wep_revolver
        case Race.Chicken: return wep_chicken_sword
        case Race.Rebel: return wep_revolver
        case Race.Horror: return wep_revolver
        case Race.Rogue: return wep_rogue_rifle
        case Race.BigDog: return wep_dog_spin_attack
        case Race.Skeleton: return wep_rusty_revolver
        case Race.Frog: return wep_golden_frog_pistol
        case Race.Cuz: return wep_golden_revolver
    }
    
    return wep_revolver
}

/// @function scrRaceGetPassiveSkillDescription
/// @param {Real|Enum.Race} race_id
function scrRaceGetPassiveSkillDescription(_race) {
    switch _race {
        case Race.Random: return "???"
        case Race.Fish: return "GETS MORE @yAMMO@w"
        case Race.Crystal: return "MORE MAX @rHP@w"
        case Race.Eyes: return "SEES IN THE DARK"
        case Race.Melting: return "LESS MAX @rHP@w#MORE @gRADS@w"
        case Race.Plant: return "IS FASTER"
        case Race.Venuz: return "HIGHER @wRATE OF FIRE@s"
        case Race.Steroids: return "INACCURATE#AUTOMATIC WEAPONS"
        case Race.Robot: return "FINDS BETTER TECH"
        case Race.Chicken: return "HARD TO KILL"
        case Race.Rebel: return "PORTALS @rHEAL@w"
        case Race.Horror: return "EXTRA @gMUTATION@w CHOICE"
        case Race.Rogue: return "BLAST ARMOR, @bHEAT@w"
        case Race.BigDog: return "MORE @rHP@w#SPIN ATTACK"
        case Race.Skeleton: return "LESS HP, SPEED, AND ACCURACY"
        case Race.Frog: return "CAN'T STAND STILL#TOXIC IMMUNITY"
        case Race.Cuz: return "LIL BUDDY"
    }

    return ""
}

/// @function scrRaceGetActiveSkillDescription
/// @param {Real|Enum.Race} race_id
function scrRaceGetActiveSkillDescription(_race) {
    switch _race {
        case Race.Random: return "???"
        case Race.Fish: return "CAN @wROLL@s"
        case Race.Crystal: return "CAN @wSHIELD@s"
        case Race.Eyes: return "TELEKINESIS"
        case Race.Melting: return "EXPLODE @wCORPSES@s"
        case Race.Plant: return "@wSNARE@s ENEMIES"
        case Race.Venuz: return "@wPOP POP"
        case Race.Steroids: return "DUAL WIELDING"
        case Race.Robot: return "CAN EAT @wWEAPONS@s"
        case Race.Chicken: return "CAN THROW @wWEAPONS@s"
        case Race.Rebel: return "CAN SPAWN @wALLIES@s"
        case Race.Horror: return "@gRADIATION@w BEAM"
        case Race.Rogue: return "@bPORTAL STRIKE@s"
        case Race.BigDog: return "MISSILES"
        case Race.Skeleton: return "BLOOD GAMBLE"
        case Race.Frog: return "FROG ACTIVE"
        case Race.Cuz: return "GOT UR BACK"
    }

    return ""
}

/// @function scrRaceGetThroneButtDescription
/// @param {Real|Enum.Race} race_id
function scrRaceGetThroneButtDescription(_race) {
    switch _race {
        case Race.Fish: return "WATER BOOST"
        case Race.Crystal: return "TELEPORTATION"
        case Race.Eyes: return "STRONGER TELEKINESIS"
        case Race.Melting: return "BIGGER CORPSE EXPLOSIONS"
        case Race.Plant: return "SNARE FINISHES ENEMIES#IN UNDER 33% @rHP"
        case Race.Venuz: return "BRRRAP"
        case Race.Steroids: return "DUAL FIRING MAY GIVE AMMO SOMETIMES"
        case Race.Robot: return "BETTER GUN NUTRITION"
        case Race.Chicken: return "THROWN WEAPONS CAN PIERCE ENEMIES"
        case Race.Rebel: return "HIGHER ALLY RATE OF FIRE"
        case Race.Horror: return "GAIN @rHP@s WHEN USING#@gBEAM@s FOR A LONG TIME"
        case Race.Rogue: return "BIGGER PORTAL STRIKES"
        case Race.BigDog: return "FASTER ROCKETS"
        case Race.Skeleton: return "BETTER ODDS"
        case Race.Frog: return "TOXIC SPREADS FASTER"
        case Race.Cuz: return "PLACEHOLDER"
    }

    return ""
}

/// @function scrRaceGetUnlockDescription
/// @param {Real|Enum.Race} race_id
function scrRaceGetUnlockDescription(_race) {
    switch _race {
        case Race.Fish: return "UNLOCKED FROM THE START"
        case Race.Crystal: return "UNLOCKED FROM THE START"
        case Race.Eyes: return "REACH THE SEWERS"
        case Race.Melting: return "DIE"
        case Race.Plant: return "REACH THE SCRAPYARD"
        case Race.Venuz: return "REACH 3-?"
        case Race.Steroids: return "REACH THE LABS"
        case Race.Robot: return "REACH THE FROZEN CITY"
        case Race.Chicken: return "REACH 5-?"
        case Race.Rebel: return "??? THE GAME"
        case Race.Horror: return "DEFEAT WILD HORROR"
        case Race.Rogue: return "DEFEAT THE NUCLEAR THRONE"
        case Race.BigDog: return "BEAT THE BIG DOG"
        case Race.Skeleton: return "SECRET CHARACTER"
        case Race.Frog: return "SECRET CHARACTER"
        case Race.Cuz: return "???"
    }
    
    return "???"
}

/// @function scrRaceGetSkinUnlockDescription
/// @param {Real|Enum.Race} race_id
/// @param {Real|Enum.SkinLetter} skin
function scrRaceGetSkinUnlockDescription(_race, _skin_id) {
	switch _skin_id {
		case SkinLetter.B:
			switch _race {
		        case Race.Fish: return "Loop with every character"
		        case Race.Crystal: return "Reach 4-?"
		        case Race.Eyes: return "Reach 2-?"
		        case Race.Melting: return "Beat the Throne without#Rhino Skin and Strong Spirit"
		        case Race.Plant: return "Beat the Throne#in under 10 minutes"
		        case Race.Venuz: return "Unlock Golden Weapon#for every character"
		        case Race.Steroids: return "Defeat 6-1 Boss"
		        case Race.Robot: return "Eat any Hyper weapon"
		        case Race.Chicken: return "Reach 2-1 H1"
		        case Race.Rebel: return "Defeat 2-1 Boss"
		        case Race.Horror: return "Defeat 4-1 Boss"
		        case Race.Rogue: return "Defeat ???"
		        case Race.BigDog: return "EMBRACE ETERNITY"
		        case Race.Skeleton: return "NO SKIN"
		        case Race.Frog: return "NO SKIN"
		        case Race.Cuz: return "CARRY 3 @y???"
		    }
		break
		case SkinLetter.C:
			switch _race {
				case Race.Fish: return "Unlock all B-skins"
				case Race.Crystal: return "Survive over 100 damage"
				case Race.Eyes: return "REACH THE NUCLEAR THRONE#WITHOUT FIRING A SHOT"
				case Race.Melting: return "Have 12 mutations"
				case Race.Plant: return "@rBLOOD BLOOD BLOOD"
				case Race.Venuz: return "Defeat ??? as ???"
				case Race.Steroids: return "Reach the Nuclear Throne#without picking up any weapons"
				case Race.Robot: return "EAT ???"
				case Race.Chicken: return "DEFEAT EVERY BOSS#WITH THE ???"
				case Race.Rebel: return "Defeat 1000 bandits"
				case Race.Horror: return "REACH ???#WITH 3 OR FEWER MUTATIONS"
				case Race.Rogue: return "Don't defeat ???"
				case Race.BigDog: return "NO SKIN"
				case Race.Skeleton: return "NO SKIN"
				case Race.Frog: return "NO SKIN"
				case Race.Cuz: return "CARRY 6 @q???"
			}
		break
	}
	
	return "???"
}

/// @function scrRaceGetUnlockCauseText
/// @param {Enum.Race} race_id
function scrRaceGetUnlockCauseText(_race) {
	switch _race {
		case Race.Eyes: return "FOR REACHING 2-1"
		case Race.Melting: return "FOR DYING"
		case Race.Plant: return "FOR REACHING 3-1"
		case Race.Venuz: return "WELCOME 2 VENUZ"
		case Race.Steroids: return "FOR REACHING 6-1"
		case Race.Robot: return "FOR REACHING 5-1"
		case Race.Chicken: return "FOR REACHING 5-?"
		case Race.Rebel: return "FOR LOOPING PAST THE NUCLEAR THRONE"
		case Race.Horror: return "HORROR DEFEATED"
		case Race.Rogue: return "FOR REACHING THE NUCLEAR THRONE"
		case Race.BigDog: return "BIG DOG DEFEATED"
		case Race.Skeleton: return "FOR REACHING LEVEL ULTRA AS SKELETON"
		case Race.Frog: return "FOR PLAYING THE FROG"
		case Race.Cuz: return "I WISH I KNEW"
	}
	
	return ""
}

/// @function scrRaceGetSkinUnlockCauseText
/// @param {Enum.Race} race_id
/// @param skin_id
function scrRaceGetSkinUnlockCauseText(_race, _skin_id) {
	
	switch scr_race_get_skin_letter(_skin_id) {
		case "B":
			switch _race {
				case Race.Fish: return "FOR LOOPING WITH EVERY CHARACTER"
				case Race.Crystal: return "FOR REACHING 4-?"
				case Race.Eyes: return "FOR REACHING 2-?"
				case Race.Melting: return "FOR REACHING THE NUCLEAR THRONE#WITHOUT RHINO SKIN OR STRONG SPIRIT"
				case Race.Plant: return "FOR REACHING THE THRONE#IN UNDER 10 MINUTES"
				case Race.Venuz: return "GOLDEN WEAPONS FOR EVERYONE!"
				case Race.Steroids: return "FOR DEFEATING TECHNOMANCER"
				case Race.Robot: return "FOR EATING A HYPER WEAPON"
				case Race.Chicken: return "FOR REACHING 2-1 ON HARD MODE"
				case Race.Rebel: return "FOR DEFEATING MOM"
				case Race.Horror: return "FOR DEFEATING HYPER CRYSTAL"
				case Race.Rogue: return "FOR REACHING THE NUCLEAR THRONE"
			}
		break
	}
	
	return ""
}

/// @function scrRaceGetMaxSkinCount
/// @param {Real|Enum.Race} race_id
function scrRaceGetMaxSkinCount(_race) {
    if _race == Race.BigDog || _race == Race.Frog
		return 1
	
	// TODO: these are NTT skins. Maybe these should become accessible once you have a 100% savefile?
	if false {
		if _race == Race.Robot return 4
		else if _race == Race.Skeleton return 2
	}
	
	return 3
}

/// @function scrRaceIsHidden
/// @param {Real|Enum.Race} race_id
/// @param count_in_unlockable=true
function scrRaceIsHidden(_race, _count_in_unlockable = true) {
	if _race == Race.BigDog || _race == Race.Cuz
	|| (_count_in_unlockable && (_race == Race.Frog || _race == Race.Skeleton))
		return true
	
	return false
}

/// @function scrRaceUnlock
/// @param {Real|Enum.Race} race_id
function scrRaceUnlock(_race) {
	if scr_race_is_unlocked(_race) exit
	
	scr_race_set_unlocked(_race, true)
	
	scrUnlockScreenCreate(_race)
	
	var _cause = scrRaceGetUnlockCauseText(_race)
	
	if _cause != "" {
		scrShowUnlockPopup(loc_sfmt($"@w% UNLOCKED#@s%", loc(scrRaceGetName(_race)), loc(_cause)))
	}
	
	var _achievement_id = scrRaceGetUnlockAchievement(_race)
	if (_achievement_id >= 0) scrAchievementUnlock(_achievement_id)
}

/// @function scrRaceUnlockSkin
/// @param {Real|Enum.Race} race_id
/// @param {Real|Enum.SkinLetter} skin
function scrRaceUnlockSkin(_race, _skin_id) {
	if scr_race_is_unlocked(_race) && !scr_race_is_skin_unlocked(_race, _skin_id) {
		
		scr_race_set_skin_unlocked(_race, _skin_id, true)
		
		scrUnlockScreenCreate(_race, _skin_id)
		
		var _cause = scrRaceGetSkinUnlockCauseText(_race, _skin_id)
		
		if _cause != "" {
			scrShowUnlockPopup(loc_sfmt($"@w% %-SKIN UNLOCKED#@s%",
				loc(scrRaceGetName(_race)), scr_race_get_skin_letter(_skin_id, true), loc(_cause)))
		}
		
		var _achievement_id = scrRaceGetSkinUnlockAchievement(_race, _skin_id)
		if (_achievement_id >= 0) scrAchievementUnlock(_achievement_id)
	}
}


