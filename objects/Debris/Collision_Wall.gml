if lockstep_stop
	exit

move_bounce_solid(00)
speed /= 2

if speed < 0.01 instance_destroy()