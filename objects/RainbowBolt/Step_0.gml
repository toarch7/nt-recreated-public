if lockstep_stop
	exit

if instance_exists(enemy) and instance_exists(Player) {
    if speed > 0 and skill_get(21) {
        dir = instance_nearest(x, y, enemy)
        if point_distance(x, y, dir.x, dir.y) < 32 {
            x = dir.x - hspeed
            y = dir.y - vspeed
        }
    }
}

if speed > 0 {
    col += 12
    if col > 255 col -= 255
}

if speed > 0 {
    wall = collision_line(x, y, x - hspeed, y - vspeed, Wall, 1, 1)

    if wall {
        x -= hspeed * 1.2
        y -= vspeed * 1.2

        speed = 1
        event_perform(ev_collision, Wall)
    }
}