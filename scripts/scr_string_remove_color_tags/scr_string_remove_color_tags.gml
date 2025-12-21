/// @function scr_string_sanitize
/// @param string
function scr_string_sanitize(_string) {
	static _buffer = buffer_create(256, buffer_grow, 1)
	
	buffer_seek(_buffer, buffer_seek_start, 0)
	
	var _length = string_length(_string)
	
	for(var _string_index = 1; _string_index <= _length; _string_index ++) {
		var _char = string_char_at(_string, _string_index)
		
		if _char == "@" {
			_string_index ++
			
			if string_char_at(_string, _string_index) == "(" {
				while string_char_at(_string, ++_string_index) != ")" {
					if _string_index > _length break
				}
			}
		}
		else if (_char != "\\") buffer_write(_buffer, buffer_text, _char)
	}
	
	buffer_write(_buffer, buffer_u8, 0)
	
	return buffer_peek(_buffer, 0, buffer_string)
}

/// @function string_width_pure
/// @param string
function string_width_pure(_string) {
	if (string_pos("@", _string) == 0) {
		return string_width(_string)
	}
	return string_width(scr_string_sanitize(_string))
}

/// @function string_height_pure
/// @param string
function string_height_pure(_string) {
	if (string_pos("@", _string) == 0) {
		return string_height(_string)
	}
	return string_height(scr_string_sanitize(_string))
}