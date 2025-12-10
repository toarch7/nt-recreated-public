/// @description Fire shots
snd_play_gun(sndPopgun)
scrBulletShotShellFX(Shell)

with scr_projectile_create(x, y, Bullet2, direction, 16) {
	scr_projectile_spread(8)
}

scr_weapon_post(direction, 4, 2, 2)