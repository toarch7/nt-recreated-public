raddrop = 1
max_hp = 2
meleedamage = 1
size = 0

spr_idle = sprMaggotIdle
spr_walk = sprMaggotIdle
spr_hurt = sprMaggotHurt
spr_dead = sprMaggotDead

event_inherited()

//behavior
alarm[1] = 10 + random(10)

spr_shadow = shd16