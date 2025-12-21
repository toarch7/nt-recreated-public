if lockstep_stop
	exit

move_bounce_solid(true)
speed /= 2

if speed < 0.01 instance_destroy()