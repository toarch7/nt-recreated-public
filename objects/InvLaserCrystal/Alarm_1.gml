alarm[1] = 30 + random(10)
scrTarget()
if target > 0 {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 and point_distance(x, y, target.x, target.y) < 160 {
        if point_distance(x, y, target.x, target.y) > 64 {
            ammo = 4
            alarm[2] = 30
            snd_play(sndLaserCrystalCharge)
            gunangle = target_direction
            sprite_index = spr_fire
            alarm[1] = 90 + random(10)
        } else {
            if random(3) < 1 direction = target_direction
            else direction = choose(direction, target_direction + 90 + random(180))
        }
    } else if random(3) < 1 direction = random(360)

    if target.x < x right = -1
    else if target.x > x right = 1
} else if random(10) < 1 {
    motion_add(random(360), 0.4)
    alarm[1] = 10 + random(30)
    if hspeed > 0 right = 1
    else if hspeed < 0 right = -1
}

if !irandom(4) && !alarm[3] alarm[3] = 45