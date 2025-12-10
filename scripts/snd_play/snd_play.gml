/// @function snd_play
/// @param {Asset.GMSound} sound_index
/// @param pitch=1
/// @param gain=1
function snd_play(_sound_index, _pitch = 1, _gain = 1) {
	if scr_test_is_fps_uncapped() return -1
	
    if audio_exists(_sound_index) {
		_sound_index = custom_sound_check(_sound_index)
		
	    audio_stop_sound(_sound_index)
		
		return audio_play_sound_on(UberCont.mainsound, _sound_index,
			false, 2, UberCont.opt_sndvol * _gain, 0, _pitch)
	}
	
	return -1
}