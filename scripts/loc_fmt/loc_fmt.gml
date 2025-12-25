#macro mcr_loc_fmt \
	if (argument_count <= _format_argument_index || string_pos("%", _str) == 0) return _str \
	var _format_count = argument_count - _format_argument_index, \
		_format_index = 0 \
	repeat _format_count { \
		var _indexed = "%" + string(++_format_index) \
		if (string_pos(_indexed, _str) != 0) { \
			_str = string_replace_all(_str, \
				_indexed, string(argument[_format_argument_index])) \
		} \
		else { \
			_str = string_replace(_str, \
				"%", string(argument[_format_argument_index])) \
		} \
		_format_argument_index ++ \
	}

/// @function loc_fmt
/// @param key
/// @param default
function loc_fmt(_key, _default) {
	var _str = global.language_current[$ _key]
	if (!is_string(_str)) _str = (_default ?? _key)
	var _format_argument_index = 2; mcr_loc_fmt;
	
	return _str
	
	// trick gamemaker into thinking
	if (false) delete argument[0]
}


/// @function loc_fmt_either
/// @description Like `loc_fmt`, which can fallback to `key2` if the `key1` is actively undefined
/// @param key1
/// @param key2
/// @param default
function loc_fmt_either(_key1, _key2, _default) {
	var _key = (loc_exists(_key1) ? _key1 : _key2),
		_str = (global.language_current[$ _key] ?? _default)
	var _format_argument_index = 3; mcr_loc_fmt;
	return _str
	
	// trick gamemaker into thinking
	if (false) delete argument[0]
}
