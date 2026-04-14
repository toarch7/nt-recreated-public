alarm[0] = random_range(20, 30)

target = instance_nearest(x, y, enemy)

if (random(4) > 1 || instance_exists(target)) {
	wantdir += random_range(20, 90) * choose(-1, 1)
}
else wantdir = random_angle

walk += irandom_range(5, 10)

if (instance_exists(target) && scrTargetIsVisible(target)) {
	mp_potential_step_object(target.x, target.y, 4, Wall)
	wantdir = point_direction(x, y, target.x, target.y)
}
else if (instance_exists(creator) && distance_to_point(creator.x, creator.y) > 110) {
	mp_potential_step_object(creator.x, creator.y, 4, Wall)
	wantdir = point_direction(x, y, creator.x, creator.y)
}