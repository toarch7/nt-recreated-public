/// @description Attacking
if ((ammo --) <= 0) {
	motion_add(random_angle, 1)
	if (instance_exists(target)) {
		motion_add(point_direction(x, y, target.x, target.y), 4)
	}
	scrWalk(direction, 1, 10, 30)
	ammo = 0
	exit
}

switch (wep) {
	case wep_golden_revolver:
		scrBulletShotShellFX(Shell)
		if (!ammo) {
			gunangle -= 2
			repeat (2) {
				scr_projectile_create(x, y, YVBullet, gunangle + orandom(3), 16)
				gunangle += 5
			}
			snd_play_gun_big(sndPopPop)
			if (!intro) alarm[5] = 10
		}
		else {
			if (instance_exists(target)) gunangle = mcr_target_direction
			scr_projectile_create(x, y, YVBullet, gunangle, 16)
		}
		scr_screenshake(5)
		snd_play_gun(sndGoldPistol)
		alarm[2] = 5
		break
	case wep_golden_shotgun:
		if (instance_exists(target)) gunangle = mcr_target_direction
		repeat (18) {
			var _direction = gunangle + orandom(30),
				_speed = random_range(12, 18)
			
			with (scr_projectile_create(x, y, EnemyBullet3, _direction, _speed)) {
				spr_fade = sprBullet2Disappear
				sprite_index = sprBullet2
			}
		}
		scr_screenshake(10)
		snd_play_gun_big(sndPopPop)
		snd_play_gun(sndGoldShotgun)
		break
	case wep_golden_bazooka:
		for(var i = -2; i <= 2; ++i) {
			if (i == 0) continue
			with (scr_projectile_create(x, y, Rocket, gunangle + i * 3 + orandom(3), 3)) {
				sprite_index = sprGoldRocket
			}
		}
		scr_screenshake(10)
		snd_play_gun_big(sndPopPopUpg)
		snd_play_gun(sndGoldRocket)
		break
	case wep_minigun:
		scr_projectile_create(x, y, YVBullet, gunangle + orandom(5), 16)
		gunangle += minigun_side * random_range(0.8, 1)
		scr_screenshake(3)
		snd_play_gun(sndMinigun)
		alarm[2] = 1
		break
}