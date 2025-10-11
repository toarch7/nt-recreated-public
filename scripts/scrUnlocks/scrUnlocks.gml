function scrUnlocksArea() {
    var _player = instance_is(self, Player) ? id : instance_nearest(x, y, Player),
		_race = instance_exists(_player) ? _player.race : GameCont.race,
		_hardmode = global.hardmode,
		_loops = GameCont.loops
	
	if _hardmode {
		_loops -= 1
	}
	
	static try_unlock_skin = function(_race, _skin) {
		if _skin >= 0 && scr_race_is_skin_unlocked(_race, _skin) return false
		
		var _any = false
		
		with Player {
			if is_me && race == _skin {
				_any = true
				break
			}
		}
		
		if _any {
			scrRaceUnlockSkin(_race, _skin)
			return true
		}
		
		return false
	}
	
	switch GameCont.area {
		case area_sewers:
			scrRaceUnlock(Race.Eyes)
			if (global.hardmode) {
				try_unlock_skin(Race.Chicken, 1)
			}
			break
		case area_pizza_sewers:
			try_unlock_skin(Race.Eyes, 1)
			break
		case area_scrapyards:
			scrRaceUnlock(Race.Plant)
			break
		case area_mansion:
			scrRaceUnlock(Race.Venuz)
			break
		case area_cursed_caves:
			try_unlock_skin(Race.Crystal, 1)
			break
		case area_city:
			scrRaceUnlock(Race.Robot)
			break
		case area_jungle:
			scrRaceUnlock(Race.Chicken)
			break
		case area_labs:
			scrRaceUnlock(Race.Steroids)
			break
		case area_desert:
			if _loops >= 1 scrRaceUnlock(Race.Rebel)
			break
	}
	
    scrPlayerTryUnlockGoldenWeapons(_player)
	
    if instance_exists(SitDown) scrUnlocksCharacterStats()
	
	if _loops >= 3 && !UberCont.opt_cheats {
		UberCont.opt_cheats = true
		save_set_value("cheats", "unlocked", true)
		scrShowUnlockPopup("@wCHEATS UNLOCKED#@sCHECK OUT THE MAIN MENU SETTINGS!")
		scrSave()
	}
}

function scrUnlocksCharacterStats() {
	var _can;
	
    if !scr_race_is_skin_unlocked(Race.Venuz, 1) {
        _can = true
		
        for (var _race_id = Race.Fish; _race_id <= Race.Rogue; _race_id++) {
            if scr_weapon_is_golden(scr_loadout_race_get_stored_weapon(_race_id)) {
                _can = false
                break
            }
        }
		
        if (_can) scrRaceUnlockSkin(Race.Venuz, 1)
    }
	
    if !scr_race_is_skin_unlocked(Race.Fish, 1) {
        _can = true
		
        for (var _race_id = Race.Fish; _race_id <= Race.Rogue; _race_id++) {
            if UberCont.ctot_loop[_race_id] {
                _can = false
                break
            }
        }
		
        if (_can) scrRaceUnlockSkin(Race.Fish, 1)
    }
	
	var _check_gold = !scrAchievementIsUnlocked(Achievement.GOOD_FIND)
	
	with UberCont {
		for (var _race_id = Race.Fish; _race_id <= Race.Rogue; _race_id++) {
	        if !scr_race_is_unlocked(_race_id) continue
			
			var _achievement_id = scrRaceGetUnlockAchievement(_race_id)
			
			if _achievement_id >= 0 {
				scrAchievementUnlock(_achievement_id)
			}
			
			var _max_skins = scrRaceGetMaxSkinCount(_race_id)
			
			for(var _skin_id = 1; _skin_id < _max_skins; ++_skin_id) {
				var _skin_achievement_id = scrRaceGetSkinUnlockAchievement(_race_id, _skin_id)
				
				if scr_race_is_skin_unlocked(_race_id, _skin_id) && _skin_achievement_id >= 0 {
					scrAchievementUnlock(_skin_achievement_id)
				}
		    }
			
			var _cwep = scr_loadout_race_get_stored_weapon(_race_id)
			
			if _check_gold {
				if _check_gold && scr_weapon_is_golden(_cwep) {
					scrAchievementUnlock(Achievement.GOOD_FIND)
					_check_gold = false
				}
			}
			
			if _cwep == wep_golden_nuke_launcher || _cwep == wep_golden_disc_gun {
				scrAchievementUnlock(Achievement.GOOD_RIDDANCE)
			}
			
			if cbst_loop[_race_id] >= 3 && !opt_cheats {
				opt_cheats = save_set_value("cheats", "unlocked", true)
			}
		}
		
		if hardgot {
			scrAchievementUnlock(Achievement.GO_HARD)
		}
	}
}

function scrPlayerTryUnlockGoldenWeapons(p) {
	with p {
		if race == Race.Skeleton || race == Race.Frog continue
		
		var _cwep = scr_loadout_race_get_stored_weapon(race), _store = -1;
		
        if scr_weapon_is_golden(wep) && scrRaceGetStarterWeapon(race) != wep && _cwep != wep {
			_store = wep
        }
		else if scr_weapon_is_golden(bwep) && scrRaceGetStarterWeapon(race) != bwep && _cwep != bwep {
			_store = bwep
		}
		
		if _store > 0 {
			var pinst = scr_playerinstance_find()
			
			scr_loadout_race_set_stored_weapon(race, _store)
			
	        scrShowUnlockPopup("@y" + loc(wep_name[_store]) + loc("#@sSTORED"))
			
	        if _store == wep_golden_disc_gun
			|| _store == wep_golden_nuke_launcher {
				scrAchievementUnlock(Achievement.GOOD_RIDDANCE)
			}
			
			scrAchievementUnlock(Achievement.GOOD_FIND)
	        snd_play(sndGoldUnlock)
			
			scrSave()
		}
	}
}

/// @function scrUnlockScreenCreate
/// @param race_id
/// @param skin_id=0
function scrUnlockScreenCreate(_race_id, _skin_id = 0) {
	with UnlockScreen {
		if race == _race_id && skin == _skin_id {
			return id
		}
	}
	
	with instance_create(0, 0, UnlockScreen) {
		race = _race_id
		skin = _skin_id
		return id
	}
	
	return noone
}