event_inherited()


if hspeed > 0 right = 1
else if hspeed < 0 right = -1

if walk > 0 {
    if sprite_index != spr_hurt motion_add(direction, 0.6)
}


if speed > 3 speed = 3

if target > 0 {
    if instance_exists(target) mp_potential_step(target.x, target.y, 1, 0)
}