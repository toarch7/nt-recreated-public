alarm[1] = 15 + random(10)

scrTarget()
if instance_exists(target) {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
        if point_distance(target.x, target.y, x, y) > 96 {
            if random(4) < 1 {
                gunangle = target_direction
                snd_play(sndEnemyFire)
                wkick = 4
                with instance_create(x, y, EnemyBullet1) {
                    hit_id = other.spr_idle
                    creator = other.id
                    motion_add(other.gunangle + random(4) - 2, 4)
                    image_angle = direction
                    team = other.team
                }
                snd_play(sndMolefishFire)
                alarm[1] = 20 + random(5)
            } else {
                direction = target_direction + (45 + random(90)) * choose(1, - 1)
                speed = 0.4
                walk = 10 + random(10)
                gunangle = target_direction
            }

        } else {
            direction = point_direction(target.x, target.y, x, y) + random(20) - 10
            speed = 0.4
            walk = 20 + random(10)
            gunangle = target_direction
        }

        if target.x < x right = -1
        else if target.x > x right = 1
    } else if random(4) < 1 {
        motion_add(random_angle, 0.4)
        walk = 20 + random(10)
        alarm[1] = walk + 5
        gunangle = direction
        if hspeed > 0 right = 1
        else if hspeed < 0 right = -1
    }
} else if random(10) < 1 {
    motion_add(random_angle, 0.4)
    walk = 20 + random(10)
    alarm[1] = walk + 5
    gunangle = direction
    if hspeed > 0 right = 1
    else if hspeed < 0 right = -1
}