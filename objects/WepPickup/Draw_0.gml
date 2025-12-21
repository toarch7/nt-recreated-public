if lockstep_stop
	exit

if image_index > 1 && ammo && scr_weapon_get_type(wep) != Ammo.None {
    draw_sprite_ext(sprite_index, 1, x - 1, y, 1, 1, image_angle, c_white, 1)
    draw_sprite_ext(sprite_index, 1, x + 1, y, 1, 1, image_angle, c_white, 1)
    draw_sprite_ext(sprite_index, 1, x, y - 1, 1, 1, image_angle, c_white, 1)
    draw_sprite_ext(sprite_index, 1, x, y + 1, 1, 1, image_angle, c_white, 1)
}

draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, image_angle, c_white, 1)