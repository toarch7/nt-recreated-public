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
	
	race_prog = array_create(16, 0)
	
    for (var c = 1; c <= 12; c++) {
	    all_kill += ctot_kill[c]
	    all_dead += ctot_dead[c]
	    all_time += ctot_time[c]
	    all_loop += ctot_loop[c]
		
	    for (var i = 1; i <= crownmax; i++) {
	        maxprogress++

	        if crowngot[c, i] {
	            race_prog[c]++
				progress ++
	        }
	    }
		
	    if cwep[c] != race_swep[c] {
	        race_prog[c] ++
	    }
		
	    maxprogress ++
		
	    if cgot[c]
			progress ++
		
	    maxprogress ++
		
	    if cskingot[c] {
	        race_prog[c] ++
			progress ++
	    }
    }
	
	maxprogress += 2
	
	progress += UberCont.cgot[14] + UberCont.cgot[15]
	
	maxprogress ++

	if UberCont.hardgot
	    progress ++
	
	time = scrTime(UberCont.tot_time)
	ftime = 0
	frace = 0
	
	for (var dir = 1; dir <= 15; dir++) {
	    if UberCont.cbst_fast[dir] > ftime || (ftime == 0 && UberCont.cbst_fast[dir] > 0) {
	        ftime = UberCont.cbst_fast[dir]
	        frace = dir
	    }
	}
	
	ftime = scrTime(ftime)
	
	baked_tottime = []
	baked_fastest = []
	baked_telekinesis = scrTime(UberCont.ctot_uniq[3])
	baked_cuztime = scrTime(UberCont.ctot_uniq[6])
	baked_chicken = scrTime(UberCont.ctot_uniq[9])
	baked_horror = scrTime(UberCont.ctot_uniq[11])
	
	for (var i = 1; i <= 15; i++) {
	    baked_tottime[i] = scrTime(UberCont.ctot_time[i])
	    baked_fastest[i] = scrTimeSpeedrun(UberCont.cbst_fast[i])
	}
	
    if progress >= maxprogress
        scrAchievement(43)
}