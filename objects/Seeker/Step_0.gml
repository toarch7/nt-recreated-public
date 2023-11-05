if lockstep_stop
	exit

if instance_exists(enemy) && speed > 0 {
    target = instance_nearest(x, y, enemy)

    if target && distance_to_object(target) <= 32 {
		if !collision_line(x, y, target.x, target.y, Wall, 1, 1)
			motion_add(target_direction, 1 + boost)
    }
}

if speed > 6 + boost {
    speed = 6 + boost
}

image_angle = direction