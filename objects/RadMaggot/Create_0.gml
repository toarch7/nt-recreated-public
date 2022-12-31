raddrop = 2
max_hp = 2
meleedamage = 1
size = 0

spr_idle = sprRadMaggot
spr_walk = sprRadMaggot
spr_hurt = sprRadMaggotHurt
spr_dead = sprRadMaggotDead

event_inherited()

//behavior
alarm[1] = 10 + random(10)

spr_shadow = shd16