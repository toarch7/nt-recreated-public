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
	maxraceprogress = 15
	
	#region Count progress
	
	race_prog = array_create(Race.NUM_ALL_RACE_TYPES, 0)
	
    for (var _race_id = 1; _race_id < Race.NUM_ALL_RACE_TYPES; _race_id ++) {
		if scrRaceIsHidden(_race_id, false) continue
		
		var _is_kinda_secret = scrRaceIsHidden(_race_id)
		
	    all_kill += ctot_kill[_race_id]
	    all_dead += ctot_dead[_race_id]
	    all_time += ctot_time[_race_id]
	    all_loop += ctot_loop[_race_id]
		
		if !_is_kinda_secret {
		    for (var i = 1; i <= crownmax; i++) {
		        maxprogress++
				
		        if crowngot[_race_id, i] {
		            race_prog[_race_id]++
					progress ++
		        }
		    }
			
		    if cwep[_race_id] != scrRaceGetStarterWeapon(_race_id) {
		        race_prog[_race_id] ++
		    }
		}
		
	    maxprogress ++
		
	    if scr_race_is_unlocked(_race_id) {
			progress ++
		}
		
		var _max_skins = scrRaceGetMaxSkinCount(_race_id)
		
		for(var _skin_id = 1; _skin_id < _max_skins; ++_skin_id) {
			maxprogress ++
			
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
	//
	
	#endregion
	
	time = scrTime(UberCont.tot_time)
	ftime = 0
	frace = 0
	
	for (var dir = Race.Fish; dir < Race.NUM_ALL_RACE_TYPES; dir++) {
	    if UberCont.cbst_fast[dir] > ftime || (ftime == 0 && UberCont.cbst_fast[dir] > 0) {
	        ftime = UberCont.cbst_fast[dir]
	        frace = dir
	    }
	}
	
	ftime = scrTime(ftime)
	
	baked_tottime = array_create(Race.NUM_ALL_RACE_TYPES)
	baked_fastest = array_create(Race.NUM_ALL_RACE_TYPES)
	baked_telekinesis = scrTime(UberCont.ctot_uniq[Race.Eyes])
	baked_cuztime = scrTime(UberCont.ctot_uniq[Race.Venuz])
	baked_chicken = scrTime(UberCont.ctot_uniq[Race.Chicken])
	baked_horror = scrTime(UberCont.ctot_uniq[Race.Horror])
	
	for (var i = Race.Fish; i < Race.NUM_ALL_RACE_TYPES; i++) {
	    baked_tottime[i] = scrTime(UberCont.ctot_time[i])
	    baked_fastest[i] = scrTimeSpeedrun(UberCont.cbst_fast[i])
	}
	
    if progress >= maxprogress {
        scrAchievementUnlock(Achievement.ULTRA_MUTANT)
	}
}