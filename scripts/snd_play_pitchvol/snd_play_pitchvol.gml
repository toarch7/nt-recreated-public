function snd_play_pitchvol(argument0, argument1, argument2) {
    argument0 = custom_sound_check(argument0)

    audio_stop_sound(argument0)
    audio_sound_pitch(argument0, ((1 + random(argument1)) - (argument1 / 2)))
    audio_sound_gain(argument0, argument2, 0)
    audio_play_sound_on(UberCont.mainsound, argument0, false, 2)
}