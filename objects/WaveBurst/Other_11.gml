/// @description Fire shots

snd_play(sndShotgun)

var _wave = sin(ammo / 2) * 16

for(var i = -1; i <= 1; ++i) {
	if (i != 0) {
		with scr_projectile_create(x, y, Bullet2, direction, 16) {
			scr_projectile_shift(_wave * i)
		    scr_projectile_spread(2)
		}
	}
}

scr_weapon_post(direction, 2, 2, 7)
