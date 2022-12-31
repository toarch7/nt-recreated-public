raddrop = 9
max_hp = 18
meleedamage = 3
size = 1

spr_idle = sprSpiderIdle
spr_walk = sprSpiderWalk
spr_hurt = sprSpiderHurt
spr_dead = sprSpiderDead

event_inherited()

snd_hurt = sndHitRock

//behavior
walk = 0
alarm[1] = 30 + random(90)
maxspeed = 3