function snd_play_pitch(argument0, argument1) {
    argument0 = custom_sound_check(argument0)

    audio_stop_sound(argument0)
    var s = audio_play_sound_on(UberCont.mainsound, argument0, false, 2)
    audio_sound_pitch(s, ((1 + random(argument1)) - (argument1 / 2)))
	audio_sound_gain(s, UberCont.opt_sndvol, 0)
}