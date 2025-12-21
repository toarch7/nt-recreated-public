/// @function scrPlayerCountCursed
/// @param player=all
function scrPlayerCountCursed(_player=all) {
	var _count = 0
	
	with (_player == all ? Player : _player) {
		if (curse) _count ++
		if (bcurse) _count ++
		
		var _extra_count = array_length(extra_weps)
		for(var i = _extra_count - 1; i >= 0; --i) {
			if (extra_weps_curse[i]) _count ++
		}
	}
	
	return _count
}

/// @function scrPlayerUncurse
/// @param player=all
function scrPlayerUncurse(_player=all) {
	var _any = false
	with (_player == all ? Player : _player) {
		if scrPlayerCountCursed(id) {
			curse = false
			bcurse = true
			
			var _extra_count = array_length(extra_weps)
			for(var i = _extra_count - 1; i >= 0; --i) {
				extra_weps_curse[i] = false
			}
			
			snd_play(sndUncurse)
			_any = true
		}
	}
	return _any
}