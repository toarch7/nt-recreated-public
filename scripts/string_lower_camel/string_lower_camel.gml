function string_lower_camel(argument0) {
    str = argument0
    res = ""
    upr = 1

    for (__i__ = 1; __i__ <= string_length(str); __i__++) {
        char = string_copy(str, __i__, 1)

        if upr {
            res += string_upper(char)
            upr = 0
        } else res += string_lower(char)

        if char == " "
        or char == "." {
            upr = 1
        }
    }

    return res



}