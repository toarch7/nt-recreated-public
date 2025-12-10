/// @description Fire shots

snd_play(sndJackHammer)

with scr_projectile_create(x, y, Shank, direction) {
    var _long_arms = scr_skill_get(mut_long_arms)
	scr_projectile_spread(15)
	
	if _long_arms {
		scr_projectile_long_arms(_long_arms)
		motion_add(direction, 1)
	}
	else motion_add(direction, 4)
	
	canfix = false
}

scr_weapon_post(direction, 6, 1, -8)