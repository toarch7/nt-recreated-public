if lockstep_stop
	exit

drawx = (is_touch() || instance_exists(CoopController)) ? 24 : 16
drawy = 20

x = view_xview + drawx
y = view_yview + drawy

depth = -1000

if (!visible) exit

var press = mouse_ui_clicked(),
	backspace = scr_keyboard_check_pressed(vk_backspace)

with MenuOptions {
	if text_input_element != undefined
		backspace = false
}

if ((gamepad_button_check_pressed(0, gp_face2) || scr_keyboard_check_pressed(vk_escape) || backspace)
	|| (is_keyboard() && mouse_check_button_pressed(mb_right) && !(instance_exists(CoopController) && instance_exists(Menu)))
) {
	if (!instance_exists_var(MenuOptions, "await_input", true)) event_user(0)
}

if hover && !is_touch() {
	image_speed = 0.4
}
else {
	image_index = 0
	image_speed = 0
}

if mouse_ui_hovered(id, false) {
	if !is_gamepad() {
		if !hover {
			snd_play(sndHover)
			hover = 1
		}
	}
	
	if press {
		event_user(0)
	}
}
else if !is_gamepad() && hover {
	hover = 0
}