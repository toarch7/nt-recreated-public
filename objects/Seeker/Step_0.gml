if instance_exists(enemy) && speed > 0 {
    target = instance_nearest(x, y, enemy)
	
    if instance_exists(target) && scrTargetIsVisible(target, 32) {
		motion_add(mcr_target_direction, 1 + boost)
    }
}

if speed > 6 + boost {
    speed = 6 + boost
}

image_angle = direction