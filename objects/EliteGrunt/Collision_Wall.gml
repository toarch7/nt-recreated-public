if lockstep_stop
	exit

if (roll) {
    move_bounce_solid(true)
	
	x -= hspeed
	y -= vspeed
	
    angle += (720 - abs(angle)) * right * 0.7
}
else {
    event_inherited()
}