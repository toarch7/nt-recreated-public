if lockstep_stop
	exit

if team != other.team {
    if other.typ = 2 or other.typ = 1 {
        with other
        instance_destroy()
    }

}