if lockstep_stop
	exit

if instance_exists(GenCont) {
    with other {
        instance_destroy()
    }
}