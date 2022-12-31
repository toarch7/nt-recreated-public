justfired = 0
scrTarget()
alarm[1] = (10 + random(40))
if (sprite_index == spr_fire) {
    sprite_index = spr_idle
    justfired = 1
    alarm[1] += 10
}
if (instance_exists(target) && ((spr_idle != sprGuardianDisappear) && (spr_idle != sprGuardianAppear))) {
    if (target > Player) {
        if (collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0) {
            direction = ((target_direction + random(180)) - 90)
            if ((((point_distance(x, y, target.x, target.y) > 96) && (random(3) < 2)) || (random(3) < 1)) && (justfired == 0)) {
                sprite_index = spr_fire
                alarm[1] = 12
                snd_play(sndBigballFire)

                if instance_exists(target) {
                    gunangle = target_direction
                } else gunangle = direction

                with instance_create(x, y, BigGuardianBullet) {
                    motion_add(other.gunangle + random_range(-4, 4), 8)
                    team = other.team
                    creator = other.id
                    hit_id = other.spr_idle
                }
            } else if (random(2) < 1) {
                snd_play_hit_big(sndGuardianDisappear, 0.2)
                spr_idle = sprGuardianDisappear
                sprite_index = spr_idle
                alarm[1] += 60
            }
        }
    } else {
        motion_add(random(360), 0.5)
        if (random(20) < 1) {
            snd_play_hit_big(sndGuardianDisappear, 0.2)
            spr_idle = sprGuardianDisappear
            sprite_index = spr_idle
            alarm[1] += 60
        }
    }
} else motion_add(random(360), 0.5)