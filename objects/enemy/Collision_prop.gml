if lockstep_stop
	exit

motion_add(point_direction(other.x, other.y, x, y), 0.5)

if (busycollisions) {
	var _wall = instance_nearest(x + hspeed, y + vspeed, Wall)
	
	if (instance_exists(_wall) && place_meeting(x + hspeed, y + vspeed, Wall)) {
		motion_add(point_direction(_wall.x, _wall.y, x, y), 0.5)
		if (!place_meeting(x + hspeed, y + vspeed, Wall)) {
			x += hspeed
			y += vspeed
		}
	}
	
	if (speed > 16) speed = 16
}

if (size > other.size && meleedamage > 0 && scr_can_hit(other.id)) {
	scr_hit(other.id, meleedamage, hitid)
}