raddrop = 5
max_hp = 25
meleedamage = 0
size = 1

spr_idle = sprFireBallerIdle
spr_walk = sprFireBallerIdle
spr_hurt = sprFireBallerHurt
spr_dead = sprFireBallerDead
spr_fire = sprFireBallerFire

event_inherited()

snd_hurt = sndFireballerHurt
snd_dead = sndFireballerDead

spr_shadow = shd32

//behavior
alarm[1] = 10 + random(10)

motion_add(point_direction(10016, 10016, x, y), 1)