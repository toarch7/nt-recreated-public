/// @function scrTargetIsVisible
/// @param target
/// @param distance
/// @param check_walls=true
function scrTargetIsVisible(_target, _distance, _check_walls = true) {
	if instance_exists(_target) {
		if _distance != infinity && point_distance(x, y, _target.x, _target.y) > _distance {
			return false
		}
		
		if _check_walls && collision_line(x, y, _target.x, _target.y, Wall, true, true) != noone {
			return false
		}
		
		return true
	}
	
	return false
}