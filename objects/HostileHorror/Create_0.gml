raddrop = 90
max_hp = 60
meleedamage = 4
size = 5
alarm[3] = 10
spr_idle = sprHostileHorrorIdle
spr_walk = sprHostileHorrorWalk
spr_hurt = sprHostileHorrorHurt
spr_dead = sprHostileHorrorDead
event_inherited()
snd_hurt = sndMutant11Hurt
snd_dead = sndMutant11Dead
walk = 0
gunangle = random_angle
gunoffset = 0
alarm[1] = 60 + random(10)
ammo = 0
charge = 0
instance_create(x, y, PortalClear)