/// @description Fire shots

repeat (2) {
	with scr_projectile_create(x, y, Flame, direction, random_range(6, 8)) {
		move_contact_solid(direction, 14)
		image_angle = 0
	}
}

scr_weapon_post(direction, 3, 1, 2)
