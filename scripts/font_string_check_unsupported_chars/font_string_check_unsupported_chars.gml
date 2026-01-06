function font_string_check_unsupported_chars(_font, _string) {
	static __font_glyphs = {}
	
	var _font_name = font_get_name(_font), _glyphs;
	
	if (!variable_struct_exists(__font_glyphs, _font_name)) {
		_glyphs = font_get_info(_font).glyphs
		__font_glyphs[$ _font_name] = _glyphs
	}
	else {
		_glyphs = __font_glyphs[$ _font_name]
	}
	
	var _length = string_length(_string)
	
	for(var i = 1; i <= _length; ++i) {
		var _char = string_char_at(_string, i)
		
		if (!variable_struct_exists(_glyphs, _char) && _char != " " && _char != "\n") {
			return true
		}
	}
	
	return false
}