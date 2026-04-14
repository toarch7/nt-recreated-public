scrSetViewSize(false)

x = view_width / 2
y = view_height / 2

scr_camera_set_position(0, 0)

var _just_loaded = false

if (!instance_exists(GameCont) && file_exists(savegame_file)) {
	instance_destroy(SpiralCont, true)
	instance_destroy(Spiral, true)
	instance_destroy(SpiralDebris, true)
	
	instance_create(0, 0, GameCont)
	instance_create(0, 0, MusCont)
	
	UberCont.continued_run = true
	var _success = scrSavegameLoad()
	
	if (_success) {
		// don't allow more than three recontinuation per level
		if (global.recontinued_times > 2) {
			file_delete(savegame_file)
		}
	}
	else if (!_success) {
		file_delete(savegame_file)
        game_restart()
		exit
    }
	
	_just_loaded = true
	
	global.recontinued_times ++
	print("Recontinued", global.recontinued_times, "times")
	scrVolume()
	
	scrSavegameSave()
}

scrRngStatesReset()

if UberCont.want_quit_to_menu {
    if !instance_exists(CoopController) {
		if UberCont.show_leaderboards_menu {
			with instance_create(x, y, Leaderboards) {
				if UberCont.show_weekly_results_menu {
					type = "weekly"
				}
			}
			
	        UberCont.show_leaderboards_menu = false
			instance_create(x, y, BackButton)
	    }
		else {
			with instance_create(x, y, Logo) {
				event_perform(ev_alarm, 1)
			}
	    }
		
		if !instance_exists(Cinematic) {
			instance_create(x, y, SpiralCont)
		}
	}
	else {
		if !instance_exists(GameCont)
			instance_create(0, 0, GameCont)
		
		instance_create(0, 0, MenuGen)
		
		with instance_create(0, 0, SpiralCont)
			instance_destroy()
		
		snd_play(sndMenuCharSelect)
	}
	
    UberCont.want_quit_to_menu = false

	instance_destroy(MusCont)
	instance_create(x, y, MusCont)
	file_delete(savegame_file)
    instance_destroy()
	
    exit
}
else if instance_exists(GameCont) {
    if !instance_exists(Cinematic) {
		instance_create(x, y, SpiralCont)
	}
	
	if (_just_loaded) {
		GameCont.is_level_continuation = true
	}
	
	var _can_skill = (!(_just_loaded && GameCont.patiencepick))
	
    if (!instance_exists(Cinematic)
		&& ((GameCont.skillpoints > 0 && _can_skill)
			|| GameCont.crownpoints > 0
			|| GameCont.ultrapoints > 0)
	) {
        instance_create(0, 0, BackCont)
        instance_create(x, y, LevCont)
    }
	else {
        instance_create(0, 0, BackCont)
        instance_create(x, y, GenCont)
    }
	
	if (!_just_loaded) {
		with (GameCont) {
			is_level_continuation = false
		}
		if (!instance_exists(Credits) && !instance_exists(Cinematic)) {
			scrSavegameSave()
		}
	}
	
    instance_destroy()
}
else {
	instance_create(0, 0, MainMenu)
	
	scrLetterbox(true)
	
	instance_destroy(MusCont)
    instance_create(x, y, MusCont)
	
	alarm[0] = 120
    mode = 0
	
	if file_exists("no_intro.txt") {
		mode = 3
		event_perform(ev_alarm, 0)
		with (Logo) event_perform(ev_alarm, 1)
	}
	
    snd_play(sndVlambeer)
}

da = 0


