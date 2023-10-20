if image_index == 0 {
    repeat 3 instance_create(x + orandom(3), y + orandom(3), Explosion)

    repeat 3 + irandom(4) {
        with instance_create(x, y, GroundFlame) {
            move_contact_solid(random_angle, 4 + random(16))
        }
    }

    instance_create(x, y + 6, Scorchmark)

    snd_play(sndExplosionCar)
}

event_inherited()