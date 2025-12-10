sleep(100)

var _ang = random_angle

repeat 5 {
    with scr_projectile_create(x, y, FlakBullet, _ang, random_range(12, 16)) {
        image_angle = direction
    }
	
    _ang += 72
}

repeat 6 {
    with (instance_create(x, y, Smoke)) {
		motion_add(random_angle, random(3))
	}
}

scr_screenshake(8)

snd_play_hit_big(sndSuperFlakExplode, 0.2)