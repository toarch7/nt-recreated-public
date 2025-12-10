event_inherited()

repeat (40) scr_projectile_create(x, y, ToxicGas)

snd_play(sndToxicBarrelGas)

var _dir = random_angle

repeat(20) {
    _dir += 360 / 20
    
	scr_projectile_create(x, y, EnemyBullet2, _dir, 4)
    
	with instance_create(x, y, AcidStreak) {
        motion_add(_dir, 8)
        image_angle = direction
    }
}

scr_screenshake(20)

repeat (5) {
    with (instance_create(x, y, ExploderExplo)) {
		motion_add(random_angle, random(2) + 2)
	}
}

snd_play(sndFrogExplode)

instance_create(x, y, PortalClear)