if (roll) {
	move_bounce_solid(true)
	x -= hspeed
	y -= vspeed
}
else {
	event_inherited()
}