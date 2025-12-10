if scr_can_hit(other.id) && scr_hit(other.id, damage, hitid) {
	with (other) motion_add_m(point_direction(other.x, other.y, x, y), 2, 16)
}