/// @description Go off cooldown
if (scr_weapon_get_type(wep) == Ammo.Shells) {
	with (scrBulletShotShellFX(Shell, 30)) sprite_index = sprShotShell
}

can_shoot = true