/// @description Align icons

array_foreach([ SkillIcon, CrownIcon, UltraIcon ], function(_object_index) {
	var _num = instance_number(_object_index),
		_xview = view_xview_center,
		_yview = view_yview + view_height - 21,
		_index = 0
	
	for(var _index = 0; _index < _num; ++_index) {
		with (instance_find(_object_index, _index)) {
			x = _xview - (_num - 1) * 16 + _index * 32
			y = _yview
			
			xstart = x
			ystart = y
		}
	}
})