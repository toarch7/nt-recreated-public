function snd_play_pitch(snd, pitchv = 0.2) {
    snd = custom_sound_check(snd)

    audio_stop_sound(snd)
    var s = audio_play_sound_on(UberCont.mainsound, snd, false, 2)
    audio_sound_pitch(s, ((1 + random(pitchv)) - (pitchv / 2)))
	audio_sound_gain(s, UberCont.opt_sndvol, 0)
}