if lockstep_stop
	exit

with other {
    instance_destroy()
    instance_create(x, y, FloorExplo)
}