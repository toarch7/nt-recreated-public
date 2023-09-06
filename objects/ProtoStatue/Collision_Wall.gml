if lockstep_stop
	exit

with other {
    instance_create(x, y, FloorExplo)
    instance_destroy()
}