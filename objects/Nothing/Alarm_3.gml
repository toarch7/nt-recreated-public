if ammo > 0 {
    if ammo == 60 {
        if instance_exists(target) {
            targetx = target.x
            targety = target.y
        } else {
            targetx = x
            targety = y + 1000
        }
    }

    alarm[3] = 1

    repeat 10 {
        with instance_create(x + orandom(16), y + 50, NothingBeam) {
            hit_id = other.hit_id
            motion_add(270, 16)
            motion_add(point_direction(other.x, other.y, other.targetx, other.targety), 12)
            speed = 24
            image_angle = direction
            team = other.team
        }
    }

    ammo -= 1
} else {
    audio_stop_sound(sndNothingBeamLoop)
    snd_play(sndNothingBeamEnd)
}