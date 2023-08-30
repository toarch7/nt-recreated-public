function bit_check(mask, bit) {
	gml_pragma("forceinline")
	
	return (mask & bit) != 0
}