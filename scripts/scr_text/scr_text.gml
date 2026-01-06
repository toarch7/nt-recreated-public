/// @function scr_text
/// @param x
/// @param y
/// @param text
/// @param color=auto
/// @param alpha=auto
/// @param xscale=1
/// @param yscale=xscale
/// @param angle=0
function scr_text(_dx, _dy, _string, _color = draw_get_color(), _alpha = draw_get_alpha(), _xscale = 1, _yscale = _xscale, _angle = 0) {
	var _last_alpha = draw_get_alpha(),
		_last_color = draw_get_color()
	
	draw_set_alpha(_alpha)
	draw_set_color(c_black)
	
	_dy -= font_get_height_diff(_string)
	
	draw_text_transformed(_dx + _xscale, _dy, _string, _xscale, _yscale, _angle)
	draw_text_transformed(_dx, _dy + _yscale, _string, _xscale, _yscale, _angle)
	draw_text_transformed(_dx + _xscale, _dy + _yscale, _string, _xscale, _yscale, _angle)
	
	draw_set_color(_color)
	draw_text_transformed(_dx, _dy, _string, _xscale, _yscale, _angle)
	
	draw_set_color(_last_color)
	draw_set_alpha(_last_alpha)
}

/// @function scr_text_plain
/// @param x
/// @param y
/// @param text
/// @param color=auto
/// @param alpha=auto
/// @param xscale=1
/// @param yscale=xscale
/// @param angle=0
function scr_text_plain(_dx, _dy, _str, _color = draw_get_color(), _alpha = draw_get_alpha(), _xscale = 1, _yscale = _xscale, _angle = 0) {
	var _prev_color = draw_get_color(),
		_prev_alpha = draw_get_alpha()
	
	draw_set_color(_color)
	draw_text_transformed(_dx, _dy, _str, _xscale, _yscale, _angle)
	
	draw_set_color(_prev_color)
	draw_set_alpha(_prev_alpha)
}

/// @function scr_text_ext
/// @param x
/// @param y
/// @param text
/// @param sep
/// @param width
/// @param color=auto
/// @param alpha=auto
/// @param xscale=1
/// @param yscale=xscale
/// @param angle=0
function scr_text_ext(_dx, _dy, _string, _sep, _width, _color = draw_get_color(), _alpha = draw_get_alpha(), _xscale = 1, _yscale = _xscale, _angle = 0) {
	var _last_alpha = draw_get_alpha(),
		_last_color = draw_get_color()
	
	draw_set_alpha(_alpha)
	draw_set_color(c_black)
	
	draw_text_transformed(_dx + _xscale, _dy, _string, _xscale, _yscale, _angle)
	draw_text_transformed(_dx, _dy + _yscale, _string, _xscale, _yscale, _angle)
	draw_text_transformed(_dx + _xscale, _dy + _yscale, _string, _xscale, _yscale, _angle)
	
	draw_set_color(_color)
	draw_text_ext_transformed(_dx, _dy, _string, _sep, _width, _xscale, _yscale, _angle)
	
	draw_set_color(_last_color)
	draw_set_alpha(_last_alpha)
}
