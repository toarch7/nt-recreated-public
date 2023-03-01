if instance_exists(Player) {
	var p = instance_nearest(x, y, Player)
	
    if point_distance(x, y, p.x, p.y) > 96 {
        if speed > 3
			speed = 3
		
		mp_potential_step(targetx, targety, 1, false)
    }
	else if speed > 2 {
		speed = 2
	}
}
else if speed > 2 {
	speed = 2
}

friction = 0.2

if walk > 0 {
    motion_add(direction, 1)
    walk --
}

if speed > 0 {
	sprite_index = spr_walk
}
else sprite_index = spr_idle