/// @function scr_can_hit
/// @param target
/// @param check_inframes=true
/// @param attacker=self
function scr_can_hit(_instance = other.id, _check_inframes = true, _attacker = undefined) {
	if (_attacker == undefined) _attacker = id
	
	with _instance {
		if hp > 0 && (team != _attacker.team || team == team_none) {
			return !(_check_inframes && inframes)
		}
	}
	
	return false
}