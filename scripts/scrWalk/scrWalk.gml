/// @function scrWalk
/// @param direction
/// @param impulse=0
/// @param duration_min=0
/// @param duration_max=duration_min
function scrWalk(_direction, _impulse = 0, _duration_min, _duration_max = _duration_min) {
	if (_impulse == 0) {
		direction = _direction
	}
	else {
		motion_add(_direction, _impulse)
	}
	if (_duration_min != _duration_max) {
		walk = random_range(_duration_min, _duration_max)
	}
	else walk = _duration_min
}

/// @function scrWalkRandom
/// @param impulse=0
/// @param duration_min=0
/// @param duration_max=duration_min
function scrWalkRandom(_impulse = 0, _duration_min = 0, _duration_max = _duration_min) {
	gml_pragma("forceinline")
	scrWalk(random_angle, _impulse, _duration_min, _duration_max)
}