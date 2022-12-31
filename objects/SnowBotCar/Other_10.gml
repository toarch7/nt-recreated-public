event_inherited()

if walk > 0 {
    walk -= 1
    motion_add(gunangle, 1)
}

if sprite_index = spr_fire {
    if speed > 3 speed = 3
} else if speed > 1 speed = 1