function scrGamePause() {
	if scrGameIsPaused() exit
	
	with UberCont {
		paused = true
	    want_pause = 2
		
		if os_type == os_android && opt_volumecontrol {
			SetVolumeControl(false)
		}
		
	    splatindex = 0
		
		audio_pause_all()
		
		pause_portrait_anim = 180
		
		audio_resume_sound(sndClick)
		audio_resume_sound(sndHover)
		
		scrLetterbox(true)
		
		with MusCont {
	        if (audio_exists(song)) audio_resume_sound(song)
	        if (audio_exists(amb)) audio_resume_sound(amb)
	    }
		
	    with Player {
	        with (scr_playerinstance_find(index)) hp = other.hp
	    }
		
		scrGetPauseImage()
	}
}

function scrGameUnpause() {
	if !scrGameIsPaused() exit
	
	instance_activate_all()
	
    with UberCont {
		if surface_exists(pauseimg) surface_free(pauseimg)
		if sprite_exists(pausespr) sprite_delete(pausespr)
		
        pausespr = -1
        paused = false
		
		quit_pause = true
		
		if os_type == os_android && opt_volumecontrol {
			SetVolumeControl(true)
		}
    }
	
	instance_destroy(PauseButton)
	
    KeyCont.press_fire[global.index] = 0
	
	if instance_exists(MobileUI) {
		with MobileUI index = -1
        with JoystickAttack event_perform(ev_create, 0)
        with ButtonAttack event_perform(ev_create, 0)
    }
	
	// prevent any accidental volume control activations upon unpause
    with MobileUI {
        if variable_instance_exists(id, "volume_control_command") {
            if volume_control_command {
				volume_control_command = -1
			}
		}
    }
	
	if (!instance_exists(LevCont)) scrLetterbox(false)
	
    audio_resume_all()
}

function scrGameIsPaused() {
	return UberCont.paused
}

function scrGameCanPause() {
	return !(instance_exists(GenCont) || instance_exists(Credits) || instance_exists(Cinematic)
		|| !instance_exists(Player) || instance_exists(GameOver) || UberCont.want_pause || room == romInit)
}