alarm[1] = (15 + random(5))
rest = 0
scrTarget()
if instance_exists(target) {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
        if !ammo && random(2) < 1 && point_distance(x, y, target.x, target.y) > 64 && point_distance(x, y, target.x, target.y) < 160 {
            snd_play_hit_big(sndGoldTankAim, .2)
            scrTarget()

            if instance_exists(target) {
                gunangle = target_direction
            }

            alarm[2] = 10
            ammo = 16
        }

        direction = target_direction + 70 + random(40) * choose(1, - 1)
    } else motion_add(random(360), .5)
} else motion_add(random(360), .5)