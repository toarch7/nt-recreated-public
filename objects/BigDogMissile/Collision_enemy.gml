if lockstep_stop
	exit

if meleedamage > 0 && canmelee && scr_can_hit(other.id) {
    with (other) if (scr_hit_self(other.meleedamage)) {
		motion_add(point_direction(other.x, other.y, x, y), 4)
	}
	
	hp -= 3
    alarm[1] = 30
}