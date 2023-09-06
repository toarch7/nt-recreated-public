if lockstep_stop
	exit

move_bounce_solid(1)

with other {
    instance_create(x, y, FloorExplo)
    instance_destroy()
}