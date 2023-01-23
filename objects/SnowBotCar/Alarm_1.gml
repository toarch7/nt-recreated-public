alarm[1] = 40
scrTarget()
meleedamage = 0
sprite_index = spr_idle
if instance_exists(target) {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 and random(3) < 1 and point_distance(x, y, target.x, target.y) < 160 {

        gunangle = target_direction + random(8) - 4
        //SEE PLAYER


        spr_idle = sprSnowBotCarThrow
        spr_walk = sprSnowBotWalk
        spr_hurt = sprSnowBotHurt
        alarm[2] = 5 / 0.4
        sprite_index = spr_idle
        speed = 0
        image_index = 0
        snd_play(sndSnowBotThrow)
        instance_change(SnowBot, false)
        with instance_create(x, y, CarThrow) {
            team = other.team
            motion_add(other.gunangle, 12)
        }

    } else if random(5) < 1 {
        //DO NOTHING
        gunangle = random(360)
        walk = 30
        if hspeed > 0 right = 1
        else if hspeed < 0 right = -1
    }

    if target.x < x right = -1
    else if target.x > x right = 1
} else if random(5) < 1 {
    //DO NOTHING
    gunangle = random(360)
    walk = 30
    if hspeed > 0 right = 1
    else if hspeed < 0 right = -1
}