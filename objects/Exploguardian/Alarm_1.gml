scrTarget()
alarm[1] = 6 + random(5)
walk = alarm[1] - 1

if !charge {
    if instance_exists(target) && collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
        motion_add(mcr_target_direction + random(40) - 20, 1.5)
    } else motion_add(random_angle, 0.5)

    if distance_to_object(target) <= 90 {
        alarm[2] = 60
        spr_idle = sprExploGuardianCharge
        spr_hurt = sprExploGuardianChargeHurt
        charge = 1
        walk = 0
        snd_play_hit(sndExploGuardianCharge, 0.2)
    }

    if sprite_index == spr_fire sprite_index = spr_idle
}