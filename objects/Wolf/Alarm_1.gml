alarm[1] = 30 + random(20)
walk = alarm[1]

scrTarget()

if sprite_index == spr_fire sprite_index = spr_idle

if target {
    if !collision_line(x, y, target.x, target.y, Wall, 0, 0) {
        if random(2) < 1 {
            snd_play_hit_big(sndWolfRoll, 0.2)
            direction = target_direction
            sprite_index = spr_fire
            image_index = 0
            alarm[2] = 10
            alarm[1] = 30
        } else {
            direction = target_direction + orandom(15)

            if random(4) < 1 {
                speed = 0
                walk = 0
            }
        }
    } else {
        if random(3) < 1 {
            speed = 0
            walk = 0
        }

        motion_add(random_angle, 2)
        motion_add(target_direction, 1.5)
    }
} else motion_add(random_angle, 2)