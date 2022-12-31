event_inherited()

if walk > 0 {
    walk -= 1
    motion_add(direction, 1)
    if sprite_index != spr_hurt sprite_index = spr_fire meleedamage = 4
} else {
    if sprite_index = spr_fire sprite_index = spr_idle meleedamage = 0
}

if speed > 5 speed = 5