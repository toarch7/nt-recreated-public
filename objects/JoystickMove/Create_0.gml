x = (view_width - global.view_width_max) / 2 + 64
y = view_height - 64

event_inherited()

rad = 32

dis = 0
dir = 0

clicked = 0

button_name = "MOVE JOYSTICK"

if UberCont.opt_hiddensticks && !instance_exists(MenuOptions) {
	image_alpha = 0
}