if lockstep_stop
	exit

with (instance_create(x, y, Tangle)) {
	creator = other.creator
	team = other.team
}
instance_create(x, y, Dust)
instance_destroy()