alarm[1] = 20 + random(10)
if sprite_index != spr_hurt sprite_index = spr_idle scrTarget() if target > 0 {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
        if random(3) < 1 {
            direction = target_direction + 180
            with instance_create(x, y, Fireball) {
                hit_id = other.spr_idle
                motion_add(other.direction + 180 + random(12) - 6, 3)
                image_angle = direction
                team = other.team
            }
            snd_play(sndFireballerFire)
            image_index = 0
            sprite_index = spr_fire
            alarm[1] = 8
        } else direction = target_direction + random(20) - 10
    } else motion_add(random(360), 1)
} else motion_add(random(360), 0.5)