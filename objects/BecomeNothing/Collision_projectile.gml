if lockstep_stop
	exit

if other.typ {
    instance_destroy(other.id, 1)
}