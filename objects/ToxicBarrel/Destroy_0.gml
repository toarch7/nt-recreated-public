instance_create(x, y, Explosion)
event_inherited()

repeat (25) instance_create(x, y, ToxicGas)

snd_play(sndExplosion)
snd_play(sndToxicBarrelGas)

repeat (4) instance_create(x + orandom(16), y + orandom(16), GroundFlame)
