global.__bigname_surface_cache = {}

/// @function draw_text_bigname
/// @param x
/// @param y
/// @param text
/// @param color=-1
/// @param alpha=-1
/// @param scale=0.65
/// @param angle=0
function draw_text_bigname(_x, _y, _text, _color = draw_get_color(), _alpha = draw_get_alpha(), _scale = 0.65, _angle = 0) {
	_text = string_upper(string_hash_to_newline(_text))

	var _key = variable_get_hash($"[{_scale}]|{_text}"),
		_surface = struct_get_from_hash(global.__bigname_surface_cache, _key),
		_halign = draw_get_halign(),
		_valign = draw_get_valign()
	
	if !(is_numeric(_surface) && surface_exists(_surface)) {
		var _last_font = draw_get_font(),
			_last_alpha = draw_get_alpha()
		
		draw_set_font(fntBig)
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		draw_set_alpha(1)
		
		var _w = ceil(string_width(_text) * _scale) + 6,
			_h = ceil(string_height(_text) * _scale) + 2
		
		_surface = surface_create(_w, _h)
		
		surface_set_target(_surface)
		draw_clear_alpha(c_black, 0)
		
		//
		draw_set_color(c_black)
		if (_scale >= 1) {
			draw_text_transformed(1, 0, _text, _scale, _scale, 0)
			draw_text_transformed(1, 2, _text, _scale, _scale, 0)
			draw_text_transformed(0, 2, _text, _scale, _scale, 0)
		}
		else {
			draw_text_transformed(1, 1, _text, _scale, _scale, 0)
			draw_text_transformed(0, 1, _text, _scale, _scale, 0)
		}
		
		//
		draw_set_color(c_white)
		draw_text_transformed(0, 0, _text, _scale, _scale, 0)
		surface_reset_target()
		
		// 
		draw_set_font(_last_font)
		draw_set_halign(_halign)
		draw_set_valign(_valign)
		draw_set_alpha(_last_alpha)
		
		struct_set_from_hash(global.__bigname_surface_cache, _key, _surface)
	}
	
	/**/ if (_halign == fa_center) _x -= surface_get_width(_surface) / 2
	else if (_halign == fa_right) _x -= surface_get_width(_surface)
	
	/**/ if (_valign == fa_center) _y -= surface_get_height(_surface) / 2
	else if (_valign == fa_bottom) _y -= surface_get_height(_surface)
	
	draw_surface_ext(_surface, _x, _y, 1, 1, _angle, _color, _alpha)
}

function scrBignameSurfaceCleanup() {
	struct_foreach(global.__bigname_surface_cache, function(_key, _surface) {
		if surface_exists(_surface) {
			surface_free(_surface)
		}
	})
}