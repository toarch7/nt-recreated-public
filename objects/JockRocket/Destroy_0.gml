snd_stop(snd)

snd_play(sndExplosionL)
ang = random(360)
instance_create(x + lengthdir_x(12, ang), y + lengthdir_y(12, ang), Explosion)
instance_create(x + lengthdir_x(12, ang + 180), y + lengthdir_y(12, ang + 180), Explosion)