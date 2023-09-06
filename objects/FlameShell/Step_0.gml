if lockstep_stop
	exit

image_angle = direction

if speed < 5 { //and sprite_index != sprBullet2Disappear {
    instance_destroy()
    /*
	sprite_index = sprBullet2Disappear
	image_index = 0
	image_speed = 0.4
	instance_create(x, y, Smoke)

	if sprite_index = sprBullet2Disappear {
	    with instance_create(x, y, Flame) {
			motion_add(other.direction, other.speed)
			team = other.team
		}
	
	    instance_destroy()
	}*/
}