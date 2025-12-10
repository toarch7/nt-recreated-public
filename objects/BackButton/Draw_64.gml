if lockstep_stop
	exit

var _x = 16, _y = 19 - hover

draw_sprite_ext(sprite_index, image_index, _x, _y, 1, 1, 0, c_black, 1)
draw_sprite_ext(sprite_index, image_index, _x, _y, 1, 1, 0, c_black, 1)

draw_sprite_ext(sprite_index, image_index, _x, _y, 1, 1, 0, c_white, 1)
if (!hover) {
	draw_sprite_ext(sprite_index, image_index, _x, _y, 1, 1, 0, c_black, 0.3)
}

if is_gamepad() {
	draw_gamepad_button(gp_face2, false, _x + 16, _y + 16 - hover, col)
}