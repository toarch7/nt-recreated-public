global.__window_borderless_fs_enabled = true
global.__window_borderless_fs_active = false
global.__window_borderless_width = game_screen_width
global.__window_borderless_height = game_screen_height
global.__window_borderless_fs_target = false
global.__window_borderless_fs_requested = false
global.__window_borderless_x = 0
global.__window_borderless_y = 0

function scr_window_set_fullscreen(_fullscreen) {
	if is_mobile/* || (global.option_force_fullscreen && !_fullscreen && scr_window_get_fullscreen())*/
		exit
	
	// TODO: implement borderless fullscreen toggle
	if !global.__window_borderless_fs_enabled {
		window_enable_borderless_fullscreen(false)
		window_set_fullscreen(_fullscreen)
		exit
	}
	
	if global.__window_borderless_fs_active == _fullscreen exit
	
	if (!global.__window_borderless_fs_requested
		|| global.__window_borderless_fs_target != _fullscreen
	) {
		global.__window_borderless_fs_target = _fullscreen
		global.__window_borderless_fs_requested = true
	}
	
	if !window_has_focus() exit
	
	window_enable_borderless_fullscreen(_fullscreen)
	window_set_fullscreen(_fullscreen)
	
	if _fullscreen {
		var _window_height = window_get_height(),
			_window_width = _window_height * scr_display_get_aspect_ratio()
		
		global.__window_borderless_width = _window_width
		global.__window_borderless_height = _window_height
		
		global.__window_borderless_x = window_get_x()
		global.__window_borderless_y = window_get_y()
		
		window_set_position(0, 0)
	}
	else {
		scrWindowUpdateWindowedPosition()
	}
	
	global.__window_borderless_fs_active = _fullscreen
}

function scr_window_get_fullscreen() {
	if (is_mobile) return false
	
	// TODO: implement borderless fullscreen toggle
	if global.__window_borderless_fs_enabled {
		if !global.__window_borderless_fs_active
			return false
		
		return window_get_width() >= scr_display_get_width()
			&& window_get_height() >= scr_display_get_height()
	}
	
	return window_get_fullscreen()
}

function scr_display_get_aspect_ratio() {
	return scr_display_get_width() / scr_display_get_height()
}

function scr_display_get_width() {
	return display_get_width()
}

function scr_display_get_height() {
	return display_get_height()
}
