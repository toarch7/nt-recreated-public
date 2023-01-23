alarm[1] = 20 + random(20)
var _control = control
control = 0
scrTarget()
if instance_exists(target) {
    if random(3) < 1 and freeze > 40 {
        //MIND CONTROL
        control = 1
    } else {
        if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
            gunangle = target_direction
            if target.x < x right = -1
            else if target.x > x right = 1 lastx = target.x lasty = target.y
            //SEE PLAYER AND FAR ENOUGH AND NOT SHOUTING "FREEZE MOTHERFUCKER"
            if random(2) < 1 and freeze > 40 {
                //FIRE
                snd_play(sndGruntFire)

                with instance_create(x, y, PopoSlug) {
                    motion_add(other.gunangle + random(12) - 6, 16)
                    image_angle = direction
                    hit_id = other.spr_idle
                    team = other.team
                }

                BackCont.shake += 3
                wkick = 8
                alarm[1] = 20 + random(10)
            } else {
                //DONT FIRE
                if point_distance(x, y, target.x, target.y) > 48 direction = target_direction + random(50) - 25
                else direction = target_direction + 180 + random(50) - 25
                speed = 0.4
                walk = 10 + random(10)
                if freeze < 40 alarm[1] += random(30)
            }

        } else {
            //DONT SEE PLAYER
            if random(4) < 1 {
                //WALK
                motion_add(random(360), 0.4)
                walk = 20 + random(10)
                gunangle = direction
                if hspeed > 0 right = 1
                else if hspeed < 0 right = -1
            } else if random(5 + instance_number(PopoNade) * 3) < 1 and grenades > 0 and freeze > 40 and((point_distance(lastx, lasty, target.x, target.y) < 96 and point_distance(x, y, lastx, lasty) > 64) or random(12) < 1) {
                grenades -= 1
                //GRENADE
                gunangle = point_direction(x, y, lastx, lasty)
                snd_play(male ? sndGruntThrowNade : sndGruntThrowNadeF)
                wkick = 8
                with instance_create(x, y, PopoNade) {
                    motion_add(other.gunangle + random(20) - 10, 10)
                    image_angle = direction
                    team = other.team
                    hit_id = other.hit_id
                }
            }

        }
    }
} else if random(10) < 1 {
    //NO TARGET
    motion_add(random(360), 0.4)
    walk = 20 + random(10)
    alarm[1] = walk + 10 + random(30)
    gunangle = direction
    if hspeed > 0 right = 1
    else if hspeed < 0 right = -1
}

if !control && _control {
    snd_play(male ? sndInspectorEnd : sndInspectorEndF)
} else if control && !_control {
    snd_play(male ? sndInspectorStart : sndInspectorStartF)
}