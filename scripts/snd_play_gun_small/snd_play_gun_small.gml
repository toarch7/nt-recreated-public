function snd_play_gun_small(sound, pitch = 0.2) {
    sound = custom_sound_check(sound)

    if (GameCont.area == 101)
		sound = sndOasisShoot
    UberCont.mainvol = 0.6
    audio_emitter_gain(UberCont.mainsound, UberCont.mainvol)
    audio_sound_pitch(sound, ((1 + random(pitch)) - (pitch / 2)))
    audio_stop_sound(sound)
	
	audio_sound_gain(sound, UberCont.opt_sndvol, 0)
    return audio_play_sound(sound, 1, false)
}