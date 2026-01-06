/// @description scrIniToJSON(file)
/// @param file
function scrIniToJSON(_filepath) {
	var _contents = file_read(_filepath),
		_lines = array_map(string_split(_contents, "\n", true), function(_line) {
			return string_trim(_line)
		}),
		_line_count = array_length(_lines),
		_result = {}
	
	var _section = undefined
	
	for(var i = 0; i < _line_count; ++i) {
		var _line = _lines[i],
			_line_length = string_length(_line)
		
		if (_line_length == 0 || string_char_at(_line, 1) == "#") {
			continue
		}
		
		if (string_starts_with(_line, "[") && string_ends_with(_line, "]")) {
			_section = string_copy(_line, 2, _line_length - 2)
			continue
		}
		
		if (!is_string(_section)) assert(false, $"Section block expected at {_filepath}:{i}")
		
		var _equals_sign = string_pos("=", _line)
		
		if (_equals_sign == 0) assert(false, $"Expected equals sign at key declaration at {_filepath}:{i}")
		
		var _lhs = string_copy(_line, 1, _equals_sign - 1),
			_rhs = string_delete(_line, 1, _equals_sign),
			_pair = $"{_section}:{_lhs}"
		
		if (string_starts_with(_rhs, "\"") && string_ends_with(_rhs, "\"")) {
			_rhs = string_copy(_rhs, 2, string_length(_rhs) - 2)
		}
		
		_result[$ _pair] = scr_string_try_parse_const(_rhs)
	}
	
	return _result
}

function scrJSONToIni(_struct, _filepath) {
	static _buffer = buffer_create(1024, buffer_grow, 1)
	
	var _sections = {}
	
	with (_sections) {
		struct_foreach(_struct, function(_struct_key, _struct_value) {
			var _colon = string_pos_ext(":", _struct_key, string_starts_with(_struct_key, "R:") ? 3 : 1)
			if (_colon == 0) exit
			
			var _section = string_copy(_struct_key, 1, _colon - 1)
			if (!variable_struct_exists(self, _section)) self[$ _section] = {}
			
			var _key = string_delete(_struct_key, 1, _colon)
			variable_struct_set(self[$ _section], _key, _struct_value)
		})
	}
	
	buffer_seek(_buffer, buffer_seek_start, 0)
	
	with ({ buffer: _buffer, entries: undefined }) struct_foreach(_sections, function(_section, _entries) {
		entries = _entries
		
		var _keys = struct_keys(_entries)
		array_sort(_keys, true)
		
		buffer_write(buffer, buffer_text, "[")
		buffer_write(buffer, buffer_text, _section)
		buffer_write(buffer, buffer_text, "]\n")
		
		array_foreach(_keys, function(_key) {
			var _value = string(entries[$ _key])
			buffer_write(buffer, buffer_text, _key)
			buffer_write(buffer, buffer_text, "=")
			var _quote = false
			if (string_pos("#", _value) != 0) {
				buffer_write(buffer, buffer_text, "\"")
				_quote = true
			}
			buffer_write(buffer, buffer_text, _value)
			if (_quote) buffer_write(buffer, buffer_text, "\"")
			buffer_write(buffer, buffer_text, "\n")
		})
	})
	
	buffer_write(_buffer, buffer_u8, 0)
	buffer_save(_buffer, _filepath)
}





