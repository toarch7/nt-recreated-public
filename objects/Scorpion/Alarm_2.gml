if ammo > 0 {
    ammo --
    alarm[2] = 2
	
    snd_play(sndScorpionFire)
    
	with scr_projectile_create(x, y, EnemyBullet2, gunangle, random_range(3, 4)) {
        scr_projectile_spread(orandom(20))
    }
    
	sprite_index = spr_fire
	image_index = 0
}
else {
    sprite_index = spr_idle
    alarm[1] = 40 + random(10)
}