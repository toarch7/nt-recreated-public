/// @param Fire shots
snd_play_gun(sndGrenadeRifle)

with scr_projectile_create(x, y, SmallGrenade, direction, 13 + random(2)) {
	scr_projectile_spread(4)
}

scr_weapon_post(direction, 5, 1, 5)