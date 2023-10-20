sprite_index = spr_fire
ang = random_angle

repeat 14 {
    with instance_create(x, y, ExploguardianBullet) {
        team = other.team
        motion_add(other.ang, 10)
        image_angle = direction
        hit_id = other.spr_idle
    }

    ang += 24
}

instance_create(x, y, PortalClear)

charge = 0
alarm[1] = 8 / .4
snd_play_hit(sndExploGuardianFire, .2)

if instance_exists(target) motion_add(target_direction + random(40) - 20, 1.5)
walk = 20

spr_idle = sprExploguardianIdle
spr_hurt = sprExploguardianHurt