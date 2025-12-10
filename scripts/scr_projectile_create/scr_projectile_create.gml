/// @function scr_projectile_create
/// @param x
/// @param y
/// @param object_index
/// @param {Undefined|Real|Array} direction=0
/// @param {Undefined|Real|Array} speed=0
/// @param default_struct
function scr_projectile_create(_x, _y, _object_index, _direction = undefined, _speed = undefined, _struct = undefined) {
	var _inst = scr_damage_create(_x, _y, _object_index, _struct)
	
	with (_inst) {
		if (is_array(_speed)) {
			speed = random_range(_speed[0], _speed[1])
		}
		else if (is_numeric(_speed)) {
			speed = _speed
		}
		
		if (is_array(_direction)) {
			direction = random_range(_direction[0], _direction[1])
		}
		else if (is_numeric(_direction)) {
			direction = _direction
		}
		
		image_angle = direction
		
		if (team != team_player && scr_skill_get(mut_euphoria)) {
			with instance_create(x, y, EuphoriaEffectDelay) {
				target = other.id
			}
		}
	}
	
	return _inst
}

/// @function scr_projectile_spread
/// @param spread_angle
function scr_projectile_spread(_angle) {
	var _accuracy = instance_is(creator, hitme) ? creator.accuracy : 1
	direction += orandom(_angle/* / 2*/) * _accuracy
	image_angle = direction
}

/// @function scr_projectile_shift
/// @param angle_shift
/// @param move_distance=0
function scr_projectile_shift(_angle, _move_amount = 0) {
	var _accuracy = instance_is(creator, hitme) ? creator.accuracy : 1
	
	if _angle != 0 {
		direction += _angle * _accuracy
		image_angle = direction
	}
	
	if _move_amount != 0 {
		x += ldrx(direction, _move_amount)
		y += ldry(direction, _move_amount)
	}
}

function scr_projectile_long_arms(_long_arms) {
	if (_long_arms != 0) {
		scr_projectile_shift(0, _long_arms * 20)
		motion_add(direction, _long_arms * 3)
		longarms = _long_arms
	}
}