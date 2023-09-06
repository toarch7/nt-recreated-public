if lockstep_stop
	exit

if instance_exists(creator) {
    x = creator.x
    y = creator.y

    depth = creator.depth - 1
}