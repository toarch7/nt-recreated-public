function scrPlayerUpdateBestRunStats(_race, _is_end = false) {
	if (scrGameIsCustomMode()) exit
	
	if (!scrGameIsHardmode()) {
	    if (GameCont.kills > UberCont.cbst_kill[_race]) {
	        UberCont.cbst_race[_race] = _race
	        UberCont.cbst_area[_race] = GameCont.area
	        UberCont.cbst_loop[_race] = GameCont.loops
	        UberCont.cbst_suba[_race] = GameCont.subarea
	        UberCont.cbst_kill[_race] = GameCont.kills
	    }
		
	    if (scrGameIsDailyRun()) {
	        with UberCont {
	            if GameCont.kills > UberCont.dbst_kill[_race] {
	                dbst_race[_race] = _race
	                dbst_area[_race] = GameCont.area
	                dbst_loop[_race] = GameCont.loops
	                dbst_suba[_race] = GameCont.subarea
	                dbst_kill[_race] = GameCont.kills
	            }
	        }
	    }
	}
	else {
	    if (GameCont.kills > UberCont.hbst_kill[_race]) {
	        UberCont.hbst_race[_race] = _race
	        UberCont.hbst_area[_race] = GameCont.area
	        UberCont.hbst_loop[_race] = GameCont.loops
	        UberCont.hbst_suba[_race] = GameCont.subarea
	        UberCont.hbst_kill[_race] = GameCont.kills
	    }
	}
	
	if (_is_end) {
		UberCont.ctot_kill[_race] += GameCont.kills
		
		if (GameCont.win) {
			with UberCont {
				ctot_wins[_race] ++
				ctot_strk[_race] ++
				
				if (ctot_strk[_race] > cbst_strk[_race]) {
					cbst_strk[_race] = ctot_strk[_race]
				}
				
				if (GameCont.tottimer < cbst_fast[_race] || cbst_fast[_race] <= 0) {
					cbst_fast[_race] = GameCont.tottimer
				}
			}
		}
		else if (instance_exists(GameOver)) {
			UberCont.ctot_dead[_race] += 1
		}
	}
}