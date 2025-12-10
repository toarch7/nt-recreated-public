event_inherited()
image_speed = 0.4

repeat(10) {
    with instance_create(x, y, Smoke)
    motion_add(random_angle, 1 + random(2))
}

var _angle = random_angle

repeat(20) {
    with instance_create(x, y, Dust) {
		motion_add(_angle, 6)
	}
	
    _angle += 360 / 20
}

scr_screenshake(7)

team = team_popo
hitid = HitId.PopoExplosion
damage = 8