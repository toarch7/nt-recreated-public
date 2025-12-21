if (!disappear && scr_can_hit(other.id, (other.object_index == Player))) {
	scr_hit(other.id, 5, hitid)
	
	with (other) {
		motion_add(270, 12)
		if (speed > 16) speed = 16
	}
}