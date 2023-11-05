function scrGenerateUID(input, numerical = false) {
	var sha = sha1_string_utf8(input),
		udid = ""
	
	var s = global.random_state
	
	for(var i = 1; i <= string_length(sha); i += 8) {
		var seed = real(base_convert(string_copy(sha, i, 8), 16, 10))
		
		global.random_state = seed
		
		if numerical {
			udid += string(irandom(20))
		}
		else udid += random_string(3)
	}
	
	global.random_state = s
	
	if numerical
		return real(udid)
	
	return udid
}

function random_string(len = 10) {
    var str = ""

    repeat len
        str += chr(choose(irandom_range(97, 122), irandom_range(65, 90), irandom_range(48, 57)))

    return str
}