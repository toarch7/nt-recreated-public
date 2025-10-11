function scr_keyboard_check_pressed(_keycode) {
	if is_keyboard_used_debug_overlay() && _keycode != vk_tilde {
		return false
	}
	return keyboard_check_pressed(_keycode)
}

function scr_keyboard_check_held(_keycode) {
	if is_keyboard_used_debug_overlay() && _keycode != vk_tilde {
		return false
	}
	return keyboard_check(_keycode)
}

function scr_keyboard_check_released(_keycode) {
	if is_keyboard_used_debug_overlay() && _keycode != vk_tilde {
		return false
	}
	return keyboard_check_released(_keycode)
}