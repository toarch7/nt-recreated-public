if lockstep_stop
	exit

motion_add(point_direction(other.x, other.y, x, y), 0.5)

if other.team != team && other.hp > 0 && size > other.size && meleedamage > 0 {
	scr_hit(other.id, meleedamage, hitid)
}