/// @function loc
/// @param key
/// @param [...]
/// @param default
function loc(_key, _default = _key) {
	if (argument_count == 2) {
	    return global.language_current[$ string(_key)] ?? _default
	}
	for(var i = 1; i < argument_count - 1; ++i) {
		_key += ":" + string(argument[i])
	}
	return global.language_current[$ string(_key)] ?? _default
}

/// @function loc_lang
/// @param language
/// @param key
/// @param default=key
function loc_lang(_language, _key, _default = _key) {
	var _language_data = global.language_store[$ string(_language)]
	if (is_struct(_language_data)) {
		return _language_data[$ _key] ?? _default
	}
	return _default
}

/// @function loc_exists
/// @param
function loc_exists(_key) {
	if (argument_count == 1) {
		var _str = global.language_current[$ string(_key)]
		return is_string(_str) && string_length(_str) != 0
	}
	for(var i = 0; i < argument_count; ++i) {
		_key += ":" + string(argument[i])
	}
	var _str = global.language_current[$ _key]
    return is_string(_str) && string_length(_str) != 0
}