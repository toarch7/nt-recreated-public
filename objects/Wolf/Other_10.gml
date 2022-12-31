event_inherited()

if sprite_index != spr_hurt and walk > 0 {
    motion_add(direction, 1)
    walk -= 1
}


if hspeed > 0 right = 1
else if hspeed < 0 right = -1

if sprite_index = spr_fire {
    instance_create(x + random(6) - 3, y + random(6), Dust)

    if speed > 5 speed = 5
} else if speed > 3.5 {
    speed = 3.5
}