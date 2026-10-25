function is_directional_ui(_index = global.index) {
	gml_pragma("forceinline")
	// TODO: this currently doesn't support multi-input
	return (is_gamepad(_index) || (is_keyboard(_index) && UberCont.directional_ui_control))
}