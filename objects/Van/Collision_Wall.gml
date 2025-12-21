if lockstep_stop
	exit

scrWallDestroy(other.id)

if ((-- wallbreak) <= 0) drive = false