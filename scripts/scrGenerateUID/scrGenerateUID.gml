function scrGenerateUID(input, numerical = false) {
	var _sha = sha1_string_utf8(input),
		_seed = random_get_seed(),
		_udid = ""
	
	random_set_seed(0x7fff)
	
	for(var i = 1; i <= string_length(_sha); i += 8) {
		var _seed = real(base_convert(string_copy(_sha, i, 8), 16, 10))
		
		if numerical {
			_udid += string(irandom(20))
		}
		else _udid += random_string(3)
	}
	
	if numerical {
		return real(_udid)
	}
	
	return _udid
}

function random_string(len = 10) {
    var str = ""

    repeat len {
        str += chr(choose(
			irandom_range(97, 122),
			irandom_range(65, 90),
			irandom_range(48, 57)))
	}
	
    return str
}