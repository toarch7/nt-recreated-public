var _num = 8 + scrCrownCheck(crwn_death)

repeat _num {
	var _dir = random_angle, _spd = random_range(3, 5)
	
    with scr_projectile_create(
		x + orandom(2), y + orandom(2),
		SmallGrenade, _dir, _spd
	) {
        motion_add(other.direction, 2)
        friction = 0.4
    }
}

snd_play_hit(sndClusterOpen, 0.2)

repeat (8) {
	with (instance_create(x, y, Smoke)) motion_add(random_angle, random_range(2, 3))
}