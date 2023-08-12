draw_sprite_ext(sprite_index, image_index, 3, 3 - hover, 1, 1, 0, c_black, 1)
draw_sprite_ext(sprite_index, image_index, 3, 2 - hover, 1, 1, 0, c_black, 1)

var col = hover ? c_white : c_uigray

draw_sprite_ext(sprite_index, image_index, 2, 2 - hover, 1, 1, 0, col, 1)

if is_gamepad()
	draw_gamepad_button(gp_face2, false, 28, 28 - hover, col)