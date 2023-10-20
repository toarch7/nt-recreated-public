raddrop = 8
max_hp = 6
meleedamage = 0
size = 1

spr_idle = sprNecromancerIdle
spr_walk = sprNecromancerWalk
spr_hurt = sprNecromancerHurt
spr_dead = sprNecromancerDead

event_inherited()

snd_hurt = sndNecromancerHurt
snd_dead = sndNecromancerDead


//behavior
walk = 0
gunangle = random_angle
alarm[1] = 30 + random(90)
wkick = 0