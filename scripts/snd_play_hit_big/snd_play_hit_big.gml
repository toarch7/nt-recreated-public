/// @function snd_play_hit_big
/// @param {Asset.GMSound} sound_index
/// @param random_pitch=0.2
function snd_play_hit_big(_sound_index, _random_pitch = 0.2) {
    if GameCont.area == Area.Oasis {
        if _sound_index == sndExplosion
        || _sound_index == sndExplosionL
        || _sound_index == sndExplosionXL {
			_sound_index = sndOasisExplosion
        }
		
        if _sound_index == sndExplosionS {
			_sound_index = sndOasisExplosionSmall
        }
    }
	
    _sound_index = custom_sound_check(_sound_index)
	
	var _ctx = instance_exists(Player) ? instance_nearest(x, y, Player) : id,
		_gain = max(0, 1 - distance_to_object(_ctx) / 320) * UberCont.opt_sndvol,
		_pitch = ((1 + random(_random_pitch)) - (_random_pitch * 0.5))
	
	if (!UberCont.opt_3Dsound)
		return snd_play(_sound_index)
    
    audio_stop_sound(_sound_index)
    
    var _pitch = (1 + random(_pitch)) - _pitch * 0.5,
        _gain = UberCont.opt_sndvol
	
    if (_ctx == id) {
        return audio_play_sound_at(_sound_index,
            ((view_xview + (view_width * 0.5)) - x),
            ((view_yview + (view_height * 0.5)) - y),
        0, 320, 64000, 1, false, 0, _gain, 0, _pitch)
    }
	
	return audio_play_sound_at(_sound_index,
		(_ctx.x - x), (_ctx.y - y), 0, 320, 64000, 1, false, 0)
}