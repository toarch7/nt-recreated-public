function string_starts(str, sub) {
	return string_copy(str, 1, string_length(sub)) == sub
}