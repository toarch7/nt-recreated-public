if lockstep_stop
	exit

if instance_exists(enemy) && instance_exists(Player) {
    if speed > 0 && skill_get(21) {
        dir = instance_nearest(x, y, enemy)

        if dir.object_index != FiredMaggot {
            if point_distance(x, y, dir.x, dir.y) < 16 {
                x = dir.x - hspeed
                y = dir.y - vspeed
            }
        }
    }
}