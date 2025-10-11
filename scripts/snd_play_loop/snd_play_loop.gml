/// @function snd_play_loop
/// @param {Asset.GMSound} sound_index
function snd_play_loop(_sound_index) {
    _sound_index = custom_sound_check(_sound_index)
	
    audio_stop_sound(_sound_index)
    return audio_play_sound(_sound_index, 1000, true)
}