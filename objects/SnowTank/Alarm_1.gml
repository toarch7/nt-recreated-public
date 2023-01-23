alarm[1] = 40 + random(30)
rest = 0
scrTarget()
if instance_exists(target) {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
        if ammo = 0 and random(6) < 1 and point_distance(x, y, target.x, target.y) > 64 and point_distance(x, y, target.x, target.y) < 240 {
            snd_play(sndSnowTankAim)
            scrTarget()
            if instance_exists(target) gunangle = target_direction alarm[2] = 40

            ammo = 16
        }
        direction = target_direction + (70 + random(40)) * choose(1, - 1)
    } else motion_add(random(360), 0.5)
} else motion_add(random(360), 0.5)