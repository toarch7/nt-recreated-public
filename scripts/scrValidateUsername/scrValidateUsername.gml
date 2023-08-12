function scrValidateUsername(opt, str, confirm) {
	if string_length(str) > 15 or (confirm && string_length(str) == 0)
		return 1
	
	var l = [ "#", "\n", "\\n", "\t", " ", "<br>", "</br>", "@", "-", "${" ]
	
	for(var i = 0; i < array_length(l); i ++) {
		if string_count(l[i], str)
			return 1
	}
}