var index = global.index

if native_cursor_inst != -1
	native_cursor_update()

input_tick()

#region Opening & closing debug overlay
if !public && scr_keyboard_check_pressed(vk_tilde) {
	show_debug_log(!is_debug_overlay_open())
	keyboard_string = ""
}

if (is_debug_overlay_open()) {
	if (keyboard_check_pressed(vk_escape)
		|| (is_mobile && !keyboard_virtual_status() && keyboard_check_pressed(vk_backspace))
	) {
		if (is_desktop) {
			keyboard_clear(vk_escape)
		}
		show_debug_log(false)
	}
}

if is_desktop {
	if (is_mouse_over_debug_overlay()) {
		if window_get_cursor() == cr_none {
			window_set_cursor(cr_default)
		}
	}
	else if window_get_cursor() == cr_default {
		window_set_cursor(cr_none)
	}
}
#endregion

if splatindex < 3 && paused
    splatindex ++

for (var i = 0; i < player_count; i++) {
	if want_pause break
	
    if KeyCont.press_paus[i] && !instance_exists(GenCont) && !instance_exists(Credits) && !instance_exists(Cinematic) {
        if !scrGameIsPaused() {
            if instance_exists(Player) {
				KeyCont.press_paus[i] = false
                scrGamePause()
            }
        }
		else {
			// Activate `Continue`
            with PauseButton {
                if image_index == 3 {
                    clicked = true
                    event_user(0)
                }
            }
        }

        break
    }
}

KeyCont.press_paus[index] = scr_keyboard_check_pressed(vk_escape) || scr_keyboard_check_pressed(vk_backspace) || gamepad_button_check_pressed(0, gp_start)
		|| (!paused && !want_pause && ((opt_autopause && !instance_exists(CoopController) && is_desktop && !window_has_focus()) || os_is_paused()))

if global.console_active {
	KeyCont.press_paus[index] = false
}

if !lockstep_stop && !paused {
    var _left = view_xview - 32,
		_right = view_xview + view_width + 32,
		_top = view_yview - 32,
		_bottom = view_yview + view_height + 32,
		
		_wall_list = global.lis_walls_visible,
		_floor_list = global.list_floors_visible,
		
		_camera_boundaries_check = (!instance_exists(Cinematic))
	
    ds_list_clear(_wall_list)
    ds_list_clear(_floor_list)
	
	if _camera_boundaries_check {
	    with Wall {
	        if bbox_right >= _left && bbox_bottom >= _top && bbox_left < _right && bbox_top < _bottom {
	            ds_list_add(_wall_list, id)
	        }
	    }
		with Floor {
	        if bbox_right >= _left && bbox_bottom >= _top && bbox_left < _right && bbox_top < _bottom {
	            ds_list_add(_floor_list, id)
	        }
	    }
	}
	else {
		with Wall {
			ds_list_add(_wall_list, id)
		}
		with Floor {
			ds_list_add(_floor_list, id)
		}
	}
	
	if opt_console && !instance_exists(Console) {
	    instance_create(0, 0, Console)
	}
}

if mainvol < 1 {
    mainvol = lerp(mainvol, 1, 0.4)
}

audio_emitter_gain(mainsound, opt_sndvol * mainvol)
camera_set_view_pos(view_camera[0], view_xview, view_yview)

current_frame ++

if paused && !global.console_active && instance_exists(PauseButton) {
	// Restart hotkey
	if scr_keyboard_check_pressed(ord("R")) {
		with PauseButton {
			if image_index == 1 || image_index == 6 {
				event_user(0)
				KeyCont.press_paus[index] = 0
				break
			}
		}
	}
	
	// Quit hotkey
	if scr_keyboard_check_pressed(vk_escape) || scr_keyboard_check_pressed(vk_backspace) {
		with PauseButton {
			if image_index == 3 {
				event_user(0)
				KeyCont.press_paus[index] = 0
				break
			}
		}
	}
}

if opt_gamepad {
	scrGamepadUIControl()
}

if !paused && !want_pause && !instance_exists(PauseButton) {
	scrHandleInputsGeneral(global.index)
}

if instance_exists(CoopController) {
	with CoopController
		event_user(0)
}

if is_desktop {
	if window_has_focus() && scr_window_get_fullscreen() != global.__window_borderless_requested {
		scr_window_set_fullscreen(global.__window_borderless_requested)
	}
}