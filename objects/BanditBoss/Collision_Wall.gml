if lockstep_stop
	exit

if charge > 0 || !intro {
    scrWallDestroy(other.id)
}
else {
	move_bounce_solid(true)
}