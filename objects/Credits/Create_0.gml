event_user(1)

show = 0
scroll = 0
scroll_delay = 0
scroll_speed = 0
largetext = false
height = 0
timer = 60
text = ""

if (!instance_exists(MenuOptions)) {
	audio_stop_all()
	
	snd_play(sndRestart)
	
	if (!instance_exists(SpiralCont)) {
		with (instance_create(x, y, SpiralCont)) {
			bossfight = true
		}
	}
	
	instance_destroy(MusCont)
	
	with instance_create(0, 0, MusCont) {
	    snd_stop(song)
	    snd_stop(amb)
	    alarm[0] = -1
	    song = musCredits
	    amb = amb0
	    song = custom_sound_check(song)
	    amb = custom_sound_check(amb)
	    snd_play(song)
	}
	
	file_delete(savegame_file)
}

scrLetterbox(false)