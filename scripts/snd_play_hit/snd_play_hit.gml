/// @function snd_play_hit
/// @param {Asset.GMSound} sound_index
/// @param random_pitch=0.2
function snd_play_hit(_sound_index, _random_pitch = 0.2) {
    if scr_test_is_fps_uncapped() return -1
	
	_sound_index = custom_sound_check(_sound_index)
	
	var _gain = UberCont.opt_sndvol,
		_ctx = instance_exists(Player) ? instance_nearest(x, y, Player) : id,
		_pitch = 1 + random_range(-_random_pitch, _random_pitch) * 0.5
	
	if (!UberCont.opt_3Dsound) return snd_play(_sound_index, _pitch, _gain)
	
    audio_stop_sound(_sound_index)
	
	if (_ctx == id) {
		var _x = (view_xview + (view_width * 0.5)) - x,
			_y = (view_yview + (view_height * 0.5)) - y
		
		return audio_play_sound_at(_sound_index,
			_x, _y, 0, 64, 320, 1, false, 0, _gain, 0, _pitch)
	}
	else _gain *= max(0, 1 - distance_to_object(_ctx) / 320)
	
	if instance_exists(_ctx) {
		return audio_play_sound_at(_sound_index,
			(_ctx.x - x), (_ctx.y - y), 0, 64, 320, 1, false, 0, _gain, 0, _pitch)
	}

	return snd_play(_sound_index, _pitch, _gain)
}