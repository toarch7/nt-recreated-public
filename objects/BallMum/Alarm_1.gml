alarm[1] = 30 + random(20)
walk = 0

scrTarget()

if instance_exists(target) && instance_exists(target) {
    if !collision_line(x, y, target.x, target.y, Wall, 0, 0) {
        direction = ((target_direction + random(20)) - 10)
    } else direction = random(360)

    if random(4) < 1 {
        alarm[2] = 10
    } else {
        walk = 50
        if (random(3) < 1 && !collision_line(x, y, target.x, target.y, Wall, 0, 0)) || (point_distance(x, y, target.x, target.y) < 160) {
            if !intro && GameCont.loops == 1 && ((x > view_xview && x < view_xview + view_width && y > view_yview && y < view_yview + view_height) || hp < max_hp * 0.95) {
                with MusCont {
                    alarm[2] = 1
                }

                intro = 1
                alarm[3] = 3

                scrBossIntro(5)
            }

            walk += 30
            alarm[1] = walk
            ammo = 2 + GameCont.loops
            alarm[2] = 10
        }
    }
} else {
    direction = random(360)
    if random(8) < 1 {
        walk = 50
    }
}