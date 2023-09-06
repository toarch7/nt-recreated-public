if lockstep_stop
	exit

if instance_exists(enemy) and instance_exists(Player) {
    if speed > 0 and skill_get(21) {
        dir = instance_nearest(x, y, enemy)
        if point_distance(x, y, dir.x, dir.y) < 24 {
            x = dir.x - hspeed
            y = dir.y - vspeed
        }
        /*x += lengthdir_x(8,point_direction(x,y,mouse_x,mouse_y))
y += lengthdir_y(8,point_direction(x,y,mouse_x,mouse_y))*/
    }
}

/* */
/*  */