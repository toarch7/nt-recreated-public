/// @description Fire shots

repeat (2) {
	with scr_projectile_create(x, y, Flame, direction, random_range(10, 13)) {
		move_contact_solid(direction, 14)
		image_angle = 0
	}
}

for(var i = -1; i <= 1; ++i) {
	if (i != 0) {
		with scr_projectile_create(x, y, Flame, direction, random_range(9, 12)) {
			move_contact_solid(direction, 14)
			scr_projectile_spread(8)
			direction -= 8 * i
			image_angle = 0
		}
	}
}

scr_weapon_post(direction, 3, 1, 4)
