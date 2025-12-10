/// @function snd_play_pitchvol
/// @param {Asset.GMSound} sound_index
/// @param random_pitch=0.2
/// @param gain=1.0
function snd_play_pitchvol(_sound_index, _random_pitch = 0.2, _gain = 1) {
    if scr_test_is_fps_uncapped() return -1
	_sound_index = custom_sound_check(_sound_index)
    var _sound = snd_play_pitch(_sound_index, _random_pitch)
    audio_sound_gain(_sound, _gain, 0)
    return _sound
}