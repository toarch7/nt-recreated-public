alarm[1] = 20 + random(10)

if control {
    if (random(2) < 1) control = 0

    snd_play_hit_big(sndEliteInspectorEnd, 0.2)
}

scrTarget()
if instance_exists(target) {
    if random(2) < 1 && freeze > 40 {
        control = 1
        alarm[1] += 10
        snd_play_hit_big(sndEliteInspectorStart, 0.2)
    }

    if !collision_line(x, y, target.x, target.y, Wall, 0, 0) {
        gunangle = target_direction
        scrRight(0)

        lastx = target.x
        lasty = target.y

        if random(3) < 2 && freeze > 40 && point_distance(x, y, target.x, target.y) < 64 {
            alarm[2] = 5
            alarm[1] += 5
            instance_create(x, y, HitWarning)
            snd_play_hit_big(sndEliteInspectorAlarmed, 0.2)
            walk = 0
        } else {
            direction = target_direction + orandom(20)
            speed = 0.4
            walk = 30 + random(10)
            alarm[1] /= 2
        }
    } else if (random(3) < 2) {
        gunangle = random_angle
        walk = 20 + random(10)
        motion_add(gunangle, 0.4)

        scrRight(0)
    } else if random(3 + instance_number(PopoNade) * 3) < 1 && grenades > 0 && freeze > 40 && point_distance(x, y, target.x, target.y) < 160 && point_distance(lastx, lasty, target.x, target.y) < 160 && point_distance(x, y, lastx, lasty) > 64 || random(8) < 1 {
        grenades--gunangle = point_direction(x, y, lastx, lasty)
        snd_play_hit_big(sndEliteInspectorAlarmed, 0.2)
        wkick = 8
        with instance_create(x, y, PopoNade) {
            hit_id = sprEliteInspectorIdle
            motion_add(other.gunangle + orandom(10), 10)
            image_angle = direction
            team = other.team
        }
    }
} else if random(10) < 1 {
    gunangle = random_angle
    walk = 20 + random(10)
    motion_add(gunangle, 0.4)

    alarm[1] = walk + 10 + random(30)

    scrRight(0)
}