if lockstep_stop
	exit

if ((current_frame % 30) < timescale) {
	var _cx = view_xview + view_width / 2,
		_cy = view_yview + view_height / 2
	
	with (projectile) {
	    if (point_distance(x, y, _cx, _cy) > 1000) instance_destroy()
	}
}

with (Wall) {
	instance_create(x, y, InvisiWall)
    instance_destroy(id, false)
}