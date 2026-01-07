function string_insert_wordwraps(_string, _width) {
	static _buffer = buffer_create(512, buffer_grow, 1)
	
	var _length = string_length(_string),
		_ctx = {
			width: _width,
			buffer: _buffer,
			word: "",
			size: 0,
			length: string_length(_string)
		}
	
	buffer_seek(_buffer, buffer_seek_start, 0)
	
	with (_ctx) string_foreach(_string, function(_char, _index) {
		var _ww = font_get_string_width(word), _nw = _ww + 14
		if (_char == "\n") {
			buffer_write(buffer, buffer_text, word + "\n")
			word = ""
			size = 0
		}
		else if (_char == " " || _index == length || _nw >= width) {
			if (_nw >= width) {
				buffer_write(buffer, buffer_text, word)
				buffer_write(buffer, buffer_text, "\n")
				word = ""
				size = 0
				exit
			}
			if (string_length(word)) {
				size += _ww
				if ((size + 14) >= width) {
					buffer_write(buffer, buffer_text, "\n")
					size = 0
				}
				buffer_write(buffer, buffer_text, word)
				word = ""
			}
			buffer_write(buffer, buffer_text, " ")
		}
		else word += _char
	})
	
	if (string_length(_ctx.word)) buffer_write(_buffer, buffer_text, _ctx.word)
	
	buffer_write(_buffer, buffer_u8, 0)
	return buffer_peek(_buffer, 0, buffer_string)
}