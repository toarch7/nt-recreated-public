if ammo > 0 {
    snd_play(ammo == 16 ? sndSnowTankPreShoot : sndSnowTankShoot)
	
	for(var i = -1; i <= 1; ++i) {
		if (i != 0) {
			var _dir = gunangle + sin(wave) * 20 * i
		    scr_projectile_create(x, y, EnemyBullet4, _dir, 12)
		}
	}
	
    alarm[2] = 2
    wave += 0.1
    ammo --
}
else {
    snd_play(sndSnowTankCooldown)
    rest = true
    alarm[1] = 4 / 0.4
    sprite_index = spr_idle
    image_index = 0
}