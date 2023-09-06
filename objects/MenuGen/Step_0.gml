if lockstep_stop
	exit

if instance_exists(FloorMaker) {
	with CampChar {
		x = xprevious
		y = yprevious
	}
	
	alarm[1] = 2
}