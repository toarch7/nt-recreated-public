event_inherited()

scrTarget()

if (instance_exists(target)) {
    if (point_distance(x, y, target.x, target.y) < 48 && sprite_index == spr_hurt) {
		if (sprite_index != spr_walk) {
			image_index = 0
		}
		
        sprite_index = spr_walk
    }
}

if (speed > 2) speed = 2