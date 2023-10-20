alarm[1] = 15 + random(5)

scrTarget()
if instance_exists(target) {

    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
        //SEE TARGET
        gunangle = target_direction
        if target.x < x right = -1
        else if target.x > x right = 1
        //SEE PLAYER AND FAR ENOUGH AND NOT SHOUTING "FREEZE MOTHERFUCKER"
        if random(2) < 1 and freeze > 40 && distance_to_object(target) <= 250 {
            //FIRE
            alarm[2] = 2
            ammo = 8

            alarm[1] = 50
        } else if random(3) < 1 {
            //SHIELD
            with instance_create(x, y, PopoShield) {
                creator = other.id
            }

            alarm[1] = 85
            speed = 0
            walk = 0
        } else { //JUST WALK YOU KNOW
            if point_distance(x, y, target.x, target.y) > 64 direction = target_direction + random(50) - 25
            else direction = target_direction + 180 + random(90) - 45
            speed = 0.4
            walk = 10 + random(10)
            if freeze < 40 alarm[1] += random(30)
        }


    } else if random(3) < 1 {
        //WALK
        motion_add(random_angle, 0.4)
        walk = 20 + random(10)
        gunangle = direction
        if hspeed > 0 right = 1
        else if hspeed < 0 right = -1
    } else if freeze > 40 and random(4) < 1 and point_distance(x, y, target.x, target.y) < 96 {
        //SHIELD
        with instance_create(x, y, PopoShield) {
            creator = other.id
        }

        snd_play(male ? sndShielderShield : sndShielderShieldF)

        alarm[1] = 75
        speed = 0
        walk = 0
    }
} else if random(10) < 1 and roll = 0 {
    //NO TARGET
    motion_add(random_angle, 0.4)
    walk = 20 + random(10)
    alarm[1] = walk + 10 + random(30)
    gunangle = direction
    if hspeed > 0 right = 1
    else if hspeed < 0 right = -1
}