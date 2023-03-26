charge = 0
snd_play_gun(sndNothingBeamStart, 0)
snd_loop(sndNothingBeamLoop)
BackCont.shake += 7

with NothingBeamChargeParticle {
    motion_add(point_direction(other.x, other.y, x, y), 12 + random(6))
}

repeat 30 {
    with instance_create(x + orandom(20), y + random(64), NothingBeamParticle) {
        vspeed = 12 + random(10)
        image_angle = direction
        y += vspeed * random(60)

        if !place_meeting(x, y, Floor) {
            instance_destroy()
        }
    }
}