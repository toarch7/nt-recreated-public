if lockstep_stop
	exit

x = view_xview + 2
y = view_yview + 2

depth = -1000

if !visible
	exit

var press = mouse_ui_clicked(),
	backspace = scr_keyboard_check_pressed(vk_backspace)

with MenuOptions {
	if text_input_element != undefined
		backspace = false
}

if (gamepad_button_check_pressed(0, gp_face2) or scr_keyboard_check_pressed(vk_escape) or backspace)
or (is_desktop && mouse_check_button_pressed(mb_right) && !(instance_exists(CoopController) && instance_exists(Menu)))
{
	if !instance_exists_var(MenuOptions, "await_input", true)
		event_user(0)
}

if hover {
	image_speed = 0.4
}
else {
	image_index = 0
	image_speed = 0
}

if mouse_hover {
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