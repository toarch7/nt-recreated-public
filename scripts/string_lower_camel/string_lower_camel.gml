/// @function string_lower_camel
/// @param string
/// @param uppercase_first=false
function string_lower_camel(_string, _uppercase_first=false) {
    var _result = "",
		_uppercase_next = _uppercase_first,
		_length = string_length(_string)
	
    for (var i = 1; i <= _length; ++i) {
        var _char = string_char_at(_string, i)

        if _uppercase_next {
            _result += string_upper(_char)
            _uppercase_next = false
			continue
        }
		
		_result += string_lower(_char)
		
        if (_char == " " || _char == ".") _uppercase_next = 1
    }

    return _result
}