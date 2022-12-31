if roll or race == 15 {
    move_bounce_solid(00)
    exit
}

move_contact_solid(direction, max(1, min(maxspeed, speed)))

if !place_free(x + hspeed, y) {
    hspeed /= 2
    if !place_free(x + hspeed, y) {
        hspeed = 0
    }
}

if !place_free(x, y + vspeed) {
    vspeed /= 2
    if !place_free(x, y + vspeed) {
        vspeed = 0
    }
}

if hammerheads && hammerhead >= 12 {
    with other {
        with instance_create(x, y, AnimParticle) {
            sprite_index = sprHammerHeadBreak
            depth = other.depth - 1

            image_speed = 0.4
        }

        instance_create(x, y, FloorExplo)
        instance_destroy()
    }

    hammerheads--

    if !hammerheads {
        snd_play(sndHammerHeadEnd)
    } else {
        snd_play(sndHammerHeadProc)
    }
}