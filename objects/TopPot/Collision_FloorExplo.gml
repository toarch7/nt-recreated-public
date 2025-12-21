if lockstep_stop
	exit

with Wall {
    if (place_meeting(x, y, other)) scrWallDestroy(id)
}

instance_destroy()