if opt_gamepad && (instance_exists(MainMenuButton) or instance_exists(PlayButton) or instance_exists(MenuOptions)) {
	draw_set_halign(fa_right)
	draw_set_valign(fa_middle)
	
	var dx = gui_w - 8,
		dy = gui_h - 40,
		str = loc("CONFIRM")
	
	draw_text_nt(dx, dy, "@s" + str)
	
	draw_gamepad_button(gp_face1, 0, dx - 9 - string_width(str), dy)
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
}

if (opt_keyboard or global.desktop) && show_crosshair && native_cursor_inst == -1 {
    draw_sprite_ext(sprCrosshair, opt_crosshair, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 1, 1, 0, opt_cursorcol, 1)
}
