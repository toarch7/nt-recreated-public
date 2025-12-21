if (hammerhead && hammering > 6) {
	hammering = 12
	hammerhead --
	
	snd_play_hit(hammerhead ? sndHammerHeadProc : sndHammerHeadEnd, 0.1)
	
	instance_create(other.x + 8, other.y + 8, Hammerhead)
	
	scrWallDestroy(other.id)
	
	exit
}

if (hammerhead) hammering += timescale * 2

if !roll && race != Race.Frog {
	move_contact_solid(direction, clamp(speed, 1, maxspeed))
	
	if place_meeting(x + hspeed, y, Wall) {
		hspeed /= 2
		
		if place_meeting(x + hspeed, y, Wall) {
			hspeed = 0
		}
	}
	
	if place_meeting(x, y + vspeed, Wall) {
		vspeed /= 2
		
		if place_meeting(x, y + vspeed, Wall) {
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