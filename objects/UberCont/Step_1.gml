/// @description Control pause states

if want_pause > 0 && (instance_exists(Player) && !instance_exists(GenCont) && !instance_exists(GameOver)) {
	if ((-- want_pause) <= 0) {
	    want_pause = 0
		
	    if (!bossintro) scrMakePauseButtons()
		
	    with (MobileUI) index = -1
		
	    instance_deactivate_all(true)
	    instance_activate_object(BackCont)
	    instance_activate_object(GameCont)
	    instance_activate_object(TopCont)
	    instance_activate_object(PauseButton)
	    instance_activate_object(CoopController)
	    instance_activate_object(MusCont)
	    instance_activate_object(Console)
		instance_activate_object(PauseImage)
	}
}

if quit_pause {
	if !instance_exists(GenCont) && !instance_exists(LevCont) {
		with (MobileUI) instance_destroy()
		scrCreateMobileControls()
	}
	
	quit_pause = false
}

if !scrGameIsLockstep() && (want_restart || want_menu) {
	KeyCont.press_paus[global.index] = false
	
	if want_menu > 0 {
		if !(-- want_menu) {
			scrGameRestart(true)
		    want_quit_to_menu = true
		    want_menu = 0
		}
	}
	else if want_restart > 0 {
		if !(-- want_restart) {
			scrGameRestart(false)
		    want_restart = 0
		}
	}
}