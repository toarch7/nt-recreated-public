function string_pad_start(_string, _amount, _pad_char = " ") {
	_string = string(_string)
	
	var _count = _amount - string_length(_string)
	return string_repeat(_pad_char, _count) + _string
}

function string_pad_end(_string, _amount, _pad_char = " ") {
	_string = string(_string)
	
	var _count = _amount - string_length(_string)
	return _string + string_repeat(_pad_char, _count)
}

/// @function string_pad_zeroes
/// @param {Real|String} value
/// @param pad_amount=2
function string_pad_zeroes(_value, _number = 2) {
	return string_pad_start(string(_value), _number + 1, "0")
}