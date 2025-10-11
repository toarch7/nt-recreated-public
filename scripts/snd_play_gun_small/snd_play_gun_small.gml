/// @function snd_play_gun_small
/// @param {Asset.GMSound} sound_index
/// @param random_pitch
function snd_play_gun_small(_sound_index, _random_pitch = 0.2) {
    if GameCont.area == 101 && _sound_index != sndOasisMelee
        _sound_index = sndOasisShoot
	
    _sound_index = custom_sound_check(_sound_index)
    
    with UberCont {
        mainvol = 0.6
        audio_emitter_gain(mainsound, mainvol)
    }

    audio_stop_sound(_sound_index)
    
    var _pitch = ((1 + random(_random_pitch)) - (_random_pitch / 2))
    return snd_play(_sound_index, _pitch, UberCont.opt_sndvol)
}