repeat 5 {
    instance_create(x + random(6) - 3, y + random(6) - 3, Explosion)
}

with instance_create(x, y + 6, Scorchmark) {
    visible = 0
}

repeat 2 + irandom(3) {
    with instance_create(x, y, GroundFlame) {
        move_contact_solid(random_angle, 4 + random(16))
    }
}

corpse = 0

event_inherited()

snd_play(sndExplosionCar)
snd_stop(sndCarLoop)