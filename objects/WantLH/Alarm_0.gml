if (instance_exists(Player) && instance_exists(Floor)) {
	var _p = instance_random(Player)
	
	with (instance_furthest(_p.x, _p.y, Floor)) {
		instance_create(bbox_center_x, bbox_center_y, LilHunter)
	}
}

instance_destroy()