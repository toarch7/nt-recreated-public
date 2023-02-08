instance_create(x, y, DiscTrail)
dist += 1

if instance_exists(Player) and instance_exists(enemy) {
    dir = instance_nearest(x, y, enemy)
	
    if speed > 0 and skill_get(21) and point_distance(x, y, dir.x, dir.y) < 32 {
        x += lengthdir_x(1, point_direction(x, y, dir.x, dir.y))
        y += lengthdir_y(1, point_direction(x, y, dir.x, dir.y))
    }
}

if alarm[0] == -1 && team != -1 {
	alarm[0] = 4
}