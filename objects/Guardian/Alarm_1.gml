justfired = 0
scrTarget()
alarm[1] = (10 + random(40))
if (sprite_index == spr_fire) {
    sprite_index = spr_idle
    justfired = 1
    alarm[1] += 10
}
if (instance_exists(target) && ((spr_idle != sprPalaceGuardianDisappear) && (spr_idle != sprPalaceGuardianAppear))) {
    if (target > Player) {
        if (collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0) {
            direction = ((target_direction + random(180)) - 90)
            if ((((point_distance(x, y, target.x, target.y) > 96) && (random(3) < 2)) || (random(3) < 1)) && (justfired == 0)) {
                sprite_index = spr_fire
                alarm[1] = 12
                snd_play_hit_big(sndGuardianFire, 0.2)
                with(instance_create((x + (right * 16)), y, GuardianBullet)) {
                    hit_id = other.spr_idle
                    motion_add(point_direction(x, y, other.target.x, other.target.y), 1)
                    image_xscale = other.right
                    team = other.team
                }
                with(instance_create((x + (right * 16)), y, GuardianBullet)) {
                    hit_id = other.spr_idle
                    motion_add((point_direction(x, y, other.target.x, other.target.y) - 40), 2)
                    image_xscale = other.right
                    team = other.team
                }
                with(instance_create((x + (right * 16)), y, GuardianBullet)) {
                    hit_id = other.spr_idle
                    motion_add((point_direction(x, y, other.target.x, other.target.y) + 40), 2)
                    image_xscale = other.right
                    team = other.team
                }
            } else if (random(2) < 1) {
                snd_play_hit_big(sndGuardianDisappear, 0.2)
                spr_idle = sprPalaceGuardianDisappear
                sprite_index = spr_idle
                alarm[1] += 60
            }
        }
    } else {
        motion_add(random(360), 0.5)
        if (random(20) < 1) {
            snd_play_hit_big(sndGuardianDisappear, 0.2)
            spr_idle = sprPalaceGuardianDisappear
            sprite_index = spr_idle
            alarm[1] += 60
        }
    }
} else motion_add(random(360), 0.5)