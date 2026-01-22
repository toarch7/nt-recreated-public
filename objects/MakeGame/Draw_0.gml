if disclaimer {
	draw_align(fa_center, fa_middle)
	draw_reset_font()
    
	var _dx = view_width div 2,
		_dy = view_height div 2,
		
		_exclamation_color = (get_timer() / 33333) % 60 > 30 ? "@r" : "@s"
	
	if (disclaimer_setup) {
		disclaimer_message = string_insert_wordwraps(string_hash_to_newline(
			loc("R:Intro:ProjectDisclaimerText", disclaimer_message)), game_screen_width)
		
		disclaimer_setup = false
	}
	
	/// @loc:token [R:Intro] ProjectDisclaimerExclamationsLeft "!!!"
	/// @loc:token [R:Intro] ProjectDisclaimerExclamationsRight "!!!"
	var _left = _exclamation_color + loc("R:Intro:ProjectDisclaimerExclamationsLeft", "!!!"),
		_right = _exclamation_color + loc("R:Intro:ProjectDisclaimerExclamationsRight", "!!!")
	
	/// @loc:token [R:Intro] ProjectDisclaimerTitle "DISCLAIMER"
	var _title = _left + " " + loc("R:Intro:ProjectDisclaimerTitle", "DISCLAIMER") + " " + _right + "@w",
		_disclaimer_message = disclaimer_message
	
	if (!string_starts_with(_disclaimer_message, "\n")) {
		_disclaimer_message = "\n" + _disclaimer_message
	}
	
	var _disclaimer_text = _title + _disclaimer_message
	draw_text_nt(_dx, _dy, _disclaimer_text)
	
	disclaimer ++
	
	if disclaimer >= 90 {
		/// @loc:token [R:Intro] DisclaimerContinue "CLICK TO CONTINUE"
		var _continue_string = loc("R:Intro:DisclaimerContinue", "CLICK TO CONTINUE"),
			_offset = ceil(font_get_string_height(_disclaimer_text) * 0.5),
			_button_y = min(_dy + _offset + 16, view_height - 14)
		
		if (disclaimer == 90 || device_mouse_y_to_gui(0) > _button_y) {
			if (!disclaimer_continue_pointed) {
				disclaimer_continue_pointed = true
				snd_play(sndHover)
			}
			_continue_string = "@w" + _continue_string
			_button_y += (disclaimer == 90) ? 2 : 1
			draw_set_color(c_white)
		}
		else {
			_continue_string = "@s" + _continue_string
			disclaimer_continue_pointed = false
			draw_set_color(c_silver)
		}
		
		draw_set_valign(fa_top)
		draw_text_nt(_dx, _button_y, _continue_string)
		
		if ((mouse_ui_clicked() && disclaimer_continue_pointed) || keyboard_anykey() || scrGamepadAnykey() != -1) {
			save_set_value("etc", "disclaimer", true)
			event_perform(ev_alarm, 0)
		}
	}
	
	draw_set_color(c_white)
	draw_align()
	
	exit
}

if loading {
	scr_camera_set_position(0, 0)
	
    try {
        var _cx = gui_w / 2,
			_cy = gui_h / 2,
			
			_mx = device_mouse_x_to_gui(0),
			_my = device_mouse_y_to_gui(0),
			
			_left = _cx - 64,
			_right = _cx + 48,
			
			_options_y = _cy + 40 + posy,
			
			_point_left = point_in_circle(_mx, _my, _left, _options_y, 16),
			_point_right = point_in_circle(_mx, _my, _right, _options_y, 16),
			
			/// @loc:token [R:Intro] LoadGameYes "YES"
			_text_yes = loc("R:Intro:LoadGameYes", "YES"),
			/// @loc:token [R:Intro] LoadGameNo "NO"
			_text_no = loc("R:Intro:LoadGameNo", "NO")
		
        scrDrawRoadmap(_cx, _cy, pos)
        with (TopCont) scrDrawPlayerHUD(scrPlayerFindLocal())
		
        draw_set_halign(fa_center)
		/// @loc:token [R:Intro] LoadGameContinue "@sCONTINUE THIS SAVED RUN?@w"
        draw_text_nt(_cx, _cy - 54, loc("R:Intro:LoadGameContinue", "@sCONTINUE THIS SAVED RUN?@w"))
		
        _cy += 4
		
        if pos >= GameCont.waypoints {
            if (posy == 8) snd_play(sndCrownAppear)
            if (posy >= 0) posy -= 8
        }
		else {
            draw_set_color(c_uidark)
            pos ++
        }
		
		if (is_gamepad()) {
			_point_left = true
			_point_right = true
		}
		else if (_point_left || _point_right) {
			if (_point_left && pointed_item != 1) {
				snd_play(sndHover)
				pointed_item = 1
			}
			if (_point_right && pointed_item != 2) {
				snd_play(sndHover)
				pointed_item = 2
			}
		}
		else pointed_item = -1
		
		draw_set_color(c_white)
		draw_set_valign(fa_middle)
        draw_text_nt(_left, _options_y - _point_left - 1, (_point_left ? "@w" : "@s") + _text_yes)
        draw_text_nt(_right, _options_y - _point_right - 1, (_point_right ? "@w" : "@s") + _text_no + "@w")
		
		draw_gamepad_button(gp_face1, 0, _left - font_get_string_width(_text_yes), _options_y)
		draw_gamepad_button(gp_face2, 0, _right - font_get_string_width(_text_no), _options_y)

        draw_set_color(c_white)

        draw_set_halign(fa_left)
        draw_set_valign(fa_top)

        with (GameCont) scrDrawMiscHUD()

        if (loading < 15) {
            loading ++
			
            draw_set_alpha(1 - loading / 15)
            draw_set_color(c_black)
            draw_rectangle(0, 0, view_width, view_height, 0)
            draw_set_color(c_white)
            draw_set_alpha(1)
        }
		
		var _pad_yes = gamepad_button_check_pressed(0, gp_face1),
			_pad_no = gamepad_button_check_pressed(0, gp_face2)
		
        if ((pointed_item != -1 && mouse_ui_clicked()) || _pad_yes || _pad_no) {
            // yes
			if (_point_left || _pad_yes) {
                instance_destroy(GameCont, false)
				instance_destroy(Player, false)
                room_goto(romGame)
                instance_destroy()
            }
			// yesn't
			else if (_point_right || _pad_no) {
                file_delete(savegame_file)
                game_restart()
            }
        }
    }
	catch (e) {
		/// @loc:token [R:Intro] LoadGameFailure "Failed to load saved run."
        print_exception(loc("R:Intro:LoadGameFailure", "Failed to load saved run."), e)
		event_user(0)
    }
}