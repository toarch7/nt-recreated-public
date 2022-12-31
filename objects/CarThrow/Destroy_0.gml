repeat(4)
instance_create(x + random(6) - 3, y + random(6) - 3, Explosion)
instance_create(x, y + 6, Scorchmark)
event_inherited()

snd_play(sndExplosionCar)

repeat 2 + irandom(3) {
    with instance_create(x, y, GroundFlame) {
        move_contact_solid(random(360), 4 + random(16))
    }
}