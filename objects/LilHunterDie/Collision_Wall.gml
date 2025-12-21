if lockstep_stop
	exit

move_bounce_solid(true)
bounces += 1
if ((bounces > 3) && (speed > 0)) {
    alarm[2] = 15
    speed = 0
} else instance_create(x, y, PortalClear)