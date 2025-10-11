/// @function snd_play
/// @param {Asset.GMSound} sound_index
/// @param pitch=1
/// @param gain=1
function snd_play(_sound_index, _pitch = 1, _gain = 1) {
    if _sound_index >= 0 {
		_sound_index = custom_sound_check(_sound_index)
		
	    audio_stop_sound(_sound_index)
		
	    var _sound;
		
		with UberCont {
			return audio_play_sound_on(mainsound, _sound_index, false, 2, opt_sndvol * _gain, 0, _pitch)
		}
	}
	
	return -1
}