if disclaimer {
	draw_set_halign(fa_center)
    draw_set_valign(fa_middle)
	
	var str = (get_timer() / 33333) % 60 > 30 ? "@r!!!" : "@s!!!"
	
	draw_reset_font()
    
	var _disclaimer = loc("@w###THIS IS AN UNOFFICIAL FAN-MADE RECREATION,#NOT AFFILIATED WITH @yVLAMBEER@w.##IT IS DISTRIBUTED FREELY ON ITCH.IO#"
		+ "AND IS OPEN SOURCE ON GITHUB.##IF YOU PAID OR SEE ADS, IT'S RECOMMENDED TO#UNINSTALL THE APPLICATION FOR YOUR OWN SAFETY.")
	
	draw_text_nt(view_width / 2, view_height / 2,
		str + " " + loc("R:Intro:ProjectDisclaimerTitle", "DISCLAIMER") + " " + str
				  + loc("R:Intro:ProjectDisclaimerText", _disclaimer))
	
	disclaimer ++
	
	if disclaimer >= 90 {
		str = loc("R:Intro:DisclaimerContinue", "CLICK TO CONTINUE")
		
		if disclaimer == 90 {
			snd_play(sndHover)
			str = "@w" + str
		}
		else {
			str = "@s" + str
		}
		
		draw_text_nt(view_width / 2, view_height - 48 + (disclaimer == 90) * 2, str)
		
		if mouse_ui_clicked() || keyboard_anykey() || scrGamepadAnykey() != -1 {
			save_set_value("etc", "disclaimer", true)
			event_perform(ev_alarm, 0)
		}
	}
	
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
			
			_text_yes = loc("R:Intro:LoadGameYes", "YES"),
			_text_no = loc("R:Intro:LoadGameNo", "NO")
		
        scrDrawRoadmap(_cx, _cy, pos)
        with (TopCont) scrDrawPlayerHUD(scrPlayerFindLocal())
		
        draw_set_halign(fa_center)
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
        print_exception(loc("R:Intro:LoadGameFailure", "Failed to load saved run."), e)
		event_user(0)
    }
}