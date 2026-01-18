/// @description Unlock, version, pause, etc

version_text_drawn = false

if (!instance_exists(Player) or instance_exists(GenCont)) && room == romGame {
	var _menu_credits = instance_exists(Credits) && !instance_exists(GameCont)
	
    if !instance_exists(MenuOptions) && !instance_exists(DailyList) && !instance_exists(Vlambeer)
	&& !instance_exists(StatChar) && !instance_exists(CharSelect) && !instance_exists(LevCont)
	&& !instance_exists(UnlockScreen) && !bossintro && !_menu_credits {
		var offx = is_mobile ? 4 : 0
		
		if instance_exists(GameCont) && UberCont.opt_showtimer {
			offx = font_get_string_width(GameCont.timer_string) + 3
		}
		
		draw_set_font(fntSmall)
		draw_set_halign(fa_right)
		draw_set_valign(fa_bottom)
		
	    draw_set_color(#606060)
        draw_text_nt(view_width - offx, view_height - 6, "v" + string(GAME_BUILD))
	    
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		draw_reset_font()
		
		version_text_drawn = true
    }
}
else if MultiplayerConfig or (global.custom_seed or opt_practice) {
    draw_set_color(c_white)
    draw_set_font(fntSmall)

    if !instance_exists(MenuOptions) && !instance_exists(DailyList) && !instance_exists(CharSelect)
	&& !instance_exists(LevCont) && !instance_exists(UnlockScreen) && !bossintro && room == romGame {
        draw_set_halign(fa_left)
        draw_text_nt(1, view_height - 4, string(global.seed))
    }

    draw_set_valign(fa_top)
    draw_set_halign(fa_left)
    draw_reset_font()
}

if instance_exists(Player) && opt_pausebutton && !instance_exists(Credits) && !want_pause {
	var _pause_x = view_width - 24, _pause_y = 16
	
    draw_sprite_ext(sprMobilePauseButton, 0, _pause_x, _pause_y, 0.75, 0.75, 0, c_white, 0.5)

    for (var _touch = 0; _touch <= 4; _touch ++) {
        if device_mouse_check_button_released(_touch, mb_left) {
			var _mx = device_mouse_x_to_gui(_touch),
				_my = device_mouse_y_to_gui(_touch)
			
            if point_in_circle(_mx, _my, _pause_x, _pause_y, 24) {
                KeyCont.press_paus[global.index] = true
			}
        }
    }
}

if (draw_unlock) {
	if (!(scrGameIsGenerationScreen() || instance_exists(AchievementSplash))) {
		var _unlock_screen = false
		
		with (UnlockScreen) {
			if (visible) _unlock_screen = true
		}
		
		if (!_unlock_screen) {
			splatindex = approach(splatindex, 3, timescale)
			
			draw_sprite(sprUnlockPopupSplat, splatindex, view_width, view_height)
			
			draw_align(fa_right, fa_top)
			var _height = font_get_string_height(string_hash_to_newline(unlock_text))
			if (splatindex >= 3) draw_text_nt(view_width - 2, view_height - _height - 5, unlock_text)
			draw_align()
		}
	}
	else alarm[1] = 90
}

if saving {
    if !instance_exists(Vlambeer) && !instance_exists(GenCont) {
        draw_sprite_ext(sprSaving, saving_index, view_width - 15, view_height - 15, 1, 1, 0, c_black, 1)
        draw_sprite_ext(sprSaving, saving_index, view_width - 16, view_height - 15, 1, 1, 0, c_black, 1)
        draw_sprite_ext(sprSaving, saving_index, view_width - 16, view_height - 16, 1, 1, 0, c_white, 1)

        saving_index += 0.5

        if saving_index >= sprite_get_number(sprSaving) {
            saving_index = 0
        }
    }
	else saving = 0

    saving --
}

if paused && !want_pause && !instance_exists(CoopController) {
	if !want_menu && !want_restart && !instance_exists(MenuOptions) {
	    instance_activate_object(Player)
		
		with (TopCont) {
			scrDrawPlayerHUD(scrPlayerFindLocal())
		}
		
	    instance_deactivate_object(Player)
	}
	
	// run saving tip
	if (!instance_exists(CoopController)) with (PauseButton) {
		//if (image_index == 5 && !save_get_value("etc", "saving_tip", 0)) {
		if (true) {
			draw_set_color(c_white)
			
			var _icon_x = gui_w div 2,
				_icon_y = gui_h - LETTERBOX_SIZE - 30
			
			if (appear <= 2) {
				var _dx = _icon_x - sprite_get_width(sprContinuedRunIcon) * 0.5,
					_dy = _icon_y + max(0, appear - 1) + 1
				
				gpu_set_fog(true, c_white, 0, 0)
				draw_sprite(sprContinuedRunIcon, 0, _dx - 1, _dy - 1)
				draw_sprite(sprContinuedRunIcon, 0, _dx + 1, _dy + 1)
				draw_sprite(sprContinuedRunIcon, 0, _dx - 1, _dy + 1)
				draw_sprite(sprContinuedRunIcon, 0, _dx + 1, _dy - 1)
				gpu_set_fog(0, 0, 0, 0)
				
				draw_sprite(sprContinuedRunIcon, 0, _dx, _dy)
			}
			
			if (appear <= 1) {
				/// @loc:token [PauseMenu] RunSavingTip "YOU CAN SAVE AND CONTINUE THIS RUN LATER#IF YOU EXIT WITHOUT QUITTING TO MAIN MENU"
				scrDrawTooltip(_icon_x, _icon_y,
					loc("PauseMenu:RunSavingTip", "YOU CAN SAVE AND CONTINUE THIS RUN LATER#IF YOU EXIT WITHOUT QUITTING TO MAIN MENU"), appear, true)
			}
		}
	}
}

if MultiplayerConfig && false {
	draw_set_font(fntSmall)
	draw_set_halign(fa_left)
	
	draw_set_color(c_gray)
	
	draw_text_nt(8, 72, struct_trace(my_player))
	//draw_text_nt(24, 96, string(global.index) + "\n" + global.inputs_current)
	
	draw_set_color(c_white)
	draw_reset_font()
}