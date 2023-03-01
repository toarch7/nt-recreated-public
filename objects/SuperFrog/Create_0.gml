raddrop = 8
max_hp = 21
meleedamage = 0
size = 1

spr_idle = sprSuperFrogIdle
spr_walk = sprSuperFrogWalk
spr_hurt = sprSuperFrogHurt
spr_dead = sprSuperFrogDead

event_inherited()

snd_dead = sndSuperFrogExplode

//behavior
alarm[1] = 40 + random(40)

motion_add(point_direction(10016, 10016, x, y), 1)

close = 0

alarm[2] = 5


repeat(10)
instance_create(x, y, ToxicGas)