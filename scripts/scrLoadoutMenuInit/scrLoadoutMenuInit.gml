function scrLoadoutMenuInit() {
	with UberCont {
		var _all_crowns = true,
			_any_crowns = false,
			_crownmax = crownmax
		
		for (var _race_id = Race.Fish; _race_id < Race.NUM_ALL_RACE_TYPES; ++_race_id) {
			_all_crowns = true
			
			var _unlocked_crowns = 0
			
			for (var _crown_id = 1; _crown_id <= _crownmax; _crown_id++) {
				if (crowngot[_race_id, _crown_id]) {
					if (_crown_id > crwn_none) {
						_unlocked_crowns ++
						_any_crowns = true
					}
				}
				else if (_crown_id > crwn_none) {
					_all_crowns = false
				}
			}
		
			save_set_value("crowngottotal", _race_id, _unlocked_crowns)

			if _all_crowns {
				scrAchievementUnlock(Achievement.VAULT_RAIDER)
			}
		}

		if _any_crowns {
			scrAchievementUnlock(Achievement.CROWN_LIFE)
		}
	}
}


/// @function scr_loadout_race_get_stored_weapon
/// @param {Real|Enum.Race} race_id
function scr_loadout_race_get_stored_weapon(_race_id) {
	with UberCont {
		var _cwep = cwep[_race_id]
		
		if _cwep == 0 {
			return race_swep[_race_id]
		}
		
		return _cwep
	}
	
	return wep_none
}

/// @function scr_loadout_race_set_stored_weapon
/// @param {Real|Enum.Race} race_id
function scr_loadout_race_set_stored_weapon(_race_id, _weapon_id) {
	with UberCont {
		scr_loadout_race_set_start_weapon(_race_id, _weapon_id)
		cwep[_race_id] = _weapon_id
	}
}

/// @function scr_loadout_race_get_start_weapon
/// @praam {Real|Enum.Race} race_id
function scr_loadout_race_get_start_weapon(_race_id) {
	with UberCont {
		return save_get_value("cswep", _race_id, scrRaceGetStarterWeapon(_race_id))
	}
	
	return wep_none
}

/// @function scr_loadout_race_set_start_weapon
/// @praam {Real|Enum.Race} race_id
/// @param weapon_id
function scr_loadout_race_set_start_weapon(_race_id, _weapon_id) {
	with UberCont {
		if (!scr_weapon_is_valid(_weapon_id)) break
		
		if (my_player.get_race() == _race_id && !scrGameIsEventRun()) {
			my_player.cwep = _weapon_id
		}
		
		save_set_value("cswep", _race_id, _weapon_id)
	}
}

/// @function scr_loadout_race_get_start_crown
/// @param {Real|Enum.Race} race_id
function scr_loadout_race_get_start_crown(_race_id) {
	if UberCont.cgot[_race_id] {
		return save_get_value("ccrown", _race_id, crwn_none)
	}
	
	return crwn_none
}

/// @function scr_loadout_race_set_start_crown
/// @param {Real|Enum.Race} race_id
/// @param crown_id
function scr_loadout_race_set_start_crown(_race_id, _crown_id) {
	with UberCont {
		if cgot[_race_id] && crowngot[_race_id, _crown_id] {
			save_set_value("ccrown", _race_id, _crown_id)
			return true
		}
	}
	return false
}

/// @function scr_loadout_race_is_crown_unlocked
/// @param {Real|Enum.Race} race_id
/// @param crown_id
function scr_loadout_race_is_crown_unlocked(_race_id, _crown_id) {
	with UberCont {
		if (scrGameIsCustomMode() && scrCustomParam("unlock_crowns")) {
			return true
		}
		
		return cgot[_race_id] && crowngot[_race_id, _crown_id]
	}
	
	return false
}

/// @function scr_loadout_race_unlock_crown
/// @param {Real|Enum.Race} race_id
/// @param {Real|Enum.Crown} crown_id
function scr_loadout_race_unlock_crown(_race_id, _crown_id) {
	with UberCont {
		if (crowngot[_race_id, _crown_id]) exit
		scr_loadout_race_set_start_crown(_race_id, _crown_id)
		crowngot[_race_id, _crown_id] = true
	}
}

/// @function scr_loadout_race_get_unlocked_crowns_count
/// @param {Real|Enum.Race} race_id
function scr_loadout_race_get_unlocked_crowns_count(_race_id) {
	with UberCont {
		if (cgot[_race_id]) return save_get_value("crowngottotal", _race_id, 0)
	}
	
	return 0
}

/// @function scr_loadout_race_get_skin
/// @param {Real|Enum.Race} race_id
function scr_loadout_race_get_skin(_race_id) {
	return UberCont.cskin[_race_id]
}

/// @function scr_loadout_race_set_skin
/// @param {Real|Enum.Race} race_id
/// @param skin_id
function scr_loadout_race_set_skin(_race_id, _skin_id) {
	with UberCont {
		if cgot[_race_id] && cskingot[_race_id, _skin_id] {
			cskin[_race_id] = _skin_id
			return true
		}
	}
	
	return false
}

/// @function scr_loadout_is_available_for_race
/// @param {Real|Enum.Race} race_id
function scr_loadout_is_available_for_race(_race) {
	if (scrGameIsCustomMode() && scrCustomParam("unlock_crowns")) {
		return true
	}
	
	if (_race == Race.BigDog || _race == Race.Skeleton || _race == Race.Frog) {
		return (!instance_exists(CoopController) && !scrGameIsEventRun()
			&& scr_loadout_can_access_hidden_ntt_skins())
	}
	
	return true
}

function scr_loadout_can_access_hidden_ntt_skins() {
	return scrCustomParam("unlock_chars", false) || save_get_value("achievement", Achievement.ULTRA_MUTANT)
}
