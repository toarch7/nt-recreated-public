function is_touch(_index = global.index) {
	gml_pragma("forceinline")
	return KeyCont.touch[_index]
}