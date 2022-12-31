if image_index == 0 {
    repeat 3 instance_create(x + random_spread(3), y + random_spread(3), Explosion)

    repeat 3 + irandom(4) {
        with instance_create(x, y, GroundFlame) {
            move_contact_solid(random(360), 4 + random(16))
        }
    }

    instance_create(x, y + 6, Scorchmark)

    snd_play(sndExplosionCar)
}

event_inherited()