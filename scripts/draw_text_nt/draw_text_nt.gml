globalvar __render_text_cache_normal, __render_text_cache_linebreaks, __render_text_shadows, __render_text_surface;

/// @ignore
enum TextRenderFragment {
	String,
	Sprite,
	Color,
	Tag
}

__render_text_cache_normal = {}
__render_text_cache_linebreaks = {}
__render_text_shadows = true
__render_text_surface = -1

function render_text_shadows(_state) {
	__render_text_shadows = _state
}

function render_text_reset() {
	__render_text_shadows = false
}

/// @ignore
function render_parse_text(_text) {
	var _def_width = 0,
		_def_height = 0,
		_length = string_length(_text),
		_line_width = _def_width,
		_line_height = _def_height,
		_str = "", _string_index = 1,
		_escape = false
	
	for(var i = _length; i >= 1; --i) {
		var _char = string_char_at(_text, i)
		if (_char != " ") {
			_def_height = max(_def_height, font_get_string_height(_char))
		}
	}
	
	var _lines = [],
		_strings = [],
		_itsover = false,
		_line_sprite_width = 0,
		_space_width = font_get_string_width(" "),
		_width = 0,
		_height = 0
	
	static __render_parse_move_lines = function(_lines, _xoffset, _yoffset) {
		var _count = array_length(_lines)
		
		for(var _string_index = _count - 1; _string_index >= 0; _string_index --) {
			var _line = _lines[_string_index]
			_line.x += _xoffset
			_line.y += _yoffset
		}
	}
	
	while (!_itsover) {
		var _char = string_char_at(_text, _string_index ++),
			_over = (ord(_char) == 0) || (_string_index > _length && string_length(_str))
		
		if _over {
			_itsover = true
		}
		
		if _char == "\\" {
			_escape = true
			continue
		}
		
		if _escape {
			_str += _char
			_escape = false
			
			if !_over {
				continue
			}
		}
		
		var _linebreak = _char == "\n";
		
		// string end
		if _char == "@" || _linebreak || _over {
			// add the last collected word
			if _over && _char != "\n" {
				_str += _char
			}
			
			var _w = font_get_string_width(_str),
				_h = font_get_string_height(_str)
			
			array_push(_strings, {
				"type" : TextRenderFragment.String,
				"string" : _str,
				"width" : _w,
				"height" : _h
			})
			
			_line_width += _w
			_line_height = max(_line_height, _h)
			
			// line end
			if _linebreak || _over {
				array_push(_lines, {
					"width" : _line_width,
					"height" : _line_height,
					"strings" : _strings
				})
				
				_strings = []
				
				_width = max(_width, _line_width)
				_height += _line_height
				
				_line_width = _def_width
				_line_height = _def_height
				
				_line_sprite_width = 0
			}
			
			if _char == "@" {
				var _tag = ""
				
				if (string_char_at(_text, _string_index) == "("
					&& string_char_at(_text, _string_index + 2) != ")"
				) {
					var _index = 0,
						_xoffset = 0,
						_yoffset = 0
					
					// parse name
					while _string_index <= _length {
						var _char = string_char_at(_text, ++ _string_index)
						
						if _char == ")" {
							_string_index ++; break
						}
						
						_tag += _char
					}
					
					var _parameters = string_split(_tag, ",", false, 3),
						_parameter_count = array_length(_parameters)
					
					for(var i = _parameter_count - 1; i >= 1; --i) {
						try {
							var _index_str = _parameters[i]
							/**/ if (i == 1) _index = real(_index_str)
							else if (i == 2) _xoffset = real(_index_str)
							else if (i == 3) _yoffset = real(_index_str)
						}
						catch(e) { /* ... */ }
					}
					
					if (_parameter_count > 1) _tag = array_first(_parameters)
					
					var _spr = handle_parse(_tag)
					
					if (!sprite_exists(_spr)) {
						_spr = asset_get_index(_tag)
					}
					
					if (!sprite_exists(_spr)) {
						print("draw_text_nt: Unknown sprite:", _tag)
						_spr = mskNone
					}
					
					var _w = sprite_get_width(_spr),
						_h = sprite_get_height(_spr),
						_left = sprite_get_bbox_left(_spr),
						_top = sprite_get_bbox_top(_spr)
					
					_w = sprite_get_bbox_right(_spr) - _left
					_h = sprite_get_bbox_bottom(_spr) - _top
					
					//if _xoffset < 0 || _yoffset < 0 {
					//	__render_parse_move_lines(_lines, _xoffset, _yoffset)
					//}
					
					array_push(_strings, {
						"type"         : TextRenderFragment.Sprite,
						"width"        : _w,
						"height"       : _h,
						"sprite_index" : _spr,
						"image_index"  : _index,
						"xoffset"      : _xoffset,
						"yoffset"      : _yoffset
					})
					
					_line_width += _w
					_line_sprite_width += _w
					_line_height = max(_line_height, _h)
				}
				else {
					// parse _tag
					var _tag, _color = -1, _formatting = -1
					
					if (string_char_at(_text, _string_index + 2) == ")") {
						_tag = string_lower(string_char_at(_text, _string_index + 1))
						_string_index += 3
					}
					else {
						_tag = string_lower(string_char_at(_text, _string_index ++))
					}
					
					switch _tag {
						case "s": _color = make_color_rgb(125, 131, 141); break // silver (gray)
						case "b": _color = make_color_rgb(22, 97, 223); break // blue
						case "r": _color = make_color_rgb(252, 56, 0); break // red
						case "y": _color = make_color_rgb(250, 171, 0); break // yellow (more like orange if you ask me)
						case "d": _color = make_color_rgb(59, 62, 67); break // dark gray
						case "g": _color = make_color_rgb(68, 198, 22); break // green
						case "p": _color = make_color_rgb(86, 34, 110); break // purple
						case "w": _color = c_white; break // white
						
						default:
							_formatting = _tag; break
					}
					
					if _color != -1 {
						array_push(_strings, {
							"type"  : TextRenderFragment.Color,
							"color" : _color
						})
					}
					else if _formatting != -1 {
						array_push(_strings, {
							"type"  : TextRenderFragment.Tag,
							"tag"   : _formatting
						})
					}
					
					/* save for later I think
					while true {
						var o = string_ord_at(_text, _string_index ++)
						
						if o > 90
							o -= 32
						
						if o < 65 or o > 90 {
							_string_index --; break
						}
						
						_tag += string_char_at(_text, _string_index - 1)
						
					}*/
				}
			}
			
			_str = ""
			
			continue
		}
		
		_str += _char
	}
	
	return {
		lines : _lines,
		width : _width,
		height: _height
	}
}

