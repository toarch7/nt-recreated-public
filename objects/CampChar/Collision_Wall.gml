if lockstep_stop
	exit

if race == Race.Frog {
	if (place_meeting(x + hspeed, y, Wall)) hspeed *= -1
	if (place_meeting(x, y + vspeed, Wall)) vspeed *= -1
	
	if (instance_exists(Menu) && Menu.race == Race.Frog) {
		with (instance_create(x, y, PortalClear)) {
			image_xscale *= 0.67
			image_yscale *= 0.67
		}
		with (other) scrWallBreakSound()
	}
	
	direction += orandom(10)
}
else {
	move_bounce_solid(true)
}