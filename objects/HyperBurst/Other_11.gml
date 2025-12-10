/// @description Fire shots

snd_play_gun(sndHyperRifle, 0.1)
scrBulletShotShellFX(Shell)

with scr_projectile_create(x, y, Bullet1, direction, 20) {
	scr_projectile_spread(2)
}

scr_weapon_post(direction, 6, 3, 4)