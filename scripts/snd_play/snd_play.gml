function snd_play(snd) {
    snd = custom_sound_check(snd)
	
    audio_stop_sound(snd)
	
    var s = audio_play_sound_on(UberCont.mainsound, snd, false, 2)
	audio_sound_gain(s, UberCont.opt_sndvol, 0)
}