event_inherited()

if sprite_index != spr_hurt && !rest {
    motion_add(direction, .6)
}

if hspeed > 0 {
    right = 1
} else if hspeed < 0 {
    right = -1
}

if speed > 1.5 speed = 1.5

if random(4) < 1 {
    instance_create(x + random(16) - 8, y + random(16) - 10, CaveSparkle)
}