repeat(4)
instance_create(x + orandom(3), y + orandom(3), Explosion)
event_inherited()

snd_play(sndExplosionCar)

repeat (6) {
    instance_create(x + orandom(16), y + orandom(16), GroundFlame)
}