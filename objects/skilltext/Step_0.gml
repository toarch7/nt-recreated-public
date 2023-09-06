if lockstep_stop
	exit

if disappear {
    disappear--

    if disappear <= 0 instance_destroy()
}