/// @function draw_text_nt
/// @param {Real} x
/// @param {Real} y
/// @param {String} text
/// @param {Real} [xscale=1]
/// @param {Real} [yscale=xscale]
/// @param {Real} [angle=0]
/// @param {Real} [color=draw_get_color]
/// @param {Real} [alpha=draw_get_alpha]
function draw_text_nt(_x, _y, _text, _xscale = 1, _yscale = _xscale, _angle = 0, _blend = draw_get_color(), _alpha = draw_get_alpha()) {
	static __surface = -1
	
	if string_length(_text) == 0 {
		exit
	}
	
	_text = string_hash_to_newline(string(_text))
	
	//_text = string(font_get_name(draw_get_font())) + " " + _text
	///**/ if (draw_get_valign() == fa_top) _text = "t | " + _text
	//else if (draw_get_valign() == fa_middle) _text = "m | " + _text
	//else if (draw_get_valign() == fa_bottom) _text = "b | " + _text
	
	if string_pos("@", _text) == 0 && string_pos("\n", _text) == 0 {
		draw_text_transformed_color(_x + 1, _y, _text, _xscale, _yscale, 0, c_black, c_black, c_black, c_black, _alpha)
		draw_text_transformed_color(_x, _y + 1, _text, _xscale, _yscale, 0, c_black, c_black, c_black, c_black, _alpha)
		draw_text_transformed_color(_x + 1, _y + 1, _text, _xscale, _yscale, 0, c_black, c_black, c_black, c_black, _alpha)
		draw_text_transformed_color(_x, _y, _text, _xscale, _yscale, 0, _blend, _blend, _blend, _blend, _alpha)
		
		exit
	}
	
	var _halign = draw_get_halign(),
		_valign = draw_get_valign(),
		_last_color = draw_get_color(),
		_last_alpha = draw_get_alpha(),
		_shadows = __render_text_shadows,
		_key = $"{font_get_name(draw_get_font())}:{_text}"
	
	draw_set_color(_blend)
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
	var _info = __render_text_cache_normal[$ _key]
		
	if is_undefined(_info) {
		_info = render_parse_text(_text)
		__render_text_cache_normal[$ _key] = _info
	}
	
	var _lines = _info.lines,
		_line_count = array_length(_lines),
		
		_width = _info.width + 24,
		_height = _info.height + 8
	
	if surface_exists(__surface) {
		if !(surface_get_width(__surface) == _width && surface_get_height(__surface) == _height) {
			surface_resize(__surface, _width, _height)
		}
	}
	else {
		__surface = surface_create(_width, _height)
	}
	
	var _is_bold = false,
		_shaking_text = 0,
		_xmove = sign(_xscale),
		_ymove = sign(_yscale),
		_max_line_width = 0,
		_xpos = 2,
		_ypos = 4
	
	if _halign == fa_right {
		_xmove *= -1
	}
	
	if _valign == fa_bottom {
		_ypos = _height
		_ymove *= -1
	}
	
	surface_set_target(__surface)
	
	draw_clear_alpha(c_black, 0)
	
	for(var _line_index = 0; _line_index < _line_count; _line_index ++) {
		var _line = _lines[_line_index],
			_string_list = _line.strings,
			_string_count = array_length(_string_list),
			_xpos = 0
		
		if _halign == fa_center {
			_xpos += _width * 0.5 - _line.width * 0.5
		}
		else if _halign == fa_right {
			_max_line_width = max(_max_line_width, _line.width)
			_xpos = _width - _line.width
		}
		
		for(var _string_index = 0; _string_index < _string_count; _string_index ++) {
			var _fragment = _string_list[_string_index],
				
				_dx = _xpos,
				_dy = _ypos
			
			if _shaking_text > 0 {
				_dx += orandom(_shaking_text)
				_dy += orandom(_shaking_text)
			}
			
			if _fragment.type == TextRenderFragment.String {
				if _xmove == -1 _xpos += _fragment.width
				
				if _shadows {
					draw_text_color(_dx + 1, _dy + 1, _fragment.string, c_black, c_black, c_black, c_black, 1)
					draw_text_color(_dx, _dy + 1, _fragment.string, c_black, c_black, c_black, c_black, 1)
					
					if _is_bold {
						draw_text_color(_dx + 2, _dy + 1, _fragment.string, c_black, c_black, c_black, c_black, 1)
						draw_text_color(_dx + 1, _dy + 1, _fragment.string, c_black, c_black, c_black, c_black, 1)
					}
				}
				
				draw_text(_dx, _dy, _fragment.string)
				
				if _is_bold {
					draw_text(_dx + 1, _dy, _fragment.string)
				}
				
				if _xmove == 1 _xpos += _fragment.width
			}
			else if _fragment.type == TextRenderFragment.Sprite {
				draw_sprite_ext(
					_fragment.sprite_index,
					_fragment.image_index,
					
					_dx + _fragment.xoffset + (_fragment.width - 8) + 1,
					_dy + _fragment.yoffset + (_fragment.height - 8) + font_get_height_diff() + 1,
					
					1, 1, 0, c_white, draw_get_alpha())
				
				_xpos += _fragment.width * _xmove
			}
			else if _fragment.type == TextRenderFragment.Color {
				draw_set_color(_fragment.color)
			}
			else if _fragment.type == TextRenderFragment.Tag {
				if _fragment.tag == "." {
					// reset styles
					draw_set_color(_blend)
					_is_bold = false
					_shaking_text = 0
				}
				else if _fragment.tag == "q" {
					_shaking_text ++
				}
				else if _fragment.tag == "[" {
					_is_bold = true
				}
				else if _fragment.tag == "]" {
					_is_bold = false
				}
			}
		}
		
		_ypos += _line.height * _ymove
	}
	
	surface_reset_target()
	
	var _shader = false
	
	if _halign == fa_center {
		_x -= _width * 0.5 * _xscale
	}
	else if _halign == fa_right {
		_x -= _width
	}
	
	if _valign == fa_middle {
		_y -= _height * 0.5 * _yscale
	}
	//else if _valign == fa_bottom {
	//	_y -= _height * _yscale
	//}
	
	draw_surface_ext(
		__surface,
		_x,// + font_xoffset,
		_y,// + font_yoffset,
		_xscale, _yscale, _angle,
		c_white, _alpha)
	
	if _shader {
		shader_reset()
	}
	
	draw_set_color(_last_color)
	draw_set_alpha(_last_alpha)
	
	draw_set_halign(_halign)
	draw_set_valign(_valign)
}

function render_text_sanitize_string(_string) {
	static _buffer = buffer_create(256, buffer_grow, 1)
	
	buffer_seek(_buffer, buffer_seek_start, 0)
	
	var _length = string_length(_string)
	
	for(var _string_index = 1; _string_index <= _length; _string_index ++) {
		var _char = string_char_at(_string, _string_index)
		
		if _char == "@" {
			_string_index ++
		}
		else if _char != "\\" {
			buffer_write(_buffer, buffer_text, _char)
		}
	}
	
	buffer_write(_buffer, buffer_u8, 0)
	
	return string_hash_to_newline(buffer_peek(_buffer, 0, buffer_string))
}