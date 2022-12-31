function snd_play_gun(sound, pitch = 0.2) {
    sound = custom_sound_check(sound)

    if GameCont.area == 101 && sound != sndOasisMelee sound = sndOasisShoot

    var _sndplaygunloud = 0.2

    _sndplaygunloud = pitch

    UberCont.mainvol = 0.3
    audio_emitter_gain(UberCont.mainsound, UberCont.mainvol)
    audio_sound_pitch(sound, 1 + random(_sndplaygunloud) - _sndplaygunloud / 2)
    audio_stop_sound(sound)
    audio_play_sound(sound, 1, false)
}