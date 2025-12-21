function scrKeyboardHandleKeyPress(_keycode) {
	switch (_keycode) {
		case vk_escape:
			if instance_exists(DebugObjectSpawner) {
				instance_destroy(DebugObjectSpawner)
				return true
			}
			if is_debug_overlay_open() {
				scr_debug_overlay_toggle()
				return true
			}
		break
		case vk_backspace:
			return instance_exists(DebugObjectSpawner)
		break
		case vk_tilde:
			#region Opening & closing debug overlay
			with (UberCont) {
				if (public) break
				
				scr_debug_overlay_toggle()
				keyboard_string = ""
				
				if (is_debug_overlay_open()) {
					if (keyboard_check_pressed(vk_escape)
						|| (is_mobile && !keyboard_virtual_status() && keyboard_check_pressed(vk_backspace))
					) {
						if (is_desktop) {
							keyboard_clear(vk_escape)
						}
						show_debug_log(false)
					}
					instance_destroy(DebugObjectSpawner)
				}
				return true
			}
			#endregion
		break
	}
	
	return false
}

