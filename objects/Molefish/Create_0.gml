raddrop = 3
max_hp = 6
meleedamage = 0
size = 1

spr_idle = sprMolefishIdle
spr_walk = sprMolefishWalk
spr_hurt = sprMolefishHurt
spr_dead = sprMolefishDead

event_inherited()

snd_hurt = sndMolefishHurt
snd_dead = sndMolefishDead

//behavior
walk = 0
gunangle = random_angle
alarm[1] = 30 + random(90)
wkick = 0

move_contact_solid(random_angle, random(16))