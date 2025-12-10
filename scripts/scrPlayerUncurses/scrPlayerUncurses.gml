/// @function scrPlayerCountCursed
/// @param player=all
function scrPlayerCountCursed(_player=all) {
	var _count = 0
	
	with (_player == all ? Player : _player) {
		if (curse) _count ++
		if (bcurse) _count ++
	}
	
	return _count
}

/// @function scrPlayerUncurse
/// @param player=all
function scrPlayerUncurse(_player=all) {
	with (_player == all ? Player : _player) {
		if scrPlayerCountCursed(id) {
			curse = false
			bcurse = true
			snd_play(sndUncurse)
		}
	}
}