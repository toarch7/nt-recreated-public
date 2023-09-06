if lockstep_stop
	exit

if instance_number(enemy) < 10 {
    instance_destroy()
    exit
}

if instance_exists(Player) {
	var p = instance_nearest(x, y, Player)
	
    if point_distance(x, y, p.x, p.y) < 120 && random(90) < 1 {
        with BecomeTurret {
            if !collision_line(x, y, p.x, p.y, Wall, 1, 0) {
                instance_create(x, y, Turret)
                instance_destroy()
            }
        }
    }
}