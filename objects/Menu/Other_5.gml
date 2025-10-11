if gpadmode {
	gpadmode = false
	
	with UberCont
		show_crosshair = true
}

var _amb = custom_sound_check(amb0)
if audio_exists(_amb) snd_play_loop(_amb)