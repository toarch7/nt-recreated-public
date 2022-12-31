raddrop = 6
max_hp = 14
meleedamage = 0
size = 1

spr_idle = sprMolesargeIdle
spr_walk = sprMolesargeWalk
spr_hurt = sprMolesargeHurt
spr_dead = sprMolesargeDead

event_inherited()

snd_hurt = sndMolesargeHurt
snd_dead = sndMolesargeDead

//behavior
walk = 0
gunangle = random(360)
alarm[1] = 30 + random(90)
wkick = 0

move_contact_solid(random(360), random(16))