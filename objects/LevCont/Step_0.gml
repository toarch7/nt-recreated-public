view_xview = 0
view_yview = 0

// align
var _objects = [ SkillIcon, CrownIcon ],
	_count = array_length(_objects)

for(var i = 0; i < _count; i ++) {
	var _obj = _objects[i],
		_x = view_xview_center,
		_any = false,
		_step = 32
	
	if instance_exists(_obj) {
		do {
			_x = view_width / 2 + (_step * max(0, instance_number(_obj) - 1) * 0.5)
			if (_any) _step -= 2
			_any = true
		}
		until (_x < view_width)
		
		_x = view_xview + _x
		
		with _obj {
			x = _x
			_x -= _step
		}
	}
}
