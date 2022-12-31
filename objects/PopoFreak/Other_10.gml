event_inherited()
if (hspeed > 0) right = 1
else if (hspeed < 0) right = -1
if (walk > 0) {
    walk -= 1
    if (sprite_index != spr_hurt) motion_add(direction, 0.55)
    else motion_add(walkdir, 1)
}
if (speed > 4.5) speed = 4.5