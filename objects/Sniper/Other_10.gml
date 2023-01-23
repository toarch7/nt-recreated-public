event_inherited()

if walk > 0 {
    walk -= 1
    motion_add(direction, 0.8)
}

if gonnafire = 1 and alarm[2] > 5 and instance_exists(target) {
    gunangle = target_direction
}

if speed > 1.5 speed = 1.5