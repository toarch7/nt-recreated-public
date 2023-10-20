alarm[1] = 15 + random(5)
scrTarget()

if instance_exists(target) {
    if !collision_line(x, y, target.x, target.y, Wall, 0, 0) {
        gunangle = target_direction
        scrRight(1)

        if (random(4) < 3) && ((freeze > 40) && (point_distance(x, y, target.x, target.y) < 150)) {
            alarm[2] = 5
            ammo = 6
            alarm[1] = 20
        } else if (random(3) < 1) {
            snd_play_hit_big(sndEliteShielderShield, 0.2)
            with instance_create(x, y, EliteShield)
            creator = other.id

            alarm[1] = 85
            speed = 0
            walk = 0
        } else {
            speed = 0.4
            walk = 10 + random(10)
            if freeze < 40 alarm[1] += random(30)

            if point_distance(x, y, target.x, target.y > 64) direction = target_direction + random_range(-25, 25)
            else direction = target_direction + 180 + random_range(-45, 45)
        }
    } else if random(3) < 1 {
        gunangle = random_angle
        walk = 20 + random(10)
        motion_add(gunangle, 0.4)

        scrRight(0)
    } else if (freeze > 40) && (random(4) < 1) {
        snd_play_hit_big(sndEliteShielderShield, 0.2)
        with instance_create(x, y, EliteShield)
        creator = other.id

        alarm[1] = 75
        speed = 0
        walk = 0
    } else if random(10) < 1 && roll == 0 {
        gunangle = random_angle
        motion_add(gunangle, 0.4)
        walk = 20 + random(10)
        alarm[1] = walk + 10 + random(30)

        scrRight(0)
    }
}
