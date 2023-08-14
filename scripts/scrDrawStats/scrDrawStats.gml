function scrDrawStats() {
    var runs, wins, dailies, bkill, brace, barea, bsuba, bloop, hkill, hrace, harea, hsuba,
		hloop, dkill, drace, darea, dsuba, dloop, bstrk, cstrk, frace, ftime, loop, dir,
		unlock, unlockmax, hard, kill, dead;
	
    statx = (view_xview + 100)
    staty = (view_yview + 52)
	line = 0
	
    unlock = progress
    unlockmax = maxprogress

    kill = 0
    dead = 0
    runs = 0
    loop = 0
    wins = 0
    dailies = 0
    hard = 0
    bkill = 0
    brace = 0
    barea = 0
    bsuba = 0
    bloop = 0
    hkill = 0
    hrace = 0
    harea = 0
    hsuba = 0
    hloop = 0
    dkill = 0
    drace = 0
    darea = 0
    dsuba = 0
    dloop = 0
    bstrk = 0
    cstrk = 0
    ftime = 9999990
    frace = 0
    dir = 1
	
    repeat(12) {
        kill += UberCont.ctot_kill[dir]
        dead += UberCont.ctot_dead[dir]
        loop += UberCont.ctot_loop[dir]
        runs += UberCont.ctot_runs[dir]
        wins += UberCont.ctot_wins[dir]
        dailies += UberCont.ctot_days[dir]
        hard += UberCont.ctot_hard[dir]
        if (UberCont.cbst_kill[dir] > bkill) {
            bkill = UberCont.cbst_kill[dir]
            bloop = UberCont.cbst_loop[dir]
            brace = UberCont.cbst_race[dir]
            barea = UberCont.cbst_area[dir]
            bsuba = UberCont.cbst_suba[dir]
        }
        if (UberCont.cbst_strk[dir] > bstrk) {
            cstrk = dir
            bstrk = UberCont.cbst_strk[dir]
        }
        if (UberCont.hbst_kill[dir] > hkill) {
            hkill = UberCont.hbst_kill[dir]
            hloop = UberCont.hbst_loop[dir]
            hrace = UberCont.hbst_race[dir]
            harea = UberCont.hbst_area[dir]
            hsuba = UberCont.hbst_suba[dir]
        }
        if (UberCont.dbst_kill[dir] > dkill) {
            dkill = UberCont.dbst_kill[dir]
            dloop = UberCont.dbst_loop[dir]
            drace = dir
            darea = UberCont.dbst_area[dir]
            dsuba = UberCont.dbst_suba[dir]
        }
        if (UberCont.cbst_time[dir] < ftime) {
            ftime = UberCont.cbst_time[dir]
            frace = dir
        }
        dir += 1
    }
    draw_stat_header("TOTAL")
    draw_stat("kills", string(kill))
    draw_stat("loops", string(loop))
    draw_stat("runs", string(runs))
    draw_stat("deaths", string(dead))
    draw_stat("wins", string(wins))
    draw_stat("time", string(time))
    draw_stat("unlocks", (scrAddZero(round(((unlock / unlockmax) * 100)), 2) + "%"))
    draw_stat_header("")
    
	if (runs > 0) {
        draw_stat_header("BEST RUN")
        draw_stat(string(UberCont.race_name[brace]), area_get_name(barea, bsuba, bloop))
        draw_stat("kills", string(bkill))
        draw_stat_header("")
    }
    
	statx = ((view_xview + view_width) - 70)
    staty = (view_yview + 52)
    line = 0
	
    if (runs > 0 && wins > 0) {
        draw_stat_header("BEST STREAK")
        draw_stat(string(UberCont.race_name[cstrk]), string(bstrk))
        draw_stat_header("")
    }
	
    if (wins > 0) {
        draw_stat_header("BEST TIME")
        draw_stat(string(UberCont.race_name[frace]), scrTimeSpeedrun(baked_fastest[frace]))
        draw_stat_header("")
    }
	
    if dailies > 0 {
        draw_stat_header("DAILY")
        draw_stat(string(UberCont.race_name[drace]), area_get_name(darea, dsuba, dloop))
        draw_stat("kills", string(dkill))
        draw_stat("runs", string(dailies))
        draw_stat_header("")
    }
	
    if UberCont.hardgot && hard > 0 {
        draw_stat_header("HARD")
        draw_stat(string(UberCont.race_name[hrace]), area_get_name_hard(harea, hsuba, hloop))
        draw_stat("kills", string(hkill))
        draw_stat("runs", string(hard))
        draw_stat_header("")
    }
}