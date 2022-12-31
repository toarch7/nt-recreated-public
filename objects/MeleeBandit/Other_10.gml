event_inherited()
if walk > 0 {
    walk -= 1

    if !alarm[2] {
        motion_add(direction, 2)
        if instance_exists(target) {
            mp_potential_step(target.x, target.y, 2, 0)
        }
    }
}

if speed > 3 speed = 3