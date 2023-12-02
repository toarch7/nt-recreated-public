function scrRestart() {




}

function scrUnpause() {
	instance_activate_all()
	
    with UberCont {
        surface_free(pauseimg)
        sprite_delete(pausespr)
        pausespr = -1
        paused = 0
		
		quit_pause = true
		
		if os_type == os_android && opt_volumecontrol
			SetVolumeControl(true)
    }

    KeyCont.press_fire[global.index] = 0

	if instance_exists(MobileUI) {
		with MobileUI
			index = -1
		
        with JoystickAttack {
            event_perform(ev_create, 0)
            pause = 5
        }
		
		with ButtonAttack {
            event_perform(ev_create, 0)
            pause = 5
        }
    }
	
    with MobileUI {
        if self[$ "do_thing"] != undefined {
            if do_thing {
                do_thing = -1
            }
        }
    }
	
    audio_resume_all()
}