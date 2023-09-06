if lockstep_stop
	exit

move_bounce_solid(00)

if direction > 90 && direction <= 270 {
    right = -1
} else right = 1