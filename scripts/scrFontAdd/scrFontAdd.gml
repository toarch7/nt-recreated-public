/// @function scrFontAdd
/// @description Currently unused but could come in handy
/// @param path
/// @param size
/// @param start
/// @param end
/// @param antialiased=false
/// @param proportional=false
/// @param separation=0
/// @param bold=false
/// @param italic=false
function scrFontAdd(_path, _size, _start, _end, _aliasing = false, _prop = false, _sep = 0, _bold = false, _italic = false) {
	if (_start > _end) {
		var _t = _end
		_end = _start
		_start = _t
	}
	
	font_add_enable_aa(_aliasing)
	
	var _ttf = font_add(_path, _size, _bold, _italic, _start, _end)
	assert(font_exists(_ttf), "Failed to import font from {0}", _path)
	
	var _last_font = draw_get_font(),
		_last_halign = draw_get_halign(),
		_last_valign = draw_get_valign(),
		_count = _end - _start,
		_cw = _size - 1,//0,
		_ch = _size - 1 //0
	
	draw_set_font(_ttf)
	draw_set_color(c_white)
	draw_set_alpha(1)
	draw_align()
	
	//for(var _ord = _start; _ord < _end; ++_ord) {
	//	_cw = max(_cw, string_width(chr(_ord)))
	//	_ch = max(_ch, string_height(chr(_ord)))
	//}
	
	var _surface = surface_create(2048, 2048),
		_charset_buffer = buffer_create(1024, buffer_grow, 1),
		_glyphs = font_get_info(_ttf).glyphs
	
	surface_set_target(_surface)
	draw_clear_alpha(c_black, 0)
	
	var _per_row = surface_get_width(_surface) div _cw,
		_step_size = surface_get_height(_surface) div _ch,
		_frames = [],
		_n = 0
	
	//draw_rectangle(2, 1, _cw - 1, _ch, true)
	
	for(var i = 0; i < _count; ++i) {
		var _char = chr(_start + i)
		
		if (variable_struct_exists(_glyphs, _char)) {
			var _x = _cw * (_n % _per_row),
				_y = _ch * (_n div _per_row),
				_scale = min(1,
					_cw / string_width(_char),
					_ch / string_height(_char))
			
			draw_text_transformed(_x, _y, _char, _scale, _scale, 0)
			
			array_push(_frames, { x: _x, y: _y })
			buffer_write(_charset_buffer, buffer_text, _char)
			_n ++
		}
	}
	surface_reset_target()
	
	//
	buffer_write(_charset_buffer, buffer_u8, 0)
	
	//
	var _group_name = "fontgen_" + string_letters(_path),
		_fname = _group_name + ".png"
	
	//buffer_save(_charset_buffer, "charset.txt")
	surface_save(_surface, _fname)
	surface_free(_surface)
	
	font_delete(_ttf)
	
	if (texturegroup_exists(_group_name)) texturegroup_delete(_group_name)
	
	texturegroup_add(_group_name, _fname, {
		sprites: {
			"sprFontgen": {
				width: _cw,
				height: _ch,
				frames: _frames
			}
		}
	})
	
	var _sprite = array_first(texturegroup_get_sprites(_group_name)),
		_charset = buffer_peek(_charset_buffer, 0, buffer_string)
	
	if (_sep) {
		sprite_collision_mask(_sprite, true, bboxmode_automatic, 0, 0, _cw, _ch, bboxkind_precise, 0)
	}
	
	var _font = font_add_sprite_ext(_sprite, _charset, true, _sep)
	
	file_write("fontgen.json", json_stringify(font_get_info(_font), true))
	
	return _font
}