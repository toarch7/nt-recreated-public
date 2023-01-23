alarm[1] = 20 + random(10)

if sprite_index != spr_hurt
    sprite_index = spr_idle

scrTarget()

if target > 0 {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
        if point_distance(target.x, target.y, x, y) > 96 {
            gunangle = target_direction
            if random(8 - ammo) < 1 and ammo > 0 {
                ammo -= 1
                snd_play(sndEnemyFire)
                image_index = 0
                sprite_index = spr_fire
                wkick = 4
                with instance_create(x, y, JockRocket) {
                    motion_add(other.gunangle + random(20) - 10, 2)
                    image_angle = direction
                    team = other.team
                    hit_id = other.spr_idle
                }
                alarm[1] = 8
            } else if random(3) < 2 {
                direction = target_direction + random(80) - 40
                speed = 0.4
                walk = 10 + random(10)
                gunangle = target_direction
            }

        } else {
            direction = target_direction + random(10) - 5
            speed = 0.4
            walk = 40 + random(10)
            gunangle = target_direction
        }

        if target.x < x right = -1
        else if target.x > x right = 1
    } else if random(4) < 1 {
        motion_add(random(360), 0.4)
        walk = 20 + random(10)
        alarm[1] = walk + 10 + random(30)
        gunangle = direction
        if hspeed > 0 right = 1
        else if hspeed < 0 right = -1
    }
} else if random(10) < 1 {
    motion_add(random(360), 0.4)
    walk = 20 + random(10)
    alarm[1] = walk + 10 + random(30)
    gunangle = direction
    if hspeed > 0 right = 1
    else if hspeed < 0 right = -1
}