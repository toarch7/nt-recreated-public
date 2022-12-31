event_inherited()

if walk > 0 {
    walk -= 1
    motion_add(gunangle, 1)
    if sprite_index != spr_hurt and meleedamage != 0 {
        if random(2) < 1 instance_create(x + random(8) - 4, y + 4 + random(4), Dust) sprite_index = spr_fire
    }
}

if sprite_index = spr_fire {
    if speed > 8 speed = 8
} else if speed > 3 speed = 3