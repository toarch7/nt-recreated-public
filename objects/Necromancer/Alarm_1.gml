alarm[1] = 20 + random(5)

scrTarget()
if instance_exists(target) {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 and random(5) < 3 {
        if random(3) < 2 {
            motion_add(point_direction(target.x, target.y, x, y) + random(80) - 40, 0.4)
            walk = 40 + random(10)
            alarm[1] = walk
            gunangle = direction
            if hspeed > 0 right = 1
            else if hspeed < 0 right = -1
        } else {
            if instance_exists(Corpse) {
                crp = instance_nearest(x, y, Corpse)
                if !collision_line(x, y, crp.x, crp.y, Wall, 0, 0) {
                    gunangle = point_direction(x, y, crp.x, crp.y)
                    with crp {
                        instance_create(x, y, ReviveCircle)
                    }

                    snd_play(sndNecromancerRevive)
                    alarm[1] = 40 + random(5)
                    wkick = 5
                }
            }
        }
    } else {
        //DONT SEE PLAYER
        if random(4) < 3 {
            if instance_exists(Corpse) {
                crp = instance_nearest(x, y, Corpse)
                if !collision_line(x, y, crp.x, crp.y, Wall, 0, 0) {
                    wkick = 5
                    gunangle = point_direction(x, y, crp.x, crp.y)
                    with crp {
                        instance_create(x, y, ReviveCircle)
                    }
                    snd_play(sndNecromancerRevive)
                    alarm[1] = 15 + random(5)
                }
            }
        } else if random(2) < 1 {
            motion_add(random_angle, 0.4)
            walk = 20 + random(10)
            alarm[1] = walk + 10 + random(30)
            gunangle = direction
            if hspeed > 0 right = 1
            else if hspeed < 0 right = -1
        }
    }
} else if random(10) < 1 {
    //PLAYER IS NOT THERE
    motion_add(random_angle, 0.4)
    walk = 20 + random(10)

    alarm[1] = walk + 10 + random(30)
    gunangle = direction

    if hspeed > 0 right = 1
    else if hspeed < 0 right = -1
}