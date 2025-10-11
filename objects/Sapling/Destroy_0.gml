instance_create(x, y, MeatExplosion)

var _ang = random_angle

snd_play_hit(sndSaplingDead, 0.2)

instance_create(x + lengthdir_x(24, _ang), y + lengthdir_y(24, _ang), MeatExplosion)
instance_create(x + lengthdir_x(24, _ang + 120), y + lengthdir_y(24, _ang + 120), MeatExplosion)
instance_create(x + lengthdir_x(24, _ang + 240), y + lengthdir_y(24, _ang + 240), MeatExplosion)

instance_create(x, y, Scorchmark)