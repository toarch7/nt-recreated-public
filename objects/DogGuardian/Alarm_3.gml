leap = 0
spr_idle = sprDogGuardianLand
sprite_index = spr_idle
speed = 0
image_index = 0
alarm[1] = 8

BackCont.shake += 2
snd_play_hit_big(sndDogGuardianLand, 0.2)
instance_create(x, y, PortalClear)

ang = random_angle

repeat 12 {
    with instance_create(x, y + 10, Dust) {
        motion_add(other.ang, 3)
        vspeed *= 0.8
    }

    ang += 30
}