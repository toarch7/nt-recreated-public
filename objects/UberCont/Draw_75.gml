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


if opt_keyboard or global.desktop {
    draw_sprite_ext(sprCrosshair, opt_crosshair, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 1, 1, 0, opt_cursorcol, 1)
}

/*

tests

var _y = 16,
	pos = 0

var mx = device_mouse_x_to_gui(0),
	my = device_mouse_y_to_gui(0)

for(var b = 0; b <= 1; b ++) {
	for(var i = gp_face1; i <= gp_padr; i ++) {
		pos ++
		
		draw_gamepad_button(i, b, mx + 16 * (pos % 9), my + _y)
		
		if pos > 0 && pos % 9 == 0
			_y += 16
	}
	
	_y += 16
	pos = 0
}

draw_gamepad_button(gp_face1, 0, mx, my - 32)
draw_gamepad_button(gp_padd, 0, mx + 16, my - 32)
draw_gamepad_button(gp_shoulderlb, 0, mx - 16, my - 32)
draw_gamepad_button(gp_shoulderr, 0, mx + 32, my - 32)
*/