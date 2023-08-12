function string_lower_camel(str) {
    var res = "",
		upr = 1

    for (var i = 1; i <= string_length(str); i++) {
        var char = string_char_at(str, i)

        if upr {
            res += string_upper(char)
			
            upr = 0
        }
		else res += string_lower(char)

        if char == " " or char == "."
            upr = 1
    }

    return res
}