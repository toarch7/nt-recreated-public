/// @function scr_projectile_create
/// @param x
/// @param y
/// @param object_index
/// @param {Undefined|Real|Array} direction=0
/// @param {Undefined|Real|Array} speed=0
/// @param init_struct={}
function scr_projectile_create(_x, _y, _object_index, _direction = undefined, _speed = undefined, _struct = undefined) {
	var _inst, _creator, _team;
	
	if is_struct(_struct) {
		_inst = instance_create_depth(_x, _y, _object_index, object_get_depth(_object_index), _struct)
	}
	else _inst = instance_create(_x, _y, _object_index)
	
	if instance_is(self, projectile) {
		_creator = creator
		_team = team
	}
	else if instance_is(self, hitme) {
		_creator = id
		_team = _team
	}
	
	with _inst {
		if is_array(_speed) speed = random_range(_speed[0], _speed[1])
		else if is_numeric(_speed) speed = _speed
		
		if is_array(_direction) direction = random_range(_direction[0], _direction[1])
		else if is_numeric(_direction) direction = _direction
		
		creator = _creator
		team = _team
	}
	
	return _inst
}

/// @function scr_projectile_spread
/// @param spread_angle
function scr_projectile_spread(_angle) {
	var _accuracy = instance_is(creator, hitme) ? creator.accuracy : 1
	direction += orandom(_angle / 2) * _accuracy
}