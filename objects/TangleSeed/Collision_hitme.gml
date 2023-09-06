if lockstep_stop
	exit

if other.team != team {
    instance_destroy()
    instance_create(x, y, Tangle)
    instance_create(x, y, Dust)
}