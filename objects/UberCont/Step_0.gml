var _index = global.index

if native_cursor_inst != -1
	native_cursor_update()

input_tick()

scrHandleInputsGeneral(global.index)

scrGamepadUIControl()

if (instance_exists(CoopController)) {
	with (CoopController) event_user(0)
}

if (splatindex < 3 && paused) splatindex ++

if (!KeyCont.press_paus[_index]) {
	KeyCont.press_paus[_index] = scr_keyboard_check_pressed(vk_escape)
		|| scr_keyboard_check_pressed(vk_backspace) || gamepad_button_check_pressed(0, gp_start)
	
	if !paused && !want_pause && (!is_desktop || (!instance_exists(CoopController) && opt_autopause)) {
		if (is_desktop ? (!window_has_focus()) : os_is_paused()) {
			KeyCont.press_paus[_index] = true
		}
	}
}


for (var i = 0; i < player_count; i++) {
	if (KeyCont.press_paus[i]) {
		KeyCont.press_paus[i] = false
		if (want_pause) break
		
		if scrGameIsPaused() {
			// Activate `Continue`
		    with PauseButton {
		        if image_index == 3 {
		            clicked = true
		            event_user(0)
		        }
		    }
		}
		else if !scrGameIsPaused() && scrGameCanPause() {
			scrGamePause()
		}
	}
}

if (!lockstep_stop && !paused && !instance_exists(PauseImage)) {
    var _left = view_xview - 32,
		_right = view_xview + view_width + 32,
		_top = view_yview - 32,
		_bottom = view_yview + view_height + 32,
		
		_wall_list = global.lis_walls_visible,
		_floor_list = global.lis_floors_visible,
		
		_camera_boundaries_check = (!instance_exists(Cinematic))
	
    ds_list_clear(_wall_list)
    ds_list_clear(_floor_list)
	
	if (_camera_boundaries_check) {
	    with (Wall) {
	        if (bbox_right >= _left && bbox_bottom >= _top && bbox_left < _right && bbox_top < _bottom) {
	            ds_list_add(_wall_list, id)
	        }
	    }
		with (Floor) {
	        if (bbox_right >= _left && bbox_bottom >= _top && bbox_left < _right && bbox_top < _bottom) {
	            ds_list_add(_floor_list, id)
	        }
	    }
	}
	else {
		with (Wall) ds_list_add(_wall_list, id)
		with (Floor) ds_list_add(_floor_list, id)
	}
}

if mainvol < 1 {
    mainvol = lerp(mainvol, 1, 0.4)
}

audio_emitter_gain(mainsound, opt_sndvol * mainvol)
camera_set_view_pos(view_camera[0], view_xview, view_yview)

current_frame ++

if (opt_keyboard && instance_exists(PauseButton)) {
	// Restart hotkey
	if (scr_keyboard_check_pressed(ord("R"))) {
		with PauseButton {
			if image_index == 1 || image_index == 6 {
				event_user(0)
				KeyCont.press_paus[_index] = false
				break
			}
		}
	}
	
	// Quit hotkey
	if scr_keyboard_check_pressed(vk_escape) || scr_keyboard_check_pressed(vk_backspace) {
		with PauseButton {
			if image_index == 3 {
				event_user(0)
				KeyCont.press_paus[_index] = false
				break
			}
		}
	}
}

if (is_desktop) {
	if (scr_keyboard_check_held(vk_alt) && scr_keyboard_check_pressed(vk_enter)) {
		opt_fullscreen = !opt_fullscreen
		scr_window_set_fullscreen(opt_fullscreen)
	}
	
	if (global.__window_borderless_fs_requested) {
		if (scr_window_get_fullscreen() != global.__window_borderless_fs_target) {
			if (window_has_focus()) {
				scr_window_set_fullscreen(global.__window_borderless_fs_target)
			}
		}
		else {
			global.__window_borderless_fs_requested = false
		}
	}
}

if (instance_exists(TestCont) && global.__debug_test_framerate_uncapped) {
	if (!test_framerate_uncapped) {
		if (game_get_speed(gamespeed_fps) != game_speed_uncaped) {
			game_set_speed(game_speed_uncaped, gamespeed_fps)
			display_reset(display_aa, false)
		}
		test_framerate_uncapped = true
	}
	else if (is_desktop) {
		draw_enable_drawevent(((current_frame % 30) < timescale) || window_has_focus())
	}
}
else if (test_framerate_uncapped) {
	if (game_get_speed(gamespeed_fps) == game_speed_uncaped) {
		display_reset(display_aa, opt_vsync)
		game_set_speed(30, gamespeed_fps)
	}
	test_framerate_uncapped = false
}

if instance_exists(TestCont) {
	with (TestCont) event_user(0)
}

if (is_desktop) {
	if (!opt_keyboard || is_mouse_over_debug_overlay()) {
		if window_get_cursor() == cr_none {
			window_set_cursor(cr_default)
		}
	}
	else if (window_get_cursor() == cr_default) {
		window_set_cursor(cr_none)
	}
}

// manual handling for closing debug overlay console
// because gamemaker automatically puts you into typing mode
// once it opens the `scrKeyboardHandleKeyPress` doesn't get
// run from Keypress - Any becuse the event is suppressed
if (is_debug_overlay_open()
	&& (keyboard_check_pressed(vk_escape) || (!is_keyboard_used_debug_overlay() && keyboard_check_pressed(vk_backspace)))
) {
	scr_debug_overlay_toggle()
	keyboard_clear(vk_backspace)
	keyboard_clear(vk_escape)
}