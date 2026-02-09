function scrRunStart() {
	if (!instance_exists(GameCont)) instance_create(0, 0, GameCont)
	
    random_set_seed(global.seed)
	
	print("Run started. Seed:", global.seed)
	
	with (CoopController) global.index = index
	
    scrCreatePlayers(global.index)
	
	if (global.crownpick == crwn_random) {
		var _crown, _iteration = 0;
		
		do {
			_crown = irandom_range(2, crownmax)
			var _all_have = true
			
			for(var i = 0; i < player_count; ++i) {
				var _race = scr_playerinstance_find(i).get_race()
				
				if (!scr_loadout_race_is_crown_unlocked(_race, _crown)) {
					_all_have = false
					break
				}
			}
			
			if (!_all_have) _crown = crwn_none
		}
		until (_crown > crwn_none || ((++ _iteration) >= 50))
		
		scrCrownSetCurrent(_crown)
	}
	else {
		scrCrownSetCurrent(global.crownpick, true)
	}
	
    with (Player) {
		snd_play(scr_race_get_sound(race, "Cnfm", sndMutant0Cnfm))
	}
	
	scrAmmoUpdateTypeStats()
	
    if scrGameIsDailyRun() {
        save_set_value("etc", "seed", UberCont.daily_seed)
    }
	
	if scrGameIsCustomMode() {
		// Starting muts
		var _mutlist = scrCustomParam("skill_start"),
			_count = array_length(_mutlist)
		
		for(var i = _count - 1; i >= 0; --i) {
			scr_skill_set(_mutlist[i], true)
		}
		
		with (GameCont) {
			area = scrCustomParam("area", area_desert)
			subarea = scrCustomParam("subarea", 1)
			loops = scrCustomParam("loops", 1)
			rad = scrCustomParam("rad", 0)
			can_advance_stage = false
			
			hard = scrAreaGetDifficulty(area, subarea, loops)
			if (_count) level = clamp(_count + 1, 1, PLAYER_LEVEL_MAX - 1)
			if (scrCustomParam("endpoints")) ultrapoints = 1
			
			waypnt[waypoints] = area
			waysub[waypoints] = subarea
			waylps[waypoints] = loops
			waypoints ++
		}
	}
	
    room_restart()
	
	if (scrPlayerCountRace(Race.Venuz) && scrPlayerCountRace(Race.Cuz)) {
		snd_play(choose(sndYVCuzCoop1, sndYVCuzCoop2, sndYVCuzCoop3))
	}
}