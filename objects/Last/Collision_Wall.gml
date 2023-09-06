if lockstep_stop
	exit

if (charge > 0) {
    with(other) {
        instance_destroy()
        instance_create(x, y, FloorExplo)
    }
} else move_bounce_solid(00)