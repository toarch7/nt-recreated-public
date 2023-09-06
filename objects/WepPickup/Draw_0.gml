if lockstep_stop
	exit

if image_index > 1 and ammo > 0 and wep_type[wep] != 0 {
    draw_sprite_ext(sprite_index, 1, x - 1, y, 1, 1, image_angle, c_white, 1)
    draw_sprite_ext(sprite_index, 1, x + 1, y, 1, 1, image_angle, c_white, 1)
    draw_sprite_ext(sprite_index, 1, x, y - 1, 1, 1, image_angle, c_white, 1)
    draw_sprite_ext(sprite_index, 1, x, y + 1, 1, 1, image_angle, c_white, 1)
}
draw_sprite_ext(sprite_index, - 1, x, y, 1, 1, image_angle, c_white, 1)