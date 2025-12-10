/// @description Fire shots
snd_play_gun(sndHeavyMachinegun)

scrBulletShotShellFX(HeavyShell)

with scr_projectile_create(x, y, HeavyBullet, direction, 16) {
	scr_projectile_spread(1)
}

scr_weapon_post(direction, 7, 3, 6)