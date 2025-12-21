if (GameCont.area != area_hq) with (Player) {
	if snd_is_playing(snd_spch) || snd_is_playing(snd_thrn) {
	    other.alarm[1] = 15
		break
	}
	
	snd_play(snd_spch)
}