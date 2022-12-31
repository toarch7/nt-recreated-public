alarm[1] = 40
scrTarget()
meleedamage = 0
sprite_index = spr_idle
if target > 0 {
    //CHARGE ATTACK
    if point_distance(x, y, target.x, target.y) < 120 and random(4) < 1 {
        snd_play(sndSnowBotSlideLoop)
        snd_play(sndSnowBotSlideStart)
        walk = 40
        alarm[1] = 40
        gunangle = target_direction + random(30) - 15
        meleedamage = 4
        sprite_index = spr_fire
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