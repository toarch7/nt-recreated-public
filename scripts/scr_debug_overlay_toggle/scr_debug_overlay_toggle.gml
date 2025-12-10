function scr_debug_overlay_toggle() {
	static __overlay_views_init = true
	
	if __overlay_views_init {
		scr_create_debug_overlay_views()
		__overlay_views_init = false
	}
	
	show_debug_log(!is_debug_overlay_open())
}