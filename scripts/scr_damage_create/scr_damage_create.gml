/// @function scr_damage_create
/// @param x
/// @param y
/// @param object_index
/// @param default_struct
function scr_damage_create(_x, _y, _object_index, _struct = undefined) {
	var _inst, _creator, _team, _hitid;
	
	if is_struct(_struct) {
		_inst = instance_create_depth(_x, _y, object_get_depth(_object_index), _object_index, _struct)
	}
	else _inst = instance_create(_x, _y, _object_index)
	
	if (instance_is(self, damagesource)
		|| (variable_struct_exists(self, "creator")
		&& variable_struct_exists(self, "hitid")
		&& variable_struct_exists(self, "team"))
	) {
		_creator = creator
		_team = team
		_hitid = hitid
	}
	else if instance_is(self, hitme) {
		_creator = id
		_team = team
		_hitid = hitid
	}
	else {
		_creator = noone
		if (variable_struct_exists(self, "team")) _team = team
		if (variable_struct_exists(self, "hitid")) _hitid = hitid
	}
	
	with (_inst) {
		if (!variable_struct_exists(self, "hitid") || hitid == HitId.None) {
			hitid = _hitid
		}
		
		creator = _creator
		team = _team
	}
	
	return _inst
}
