function scr_debug_overlay_toggle() {
	static __overlay_views_init = true
	static __last_open_timestamp = -1
	
	if __overlay_views_init {
		scr_create_debug_overlay_views()
		__overlay_views_init = false
	}
	
	show_debug_log(!is_debug_overlay_open())
	
	if !is_debug_overlay_open() {
		if ((current_time - __last_open_timestamp) >= 5_000) {
			scr_debug_overlay_save()
		}
	}
	else {
		__last_open_timestamp = current_time
	}
}