function scrUnlocksArea() {
	if (scrGameIsCustomMode()) exit
	
    var _player = instance_is(self, Player) ? id : instance_nearest(x, y, Player),
		_race = instance_exists(_player) ? _player.race : scr_playerinstance_find().get_race(),
		_hardmode = scrGameIsHardmode(),
		_loops = GameCont.loops
	
	if _hardmode {
		_loops -= 1
	}
	
	static try_unlock_skin = function(_race, _skin) {
		if scr_race_is_skin_unlocked(_race, _skin) return false
		
		var _any = false
		
		with Player {
			if scr_player_is_local(index) && race == _race {
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
			if (UberCont.hardmode) {
				try_unlock_skin(Race.Chicken, SkinLetter.B)
			}
			break
		case area_pizza_sewers:
			try_unlock_skin(Race.Eyes, SkinLetter.B)
			break
		case area_scrapyards:
			scrRaceUnlock(Race.Plant)
			break
		case area_mansion:
			scrRaceUnlock(Race.Venuz)
			break
		case area_cursed_caves:
			try_unlock_skin(Race.Crystal, SkinLetter.B)
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
			if (_loops >= 1) scrRaceUnlock(Race.Rebel)
			break
		case area_hq:
			if (ds_list_size(GameCont.skills) <= 3) {
				try_unlock_skin(Race.Horror, SkinLetter.C)
			}
			break
	}
	
    if instance_exists(SitDown) scrUnlocksCharacterStats()
	
	if _loops >= 3 && !UberCont.opt_cheats {
		UberCont.opt_cheats = true
		save_set_value("cheats", "unlocked", true)
		/// @loc:token [R:Unlock] Cheats "@wCHEATS UNLOCKED#@sCHECK OUT THE MAIN MENU SETTINGS!"
		scrShowUnlockPopup(loc("R:Unlock:Cheats", "@wCHEATS UNLOCKED#@sCHECK OUT THE MAIN MENU SETTINGS!"))
		scrSave()
	}
}

function scrUnlocksCharacterStats() {
	var _can, _allb;
	
    if !scr_race_is_skin_unlocked(Race.Venuz, SkinLetter.B) {
        _can = true
		
        for (var _race_id = Race.Fish; _race_id < Race.NUM_ALL_RACE_TYPES; _race_id++) {
			if (scrRaceIsHidden(_race_id)) continue
			
			var _stored = scr_loadout_race_get_stored_weapon(_race_id),
				_starter = scrRaceGetStarterWeapon(_race_id)
            
			if !(scr_weapon_is_golden(_stored) || scr_weapon_is_golden(_starter)) {
                _can = false
                break
            }
        }
		
        if (_can) scrRaceUnlockSkin(Race.Venuz, SkinLetter.B)
    }
	
    if (!scr_race_is_skin_unlocked(Race.Fish, SkinLetter.B)
		|| !scr_race_is_skin_unlocked(Race.Fish, SkinLetter.C)
	) {
        _can = true
		_allb = true
		
        for (var _race_id = Race.Fish; _race_id < Race.NUM_ALL_RACE_TYPES; _race_id++) {
			if (scrRaceIsHidden(_race_id)) continue
			
			var _max_skins = scrRaceGetMaxSkinCount(_race_id, false)
			
			if (_max_skins > 1 && !scr_race_is_skin_unlocked(_race_id, SkinLetter.B)) {
				_allb = false
			}
			
			if (!UberCont.ctot_loop[_race_id]) {
				_can = false
			}
			
			if (!(_can || _allb)) break
        }
		
        if (_can) scrRaceUnlockSkin(Race.Fish, SkinLetter.B)
        if (_allb) scrRaceUnlockSkin(Race.Fish, SkinLetter.C)
    }
	
	var _check_gold = !scrAchievementIsUnlocked(Achievement.GOOD_FIND)
	
	with UberCont {
		for (var _race_id = Race.Fish; _race_id < Race.NUM_ALL_RACE_TYPES; _race_id++) {
	        if (scrRaceIsHidden(_race_id) || !scr_race_is_unlocked(_race_id)) {
				continue
			}
			
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

function scrUnlocksThroneDefeat() {
	// unlocked through SitDown
	
	if (scrGameIsCustomMode()) exit
	
	with (Player) {
		if (!scr_player_is_local(index)) continue
		
		var _race = race
		with (GameCont) {
			if (_race == Race.Melting
				&& !scr_skill_get(mut_rhino_skin)
				&& !scr_skill_get(mut_strong_spirit)
			) {
				scrRaceUnlockSkin(Race.Melting, SkinLetter.B)
			}
			else if (_race == Race.Plant && GameCont.tottimer < 18000) {
				scrRaceUnlockSkin(Race.Plant, SkinLetter.B)
			}
			else if (_race == Race.Eyes && !hasfiredshots) {
				scrRaceUnlockSkin(Race.Eyes, SkinLetter.C)
			}
			else if (_race == Race.Steroids && !haspickedweps) {
				scrRaceUnlockSkin(Race.Steroids, SkinLetter.C)
			}
		}
	}
}

function scrUnlocksPlayerEquipment(_player) {
	if (scrGameIsCustomMode()) exit
	
	with (_player) {
		if (!scr_player_is_local(index)) break
		
		if (race == Race.Cuz) {
			if (!scr_race_is_skin_unlocked(Race.Cuz, SkinLetter.B) && scrPlayerCountGoldenWeapons(id) >= 3) {
				scrRaceUnlockSkin(Race.Cuz, SkinLetter.B)
			}
			if (!scr_race_is_skin_unlocked(Race.Cuz, SkinLetter.C) && scrPlayerCountCursed(id) >= 6) {
				scrRaceUnlockSkin(Race.Cuz, SkinLetter.C)
			}
		}
		else if (race == Race.Melting
			&& !scr_race_is_skin_unlocked(Race.Melting, SkinLetter.C)
			&& ds_list_size(GameCont.skills) >= 12
		) {
			scrRaceUnlockSkin(Race.Melting, SkinLetter.C)
		}
		else if (race == Race.Plant
			&& !scr_race_is_skin_unlocked(Race.Plant, SkinLetter.C)
			&& scrPlayerCountBlood(id) >= 3
		) {
			scrRaceUnlockSkin(Race.Plant, SkinLetter.C)
		}
	}
}

function scrUnlocksWinOrLoop() {
	if (scrGameIsCustomMode()) exit
	
	with (Player) {
		if (!scr_player_is_local(index)) continue
		
		scrPlayerTryUnlockGoldenWeapons(id)
		
		if (GameCont.crown > crwn_none && scrCrownUnlock(race, GameCont.crown)) {
			scrAchievementUnlock(Achievement.CROWN_LIFE)
		}
	}
	
	scrSave()
}

function scrPlayerTryUnlockGoldenWeapons(_player) {
	if (scrGameIsCustomMode()) exit
	
	with _player {
		if (!scr_player_is_local(index) || !scr_loadout_is_available_for_race(race)) {
			continue
		}
		
		var _cwep = scr_loadout_race_get_stored_weapon(race),
			_extra_count = array_length(extra_weps),
			_store = -1
		
        if scr_weapon_is_golden(wep) && scrRaceGetStarterWeapon(race) != wep && _cwep != wep {
			_store = wep
        }
		else if scr_weapon_is_golden(bwep) && scrRaceGetStarterWeapon(race) != bwep && _cwep != bwep {
			_store = bwep
		}
		else if _extra_count {
			for(var i = 0; i < _extra_count; ++i) {
				var _extra = extra_weps[i]
				if scr_weapon_is_golden(_extra) && scrRaceGetStarterWeapon(race) != _extra && _cwep != _extra {
					_store = _extra
					break
				}
			}
		}
		
		if _store > 0 {
			var pinst = scr_playerinstance_find()
			
			scr_loadout_race_set_stored_weapon(race, _store)
			
			var _name = loc("Weapons", _store, "Name", wep_name[_store])
	        scrShowUnlockPopup(loc_fmt("Unlock:GoldWeapon:1", "@w%", _name), loc("Unlock:GoldWeapon:2", "@sSTORED"))
			
			scrAchievementUnlock(Achievement.GOOD_FIND)
			
	        if _store == wep_golden_disc_gun
			|| _store == wep_golden_nuke_launcher {
				scrAchievementUnlock(Achievement.GOOD_RIDDANCE)
			}
			
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
		if race == _race_id && bskin == _skin_id {
			return id
		}
	}
	
	with instance_create(0, 0, UnlockScreen) {
		race = _race_id
		bskin = _skin_id
		return id
	}
	
	return noone
}