function snd_loop(argument0) {
    argument0 = custom_sound_check(argument0)

    audio_stop_sound(argument0)
    return audio_play_sound_on(UberCont.mainsound, argument0, true, 0)



}