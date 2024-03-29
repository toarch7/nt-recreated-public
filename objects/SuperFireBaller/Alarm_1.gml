alarm[1] = 20 + random(10)

if sprite_index != spr_hurt
    sprite_index = spr_idle

scrTarget()
if instance_exists(target) {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
        if random(5) < 4 {
            direction = target_direction + 180
            with instance_create(x, y, Fireball) {
                hit_id = other.spr_idle
                motion_add(other.direction + 180 + random(12) - 6, 3)
                image_angle = direction
                team = other.team
                creator = other.id
            }

            with instance_create(x, y, Fireball) {
                motion_add(other.direction + 180 + random(12) - 6, 4)
                image_angle = direction
                team = other.team
                creator = other.id
                hit_id = other.spr_idle
            }

            with instance_create(x, y, Fireball) {
                hit_id = other.spr_idle
                motion_add(other.direction + 180 + random(12) - 6, 5)
                image_angle = direction
                team = other.team
                creator = other.id
            }

            snd_play(sndSuperFireballerFire)
            image_index = 0
            sprite_index = spr_fire
            alarm[1] = 8
        } else direction = target_direction + random(20) - 10
    } else motion_add(random_angle, 1)
} else motion_add(random_angle, 0.5)