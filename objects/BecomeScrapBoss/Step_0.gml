scrTarget()

if target {
    if !collision_line(x, y, target.x, target.y, Wall, 0, 0) {
        timer++
    }

    if point_distance(x, y, target.x, target.y) < 160 && !instance_exists(Portal) && timer > 150 {
        instance_destroy()
    }
}

event_inherited()