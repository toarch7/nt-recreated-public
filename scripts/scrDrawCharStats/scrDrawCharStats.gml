function scrDrawCharStats() {
	var L = LF("Stats")
	
	unlock = race_prog[select]
    unlockmax = race_prog_max[select]
	
    statx = view_xview + 110
    staty = view_yview + LETTERBOX_SIZE + 4
    line = 0
    draw_stat_header(loc("Races", select, "Name", scrRaceGetName(select)))
    draw_stat(L("Kills", "kills"), string(UberCont.ctot_kill[select]))
    draw_stat(L("Loops", "loops"), string(UberCont.ctot_loop[select]))
    draw_stat(L("Runs", "runs"), string(UberCont.ctot_runs[select]))
    draw_stat(L("Deaths", "deaths"), string(UberCont.ctot_dead[select]))
    draw_stat(L("Wins", "wins"), string(UberCont.ctot_wins[select]))
    draw_stat(L("Time", "time"), scrTime(ctot_time[select]))
    if (unlockmax > 0) draw_stat(L("Unlocks", "unlocks"), (string_pad_zeroes(round(((unlock / unlockmax) * 100)), 2) + "%"))
	if (UberCont.ctot_uniq[select]) {
		var _n = UberCont.ctot_uniq[select]
	    /**/ if (select == Race.Fish) draw_stat(L("Uniq1", "ROLLS"), _n)
	    else if (select == Race.Crystal) draw_stat(L("Uniq2", "DEFLECTS"), _n)
	    else if (select == Race.Eyes) draw_stat(L("Uniq3", "TELEKINESIS"), scrTime(_n / 30))
	    else if (select == Race.Melting) draw_stat(L("Uniq4", "EXPLODED"), _n)
	    else if (select == Race.Plant) draw_stat(L("Uniq5", "SNARE KILLS"), _n)
	    else if (select == Race.Venuz) draw_stat(L("Uniq6", "CUZ TIME"), scrTime(_n/ 30))
	    else if (select == Race.Steroids) draw_stat(L("Uniq7", "FIRING"), string((_n / 30) / _n * 100) + "%")
	    else if (select == Race.Robot) draw_stat(L("Uniq8", "EATEN"), _n)
	    else if (select == Race.Chicken) draw_stat(L("Uniq9", "HEADLESS"), scrTime(_n/ 30))
	    else if (select == Race.Rebel) draw_stat(L("Uniq10", "MOST ALLIES"), _n)
	    else if (select == Race.Horror) draw_stat(L("Uniq11", "BEAM TIME"), scrTime(_n / 30))
	    else if (select == Race.Rogue) draw_stat(L("Uniq12", "IDPD KILLS"), _n)
	    else if (select == Race.BigDog) draw_stat(L("R:Uniq13", "DAMAGED"), _n)
	    else if (select == Race.Skeleton) draw_stat(L("R:Uniq14", "LUCK STREAK"), _n)
	    else if (select == Race.Frog) draw_stat(L("R:Uniq15", "GAS VOLUMES"), string(_n / 1000))
	    else if (select == Race.Cuz) draw_stat(L("Uniq16", "TEARS CRIED"), _n)
	}
	if (UberCont.ctot_runs[select] > 0) {
        draw_stat_header("")
        draw_stat_header(L("BestRun", "BEST RUN"))
        draw_stat(L("Area", "area"), scrAreaGetMapName(UberCont.cbst_area[select], UberCont.cbst_suba[select], UberCont.cbst_loop[select]))
        draw_stat(L("Kills", "kills"), string(UberCont.cbst_kill[select]))
        statx = view_xview + view_width - 70
        staty = view_yview + LETTERBOX_SIZE + 4
        line = 0
        if (UberCont.ctot_wins[select] > 0) {
            draw_stat(L("Fastest", "FASTEST"), scrTimeSpeedrun(cbst_fast[select]))
            draw_stat_header("")
        }
        if (UberCont.cbst_strk[select] > 0) {
            draw_stat_header(L("Streaks", "STREAKS"))
            draw_stat(L("StreakCurrent", "current"), string(UberCont.ctot_strk[select]))
            draw_stat(L("StreakBest", "best"), string(UberCont.cbst_strk[select]))
            draw_stat_header("")
        }
    }
    if (UberCont.ctot_days[select] > 0) {
        draw_stat_header(L("BestDaily", "DAILY"))
        draw_stat(L("Area", "area"), scrAreaGetMapName(UberCont.dbst_area[select], UberCont.dbst_suba[select], UberCont.dbst_loop[select]))
        draw_stat(L("Kills", "kills"), string(UberCont.dbst_kill[select]))
        draw_stat(L("Runs", "runs"), string(UberCont.ctot_days[select]))
        draw_stat_header("")
    }
    if ((UberCont.hardgot == 1) && (UberCont.ctot_hard[select] > 0)) {
        draw_stat_header(L("BestHard", "HARD"))
        draw_stat(L("Area", "area"), scrAreaGetMapName(UberCont.hbst_area[select], UberCont.hbst_suba[select], UberCont.hbst_loop[select]))
        draw_stat(L("Kills", "kills"), string(UberCont.hbst_kill[select]))
        draw_stat(L("Runs", "runs"), string(UberCont.ctot_hard[select]))
        draw_stat_header("")
    }
}