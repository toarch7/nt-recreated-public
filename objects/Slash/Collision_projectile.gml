with other {
	if (!instance_is(self, Grenade) && team == other.team) || typ == 0 break
	
	if other.shank || typ == 2 {
		instance_destroy()
		break
    }
	
	if instance_is(self, Grenade) {
		motion_add(other.direction, 12)
		
		friction = 0.1
		alarm[1] = 6
		speed = 12
		
		scr_screenshake(3)
		scrBulletHitFX(sprDeflect)
	}
	else if typ == 1 {
		team = other.team
		direction = other.direction
		image_angle = other.image_angle
		scrBulletHitFX(sprDeflect)
	}
}