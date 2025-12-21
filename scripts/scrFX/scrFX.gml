/// @function scrFX
/// @param x
/// @param y
/// @param object_index
/// @param direction
/// @param speed
function scrFX(_x, _y, _object, _direction, _speed) {
	with (instance_create(_x, _y, _object)) {
		motion_add(_direction, _speed)
		return id
	}
	return noone
}