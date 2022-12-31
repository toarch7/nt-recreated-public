alarm[1] = 13 + random(5)
if random(3) < 1 roll = 0

scrTarget()
if instance_exists(target) {
    var dist = point_distance(x, y, target.x, target.y)
    var dir = target_direction
    if dist < 64 && random(4) < 3 {
        gunangle = dir
        roll = 0

        motion_add(gunangle, 10)
        walk = 20 + random(10)

        scrRight(0)
        alarm[1] /= 3
    } else if random(2) < 1 && freeze > 40 {
        if dist > 150 direction = dir + random_spread(30)
        else direction = dir + random_range(70, 130) * choose(1, - 1)

        speed = 4
        roll = 1
        snd_play_hit_big(sndEliteGruntRoll, 0.2)
        instance_create(x, y, Dust)
    }

    if !collision_line(x, y, target.x, target.y, Wall, 0, 0) {
        gunangle = dir + random_spread(15)
        scrRight(1)

        if random(3) < 2 && freeze > 40 {
            ammo = 3
            alarm[2] = 1
            alarm[1] = 14 + random(2)
        } else {
            if dist > 48 direction = dir + random_spread(25)
            else direction = dir + 180 + random_spread(25)

            speed = 0.4
            walk = 10 + random(10)
            if freeze < 40 alarm[1] += random(30)
        }
    } else if (random(4) < 1) {
        gunangle = random(360)
        walk = 20 + random(10)
        motion_add(gunangle, 0.4)

        scrRight(0)
    } else if grenades > 0 && freeze > 40 && random(5) < 1 && dist < 180 {
        alarm[1] += 30

        roll = 0
        walk = 0
        grenades--

        gunangle = dir + random_spread(10)
        wkick = 8
        snd_play_hit_big(sndEliteGruntRocketFire, 0.2)
        with instance_create(x, y, IDPDRocket) {
            hitid = sprEliteGruntIdle
            motion_add(other.gunangle + random_spread(10), 10)
            image_angle = direction
            team = other.team
        }
    }
} else if random(10) < 1 && !roll {
    gunangle = random(360)
    walk = 20 + random(10)
    motion_add(gunangle, 0.4)

    alarm[1] = walk + 10 + random(30)

    scrRight(0)
}