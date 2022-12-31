alarm[1] = 30 + random(10)
scrTarget()
if target > 0 {
    walk = 10 + random(10)
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 and random(3) < 1 {
        ammo = choose(3, 4, 5)
        alarm[2] = 1
        gunangle = target_direction
        snd_play(sndRatKingVomit)
        alarm[1] = 30 + random(5)
        walk = 40 + random(10)
    }
    direction = point_direction(target.x, target.y, x, y) + random(80) - 40
    speed = 0.4
    if point_distance(x, y, target.x, target.y) < 64 {
        walk = 40 + random(10)
        direction = point_direction(target.x, target.y, x, y) + 10 - random(20) + choose(180, 180, 0)
    }

    if target.x < x right = -1
    else if target.x > x right = 1
} else if random(10) < 1 {
    motion_add(random(360), 0.4)
    walk = 40 + random(10)
    alarm[1] = walk + 10 + random(30)
    if hspeed > 0 right = 1
    else if hspeed < 0 right = -1
}