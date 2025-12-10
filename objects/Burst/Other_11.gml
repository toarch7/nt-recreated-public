/// @description Fire shots
snd_play_gun(golden ? sndGoldMachinegun : sndMachinegun)
scrBulletShotShellFX(Shell)

with scr_projectile_create(x, y, Bullet1, direction, 16) {
	scr_projectile_spread(2)
}

scr_weapon_post(direction, 6, 3, 4)