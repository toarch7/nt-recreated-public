function scr_debug_overlay_toggle() {
	static __overlay_views_init = true
	static __last_open_timestamp = -1
	
	if __overlay_views_init {
		scr_create_debug_overlay_views()
		__overlay_views_init = false
		
		if (is_mobile) {
			show_debug_overlay(false, false, 3, 1, UberCont.opt_gamepad)
		}
	}
	
	show_debug_log(!is_debug_overlay_open())
	
	if !is_debug_overlay_open() {
		if ((current_time - __last_open_timestamp) >= 2_000) {
			scr_debug_overlay_save()
		}
	}
	else {
		__last_open_timestamp = current_time
		keyboard_string = ""
	}
}