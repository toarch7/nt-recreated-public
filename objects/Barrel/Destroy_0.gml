instance_create(x, y, Explosion)
event_inherited()

repeat (4) {
    instance_create(x + orandom(16), y + orandom(16), GroundFlame)
}

snd_play(sndExplosion)