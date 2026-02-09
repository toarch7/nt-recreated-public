function scrGenerateUID(_input, _numerical = false) {
	var _sha = sha1_string_utf8(string(_input)),
		_number_base = string_crc32(_sha),
		_result = ""
	
	repeat (15) {
		var _number = _number_base
		_number ^= _number << 13
		_number ^= _number >> 17
		_number ^= _number << 5
		_number &= 0x7fffffff
		
		if (_numerical) return _number
		
		if (_number & 2) {
			_result += chr(97 + (_number & 25))
		}
		else {
			_result += chr(65 + (_number & 25))
		}
		
		_number_base = _number
	}
	
	return _result
}