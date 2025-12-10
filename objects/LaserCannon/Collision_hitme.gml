if lockstep_stop
	exit

if scr_can_hit(other.id) && scr_hit(other.id, damage, hitid) {
	scr_screenshake(2)
	sleep(5)
}