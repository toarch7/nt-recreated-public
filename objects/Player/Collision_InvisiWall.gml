if !roll && race != Race.Frog {
	move_contact_solid(direction, clamp(speed, 1, maxspeed))
	
	if place_meeting(x + hspeed, y, InvisiWall) {
		hspeed /= 2
		
		if place_meeting(x + hspeed, y, InvisiWall) {
			hspeed = 0
		}
	}
	
	if place_meeting(x, y + vspeed, InvisiWall) {
		vspeed /= 2
		
		if place_meeting(x, y + vspeed, InvisiWall) {
			vspeed = 0
		}
	}
	
	x += hspeed
	y += vspeed
}
else {
	move_bounce_solid(true)
	
	if (race != Race.Frog) {
		angle += ((720 - abs(angle)) * right * 0.7)
	}
	
	x += hspeed
	y += vspeed
}