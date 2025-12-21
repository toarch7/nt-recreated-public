function scr_keyboard_is_typing() {
	return is_keyboard_used_debug_overlay() || instance_exists(DebugObjectSpawner)
}

function scr_keyboard_check_pressed(_keycode) {
	/*if keyboard_check_pressed(_keycode) {
		// keypress was handled by some action
		if scrKeyboardHandleKeyPress(_keycode) {
			return false
		}
		// don't allow keypress detection when typing
		return !scr_keyboard_is_typing()
	}
	return false*/
	gml_pragma("forceinline")
	return !scr_keyboard_is_typing() && keyboard_check_pressed(_keycode)
}

function scr_keyboard_check_held(_keycode) {
	gml_pragma("forceinline")
	return !scr_keyboard_is_typing() && keyboard_check(_keycode)
}

function scr_keyboard_check_released(_keycode) {
	gml_pragma("forceinline")
	return !scr_keyboard_is_typing() && keyboard_check_released(_keycode)
}