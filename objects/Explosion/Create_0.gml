event_inherited()

damage = 5
image_speed = 0.4
hitid = HitId.Explosion

x += orandom(2)
y += orandom(2)

var _count = (instance_is(self, SmallExplosion) ? 8 : 20)

repeat (_count div 2) {
    with instance_create(x, y, Smoke)
    motion_add(random_angle, 2 + random(3))
}

var _angle = random_angle

repeat (_count) {
    with instance_create(x, y, Dust) {
		motion_add(_angle, 6)
	}
	
	_angle += 360 / _count
}

if (instance_exists(Player) && scrCrownCheck(Crown.Death)
	&& (object_index == Explosion || object_index == GreenExplosion)
) {
    alarm[1] = 1
}

scr_screenshake(7)

if position_meeting(x, y, Floor) && object_index != SmallExplosion instance_create(x, y, Scorch)