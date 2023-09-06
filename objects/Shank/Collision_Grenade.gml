if lockstep_stop
	exit

with other {
    instance_destroy()
    sleep(40)
    BackCont.shake += 3
}