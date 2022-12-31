event_inherited()

if walk > 0 {
    walk -= 1
    motion_add(direction, 2)
}

if hspeed > 0 right = 1
else if hspeed < 0 right = -1
if speed > maxspeed speed = maxspeed

if irandom(3) instance_create(x + random_range(-8, 8), y + random_range(-12, 12), Curse)