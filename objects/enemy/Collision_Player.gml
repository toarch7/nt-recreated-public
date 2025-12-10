if (lockstep_stop) exit

if meleedamage > 0 && canmelee && team != other.team {
    if !(other.inframes || (hp <= 6 && scr_skill_get(mut_gamma_guts))) {
		if scr_hit(other.id, meleedamage, hit_id) {
		    with other {
				motion_add(point_direction(other.x, other.y, x, y), 4)
		    }
		}
		
	    canmelee = false
	    alarm[11] = 30
	}
}

if size <= 2 {
    motion_add(point_direction(other.x, other.y, x, y), 1)
}