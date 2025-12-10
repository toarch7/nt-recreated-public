/// @description Fire shots
snd_play(sndSlugger)

with scr_projectile_create(x, y, Slug, direction, 18) {
	scr_projectile_spread(4)
}

scr_weapon_post(direction, 8, 6, 8)