/// @description Unlock, version, pause, etc

if draw_unlock {
    if instance_exists(GenCont) or instance_exists(LevCont) or instance_exists(AchievementSplash) {
        alarm[1] = 90
        exit
    }

    if splat_index != 3 splat_index++

    draw_sprite(sprUnlockPopupSplat, splat_index, view_width, view_height)

    draw_set_halign(fa_right)
    draw_set_valign(fa_top)

    if splat_index == 3 {
        draw_text_nt(view_width - 2, view_height - 24, unlock_text)
    }

    draw_set_halign(fa_left)
}

if !instance_exists(Player) && room == romGame {
    draw_set_valign(fa_center)
    draw_set_color(c_dkgray)
    draw_set_font(fntSmall)

    if !instance_exists(MenuOptions) && !instance_exists(DailyList) && !instance_exists(Vlambeer)
	&& !instance_exists(StatChar) && !instance_exists(CharSelect) && !instance_exists(LevCont)
	&& !instance_exists(UnlockScreen) && !bossintro && !(instance_exists(Credits) && !instance_exists(GameCont)) {
        draw_set_halign(fa_right)
        draw_text_shadow(view_width - 4, view_height - 4, "v" + string(GAME_BUILD))
    }

    draw_set_valign(fa_top)
    draw_set_halign(fa_left)
    draw_set_font(fntM1)
}
else if global.custom_seed {
    draw_set_valign(fa_center)
    draw_set_color(c_ltgray)
    draw_set_font(fntSmall)

    if !instance_exists(MenuOptions) && !instance_exists(DailyList) && !instance_exists(CharSelect) && !instance_exists(LevCont) && !instance_exists(UnlockScreen) && !bossintro {
        draw_set_halign(fa_left)
        draw_text_shadow(4, view_height - string_height("Aa"), "[seed " + string(global.seed) + "]")
    }

    draw_set_valign(fa_top)
    draw_set_halign(fa_left)
    draw_set_font(fntM1)
}

if instance_exists(Player) && opt_pausebutton && !instance_exists(Credits) {
    draw_sprite_ext(sprPauseButton, 0, view_width - 18, 18, 0.7, 0.7, 0, c_white, 0.5)

    for (var touch = 0; touch <= 4; touch ++) {
        if device_mouse_check_button_released(touch, mb_left) {
            if point_in_circle(device_mouse_x_to_gui(touch), device_mouse_y_to_gui(touch), view_width - 18, 18, 16) {
                KeyCont.press_paus[global.index] = 1
            }
        }
    }
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

if paused && !want_pause {
	if !want_menu && !want_restart && !instance_exists(MenuOptions) {
	    instance_activate_object(Player)
		
	    with TopCont
			scrDrawHUD()
		
	    instance_deactivate_object(Player)
	}
}

/*

draw_set_font(fntSmall)

draw_set_halign(fa_left)

draw_set_color(c_gray)

draw_text_shadow(-64, 10, string_delete(string_replace_all(json_stringify(playerinstances), ", ", ",\n"), 1, 2))

draw_set_color(c_white)

draw_set_font(fntM1)