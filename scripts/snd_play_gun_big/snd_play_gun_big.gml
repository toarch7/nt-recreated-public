/// @function snd_play_gun_big
/// @param {Asset.GMSound} sound_index
/// @param random_pitch=0.2
function snd_play_gun_big(_sound_index, _random_pitch = 0.2) {
    if scr_test_is_fps_uncapped() return -1
	
    if (GameCont.area == area_oasis) {
        _sound_index = sndOasisShoot
    }

    _sound_index = custom_sound_check(_sound_index)
	
    with UberCont {
        mainvol = 0.33
        audio_emitter_gain(mainsound, mainvol)
    }
    
    var _pitch = (1 + random(_random_pitch)) - _random_pitch / 2
    audio_stop_sound(_sound_index)
    
	return snd_play(_sound_index, _pitch, UberCont.opt_sndvol)
}