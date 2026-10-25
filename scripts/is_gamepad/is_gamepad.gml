function is_gamepad(_index = global.index) {
	gml_pragma("forceinline")
	return KeyCont.gamepad[_index]
}