function scrInitStats() {
    if object_index != UberCont {
        scrRaces()
        scrCrowns()
    }

    tot_time = 0
	
	all_kill = 0
	all_dead = 0
	all_loop = 0
	all_time = 0

	progress = 0
	mouseover = -1
	maxprogress = 0
	
	#region Count progress
	
	race_prog = array_create(Race.NUM_ALL_RACE_TYPES, 0)
	race_prog_max = array_create(Race.NUM_ALL_RACE_TYPES, 0)
	
    for (var _race_id = 1; _race_id < Race.NUM_ALL_RACE_TYPES; _race_id ++) {
		var _is_kinda_secret = scrRaceIsHidden(_race_id)
		
	    all_kill += ctot_kill[_race_id]
	    all_dead += ctot_dead[_race_id]
	    all_time += ctot_time[_race_id]
	    all_loop += ctot_loop[_race_id]
		
		if (_is_kinda_secret) continue
		
		if (scr_loadout_is_available_for_race(_race_id)) {
			race_prog_max[_race_id] += crownmax + 1 // +1 for stored weps
			
		    for (var i = 1; i <= crownmax; i++) {
		        maxprogress ++
				
		        if crowngot[_race_id, i] {
		            race_prog[_race_id] ++
					progress ++
		        }
		    }
			
			if (scr_weapon_is_valid(scr_loadout_race_get_stored_weapon(_race_id))) {
			    race_prog[_race_id] ++
			}
		}
		
		race_prog_max[_race_id] ++
		if (scr_race_is_unlocked(_race_id)) {
			progress ++
		}
		
		var _max_skins = scrRaceGetMaxSkinCount(_race_id)
		
		for(var _skin_id = 1; _skin_id < _max_skins; ++_skin_id) {
			maxprogress ++
			race_prog_max[_race_id] ++
			
			if scr_race_is_skin_unlocked(_race_id, _skin_id) {
			    race_prog[_race_id] ++
				progress ++
			}
		}
    }
	
	// Hardmode
	maxprogress ++
	if UberCont.hardgot {
		progress ++
	}
	
	#endregion
	
	var ftime = 999_990
	frace = Race.Random
	
	for (var _race_id = Race.Fish; _race_id < Race.NUM_ALL_RACE_TYPES; _race_id++) {
	    if (UberCont.cbst_fast[_race_id] > 0 && UberCont.cbst_fast[_race_id] < ftime) {
	        frace = _race_id
	    }
	}
	
    if progress >= maxprogress {
        scrAchievementUnlock(Achievement.ULTRA_MUTANT)
	}
}