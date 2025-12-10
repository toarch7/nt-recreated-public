/// @description Fire shots

snd_play_gun(sndSplinterGun, 0.1)

repeat (2) {
	with scr_projectile_create(x, y, Splinter, direction, random_range(16, 24)) {
		scr_projectile_spread(16)
	}
}

scr_weapon_post(direction, 7, 3, 9)
