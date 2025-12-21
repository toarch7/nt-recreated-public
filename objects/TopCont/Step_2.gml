if darkness {
	if surface_exists(dark) {
		var _w = surface_get_width(dark),
			_h = surface_get_height(dark)
		
		if !(_w == view_width && _h = view_height) {
			surface_resize(dark, view_width, view_height)
		}
	}
	
	if (!UberCont.paused) scrDarkness()
}

if (!instance_exists(Player)
	|| (instance_exists(Credits) && !Credits.visible)
	|| (instance_exists(Cinematic) && Cinematic.done)
) {
	if (instance_exists(UnlockScreen)) {
		with (instance_find(UnlockScreen, 0)) {
			if (!visible && alarm[0] == -1) {
				alarm[0] = 45
			}
		}
		
		exit
	}
    if (!UberCont.paused && !instance_exists(GameOver)) {
        if (!instance_exists(UnlockScreen) && instance_exists(GameCont)
			&& !scrGameIsGenerationScreen() && !instance_exists(Menu) && !instance_exists(MenuGen)
		) {
            instance_create(view_xview, view_yview, GameOver)
            with (MusCont) audio_stop_sound(song)
        }
    }

    with (instance_find(UnlockScreen, 0)) {
        if (alarm[0] == -1 && !visible) event_perform(ev_alarm, 0)
    }
}