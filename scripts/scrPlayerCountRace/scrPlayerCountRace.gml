/// @function scrPlayerCountRace
/// @param {Enum.Race} race
/// @param only_local_players=false
function scrPlayerCountRace(_race, _check_local = false) {
	var _count = 0
	
	with Player {
		if race == _race && (is_me || !_check_local) {
			_count ++
		}
	}
	
	return _count
}