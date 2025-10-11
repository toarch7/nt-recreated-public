function scrRunStart() {
    random_set_seed(global.seed)
	
	print("Run started. Seed:", global.seed)
	
	with CoopController global.index = index
	with Menu scrCrownSetCurrent(loadout_crown, true)
	
    scrCreatePlayers(global.index)
	
    with Player {
		snd_play(scr_race_get_sound(race, "Cnfm", sndMutant0Cnfm))
	}
	
    if scrGameIsDailyRun() {
        save_set_value("etc", "seed", UberCont.daily_seed)
    }
	
    room_restart()
}