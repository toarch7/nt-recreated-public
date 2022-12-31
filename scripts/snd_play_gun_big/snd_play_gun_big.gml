function snd_play_gun_big(argument0, argument1 = 0.2) {
    argument0 = custom_sound_check(argument0)

    if (GameCont.area == 101) argument0 = sndOasisShoot
    UberCont.mainvol = 0.33
    audio_emitter_gain(UberCont.mainsound, UberCont.mainvol)
    audio_sound_pitch(argument0, ((1 + random(argument1)) - (argument1 / 2)))
    audio_stop_sound(argument0)
    audio_play_sound(argument0, 1, false)
}