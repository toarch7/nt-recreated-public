instance_create(x, y, Explosion)
instance_create(x, y + 6, Scorchmark)
event_inherited()

repeat(25)
instance_create(x, y, ToxicGas)

snd_play(sndExplosion)
snd_play(sndToxicBarrelGas)

repeat 2 + irandom(3) {
    instance_create(x + random_spread(10), y + random_spread(10), GroundFlame)
}