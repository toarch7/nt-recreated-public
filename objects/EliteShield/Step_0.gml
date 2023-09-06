if lockstep_stop
	exit

if alarm[0] > 0 {
    if instance_exists(creator) {
        creator.x = x
        creator.y = y
    }
}