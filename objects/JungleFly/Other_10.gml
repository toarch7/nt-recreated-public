event_inherited()

if sprite_index != spr_hurt {
    motion_add(direction, 1)
}

if speed > 2 + (rage * 2) {
    speed = 2 + (rage * 2)
}

if speed < 1 {
    speed = 1
}

if hspeed > 0 {
    right = 1
} else if hspeed < 0 {
    right = -1
}