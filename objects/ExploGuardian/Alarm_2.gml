sprite_index = spr_fire
ang = random_angle

repeat 14 {
    with instance_create(x, y, ExploguardianBullet) {
        team = other.team
        motion_add(other.ang, 10)
        image_angle = direction
        hitid = other.hitid
    }

    ang += 24
}

instance_create(x, y, PortalClear)

charge = 0
alarm[1] = 8 / max(0.01, image_speed)
snd_play_hit(sndExploGuardianFire, 0.2)

if instance_exists(target) motion_add(mcr_target_direction + random(40) - 20, 1.5)
walk = 20

spr_idle = sprExploGuardianIdle
spr_hurt = sprExploGuardianHurt