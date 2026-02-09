/// @description Align icons

array_foreach([ SkillIcon, CrownIcon, UltraIcon ], function(_object_index) {
	var _num = instance_number(_object_index),
		_xview = view_xview_center,
		_yview = view_yview + view_height - 21,
		_step_size = min(32, floor(view_width / (_num + 1))),
		_half = _step_size div 2,
		_scale = max(0.65, _step_size / 32),
		_index = 0
	
	if (_num >= 10) _xview -= 12
	
	for(var _index = 0; _index < _num; ++_index) {
		with (instance_find(_object_index, _index)) {
			x = _xview - (_num - 1) * _half + _index * _step_size
			y = _yview
			
			if (_object_index == SkillIcon) {
				image_xscale = _scale
				image_yscale = _scale
			}
			
			xstart = x
			ystart = y
		}
	}
})