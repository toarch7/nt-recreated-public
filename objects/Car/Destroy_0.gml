repeat 3 instance_create(x + random_spread(3), y + random_spread(3), Explosion)

repeat 3 + irandom(4) {
    with instance_create(x, y, GroundFlame) {
        move_contact_solid(random(360), 4 + random(16))
    }
}

corpse = 0

with instance_create(x, y + 6, Scorchmark) {
    visible = 0
}

event_inherited()

snd_play(sndExplosionCar)