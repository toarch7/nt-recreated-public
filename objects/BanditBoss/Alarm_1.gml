alarm[1] = 30 + random(60)

if GameCont.loops {
    alarm[1] = 20 + random(50)
}

meleedamage = 0

scrTarget()
if instance_exists(target) {
    if point_distance(x, y, target.x, target.y) < 240 or intro = 0 {
        if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 and point_distance(x, y, target.x, target.y) > 48 and intro = 1 {
            if random(3) < 2 {
                snd_play(sndBigBanditStartShoot)
                ammo = 10
                if GameCont.loops ammo += 5 alarm[2] = 1 gunangle = target_direction alarm[1] = 70 + random(5)
            }
        } else if shot = 1 or hp < max_hp or intro = 0 {
            //CHARGE HERE
            chargewait += 1
            if point_distance(x, y, target.x, target.y) < 96 chargewait += 1
            if chargewait >= 2 or intro = 0 {
                alarm[3] = 1
                alarm[1] = -1
                chargewait = 0
            }
        }
    }
    direction = point_direction(target.x, target.y, x, y) + random(180) - 90
    speed = 0.4
    walk = 10 + random(10)
    if point_distance(x, y, target.x, target.y) > 64 {
        walk = 40
        direction = point_direction(target.x, target.y, x, y) + random(90) - 45
    }

    if target.x < x right = -1
    else if target.x > x right = 1
} else if random(5) < 1 {
    motion_add(random_angle, 0.4)
    walk = 10 + random(10)
    alarm[1] = walk + 10 + random(30)
    if hspeed > 0 right = 1
    else if hspeed < 0 right = -1
}