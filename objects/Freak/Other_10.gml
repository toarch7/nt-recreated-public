event_inherited()


if hspeed > 0 right = 1
else if hspeed < 0 right = -1

if walk > 0 {
    if sprite_index != spr_hurt motion_add(direction, 0.55)
}


if speed > 4 speed = 4