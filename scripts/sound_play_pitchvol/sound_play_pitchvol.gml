function sound_play_pitchvol(snd, pitch, vol) {
	var _snd = custom_sound_check(snd)
	
	audio_stop_sound(_snd)
	
	var s = audio_play_sound_on(UberCont.mainsound, _snd, 0, 10)
	audio_sound_pitch(s, pitch)
	audio_sound_gain(s, vol, 0)
	
	return s
}