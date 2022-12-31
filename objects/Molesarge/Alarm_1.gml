alarm[1] = 15 + random(10)

scrTarget()
if target > 0 {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
        if point_distance(target.x, target.y, x, y) < 120 {
            if random(3) < 1 {
                snd_play(sndMolesargeFire)
                gunangle = target_direction + random(20) - 10
                snd_play(sndEnemyFire)
                wkick = 8
                motion_add(gunangle + 180, 3)

                with instance_create(x, y, EnemyBullet3) {
                    motion_add(other.gunangle, 10 + random(2))
                    image_angle = direction
                    hit_id = other.spr_idle
                    creator = other.id
                    team = other.team
                }
                with instance_create(x, y, EnemyBullet3) {
                    motion_add(other.gunangle - 15, 10 + random(2))
                    image_angle = direction
                    hit_id = other.spr_idle
                    creator = other.id
                    team = other.team
                }
                with instance_create(x, y, EnemyBullet3) {
                    motion_add(other.gunangle + 15, 10 + random(2))
                    image_angle = direction
                    hit_id = other.spr_idle
                    creator = other.id
                    team = other.team
                }
                with instance_create(x, y, EnemyBullet3) {
                    motion_add(other.gunangle - 30, 10 + random(2))
                    image_angle = direction
                    hit_id = other.spr_idle
                    creator = other.id
                    team = other.team
                }
                with instance_create(x, y, EnemyBullet3) {
                    motion_add(other.gunangle + 30, 10 + random(2))
                    image_angle = direction
                    hit_id = other.spr_idle
                    creator = other.id
                    team = other.team
                }
                alarm[1] = 30 + random(5)
            } else {
                direction = target_direction + (45 + random(90)) * choose(1, - 1)
                speed = 0.4
                walk = 10 + random(10)
                gunangle = target_direction
            }

        } else {
            direction = target_direction + random(20) - 10
            speed = 0.4
            walk = 30 + random(10)
            gunangle = target_direction
        }

        if target.x < x right = -1
        else if target.x > x right = 1
    } else if random(4) < 1 {
        motion_add(random(360), 0.4)
        walk = 20 + random(10)
        alarm[1] = walk + 5
        gunangle = direction
        if hspeed > 0 right = 1
        else if hspeed < 0 right = -1
    }
} else if random(10) < 1 {
    motion_add(random(360), 0.4)
    walk = 20 + random(10)
    alarm[1] = walk + 5
    gunangle = direction
    if hspeed > 0 right = 1
    else if hspeed < 0 right = -1
}