if lockstep_stop
	exit

if (sprite_index == sprRavenLift) {
	z -= 3
}
else if (sprite_index == sprRavenLand) {
	z += 3
	emergencylanding += timescale
	if (emergencylanding >= 10) {
		event_user(0)
	}
}
else if (sprite_index != sprRavenFly) {
	sprite_index = sprRavenFly
}

if (sprite_index == sprRavenFly) {
	var _dir = point_direction(x, y, targetx, targety)
    x += lengthdir_x(6 * timescale, _dir)
    y += lengthdir_y(6 * timescale, _dir)
	if (alarm[0] <= 0) event_perform(ev_alarm, 0)
	emergencylanding += 0.05 * timescale
	if (emergencylanding >= 20) event_user(0)
    speed = 0
}

lifespan = 300