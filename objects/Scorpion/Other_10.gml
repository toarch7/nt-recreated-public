event_inherited()

if (walk > 0) {
    motion_add(direction, 2)
    walk -= timescale
}

if (speed > 4) speed = 4