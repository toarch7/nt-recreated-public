function snd_play_music(snd, loop = false) {
    snd = custom_sound_check(snd)
	
    audio_stop_sound(snd)
	
	audio_sound_gain(snd, UberCont.opt_musvol, 0)
    var s = audio_play_sound(snd, 128, loop)
	
}

function snd_play_ambient(snd, loop = true) {
    snd = custom_sound_check(snd)
	
    audio_stop_sound(snd)
	
    var s = audio_play_sound(snd, 128, loop)
	
	audio_sound_gain(snd, UberCont.opt_ambvol, 0)
	audio_sound_set_track_position(s, random(audio_sound_length(snd)))
	
}