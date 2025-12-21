if (lockstep_stop) exit

if meleedamage > 0 && canmelee && scr_can_hit(other.id) && !(scr_skill_get(mut_gamma_guts) && hp <= 6) {
    if scr_hit(other.id, meleedamage, hitid) {
		with other {
			motion_add(point_direction(other.x, other.y, x, y), 4)
		}
		snd_play_hit(snd_mele)
	}
	canmelee = false
	alarm[11] = 30
}

if size <= 2 {
    motion_add(point_direction(other.x, other.y, x, y), 1)
}