/// @function scrDrawTooltip
/// @param x
/// @param y
/// @param text
/// @param pop_yoffset=0
/// @param is_gui=false
function scrDrawTooltip(_x, _y, _text, _offset = 0, _is_gui = false) {
	var _last_halign = draw_get_halign(),
		_last_valign = draw_get_valign(),
		_last_color = draw_get_color()
	
	draw_align(fa_center, fa_middle)
	
	_text = string_hash_to_newline(_text)
	
	var _yflip = false,
		_w = string_width_pure(_text),
		_h = string_height_pure(_text),
		_half_w = _w div 2 + 1,
		_half_h = _h div 2
	
	//print(_text, _w, _h)
	
	var _left = _is_gui ? 0 : view_xview,
		_top = _is_gui ? 0 : view_yview,
		_right = _left + view_width,
		_bottom = _top + view_height,
		
		_box_w = _half_w + 3,
		_box_h = _half_h + 3,
		
		_line_height = font_get_string_height("A")
	
	if ((_y - _box_h - _line_height - 4) <= _top) {
		_y += _h + _line_height * 2
		_yflip = true
	}
	
	draw_sprite_ext(sprTooltip, 0,
		clamp(_x, _x - _half_w, _x + _half_w),
		(_yflip ? (_y - _h - 2) : _y + 2) - _offset,
		1, _yflip ? -1 : 1, 0, c_white, draw_get_alpha())
	
	_y += sprite_get_height(sprTooltip) * (_yflip ? 1 : -1) - _offset
	
	if (_w < view_width) {
		if ((_x + _box_w) > _right) _x -= ((_x + _box_w) - _right)
		else if ((_x - _box_w) < _left) _x -= ((_x - _box_w) - _left)
	}
	
	draw_set_color(c_tooltip)
	draw_rectangle(_x - _half_w, _y - _h - 2, _x + _half_w, _y + 2, false)
	draw_rectangle(_x - _half_w - 1, _y - _h - 1, _x + _half_w + 1, _y + 1, false)
	
	draw_set_color(c_white)
	if (font_get_height_diff() != 0 && string_pos("\n", _text) == 0) _y += 2
	draw_text_nt(_x, _y - _half_h + 1, _text)
	
	draw_set_color(_last_color)
	draw_align(_last_halign, _last_valign)
}