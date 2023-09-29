/// @description Pause the game

if want_pause {
	want_pause --
	
	if !want_pause && instance_exists(Player) && !instance_exists(GenCont) {
	    want_pause = 0
	
	    if !bossintro
	        scrMakePauseButtons()

	    with MobileUI
			index = -1
	
	    instance_deactivate_all(1)
		
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
		with MobileUI
			instance_destroy()
		
		scrCreateMobileControls()
	}
	
	quit_pause = false
}