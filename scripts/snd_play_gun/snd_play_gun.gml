/// @function snd_play_gun
/// @param {Asset.GMSound} sound_index
/// @param random_pitch=0.2
function snd_play_gun(_sound_index, _random_pitch = 0.2) {
    if scr_test_is_fps_uncapped() return -1
	
	if GameCont.underwater && _sound_index != sndOasisMelee {
        _sound_index = sndOasisShoot
	}
	
    _sound_index = custom_sound_check(_sound_index)
    
    with UberCont {
        mainvol = 0.3
	    audio_emitter_gain(mainsound, mainvol)
    }

    audio_stop_sound(_sound_index)
    
    var _pitch = ((1 + random(_random_pitch)) - (_random_pitch / 2))
    return snd_play(_sound_index, _pitch, UberCont.opt_sndvol)
}