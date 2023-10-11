scrSetViewSize(false)

x = view_width / 2
y = view_height / 2

camera_set_pos(0, 0)

if !instance_exists(GameCont) && file_exists("gamestate.dat") {
    instance_create(0, 0, GameCont)
    instance_create(0, 0, Player)

    instance_create(0, 0, MusCont)

    UberCont.continued_run = true

    if !scrGameLoad() {
        file_delete("gamestate.dat")
        game_restart()

        exit
    }
	
	global.recontinues ++
	print("Recontinued", global.recontinues, "times")
	
	with Player {
		if global.recontinues > 1 {
			headloses += 2
			max_hp -= 2
		}
		
		hp = min(hp, max_hp)
		
		lsthealth = min(lsthealth, hp)
	}

    random_set_seed(global.seed)

    scrVolume()
	
	print("Saving", global.recontinues)
	
	scrGameSave()
}

if UberCont.want_menu2 {
    if !instance_exists(CoopController) {
		if UberCont.show_results {
			with instance_create(x, y, Leaderboards) {
				if UberCont.show_results == 2
					type = "weekly"
			}
        
			instance_create(x, y, BackButton)
		
	        UberCont.show_results = 0
	    }
		else {
	        with instance_create(x, y, Logo)
	            event_perform(ev_alarm, 1)
	    }
		
		if !instance_exists(Cinematic)
			instance_create(x, y, SpiralCont)
	}
	else {
		if !instance_exists(GameCont)
			instance_create(0, 0, GameCont)
		
		instance_create(0, 0, MenuGen)
		
		snd_play(sndMenuCharSelect)
	}
	
    UberCont.want_menu2 = 0

    if instance_exists(MusCont) {
		with MusCont
			instance_destroy()
	}

    instance_create(x, y, MusCont)

    instance_destroy()

    exit
}
else if instance_exists(GameCont) {
    if !instance_exists(Cinematic) instance_create(x, y, SpiralCont)

    if !instance_exists(Cinematic) && (GameCont.skillpoints > 0 or GameCont.crownpoints > 0 or GameCont.ultrapoints > 0) {
        instance_create(0, 0, BackCont)
        instance_create(x, y, LevCont)
    }
	else {
        instance_create(0, 0, BackCont)
        instance_create(x, y, GenCont)
    }

    instance_destroy()
}
else {
    if instance_exists(MusCont) {
        with MusCont
			instance_destroy()
    }

    instance_create(x, y, MusCont)

    alarm[0] = 120
    mode = 0

    snd_play(sndVlambeer)
}

da = 0