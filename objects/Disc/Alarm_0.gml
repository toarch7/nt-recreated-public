if instance_exists(creator) {
	if point_distance(x, y, creator.x, creator.y) > 24 {
		team = -1
	}
	else alarm[0] = 1
}
else team = -1