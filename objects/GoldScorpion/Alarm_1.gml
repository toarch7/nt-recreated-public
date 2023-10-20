alarm[1] = 30 + random(10)
scrTarget()
if instance_exists(target) {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 and random(2) < 1 {
        ammo = 20
        walk = 0
        alarm[2] = 1
        snd_play(sndGoldScorpionFire)
        gunangle = target_direction
        alarm[1] = 20 + random(5)
    }
    direction = point_direction(target.x, target.y, x, y) + random(120) - 60
    speed = 0.4
    if ammo = 0 walk = 10 + random(10) if point_distance(x, y, target.x, target.y) < 64 {
        walk = 40
        direction = point_direction(target.x, target.y, x, y) + random(20) - 10
    }

    if target.x < x right = -1
    else if target.x > x right = 1
    if ammo = 0 motion_add(target_direction, 0.3)
} else if random(10) < 1 {
    motion_add(random_angle, 0.4)
    walk = 10 + random(10)
    alarm[1] = walk + 10 + random(30)
    if hspeed > 0 right = 1
    else if hspeed < 0 right = -1
}