/// @function scrLetterbox
/// @param state
/// @param frame
function scrLetterbox(_state, _frame=-1) {
	with (UberCont) {
		letterbox = _state
		
		if (_frame != -1) {
			letterbox_frame = clamp(_frame, 0, sprite_get_number(sprLetterbox) - 1)
		}
	}
}

/// @function scrDrawLetterbox
/// @param frame
/// @param size=LETTERBOX_SIZE
function scrDrawLetterbox(_frame = -1, _size = LETTERBOX_SIZE) {
	var _left = view_xview,
		_top = view_yview - 1,
		_right = _left + view_width,
		_bottom = _top + view_height + 1
	
	var _width = sprite_get_width(sprLetterbox),
		_margin = view_width - _width
	
	if (_margin != 0) {
	    draw_set_color(c_black)
	    draw_rectangle(_left, _bottom, _left + _margin, _bottom - _size, 0)
	    draw_rectangle(_right - _margin, _top, _right, _top + _size, 0)
	    draw_set_color(c_white)
		
		_left += _margin
		_right -= _margin
	}
	
	if (_frame < 0) _frame = 3
	
	var _yscale = _size / (sprite_get_height(sprLetterbox) - 9)
	draw_sprite_ext(sprLetterbox, _frame, _right - _width, _top, 1, _yscale, 0, c_white, 1)
	draw_sprite_ext(sprLetterbox, _frame, _left + _width, _bottom + 2, -1, -_yscale, 0, c_white, 1)
}
