raddrop = 8
max_hp = 6
meleedamage = 0
size = 1

spr_idle = sprSniperIdle
spr_walk = sprSniperWalk
spr_hurt = sprSniperHurt
spr_dead = sprSniperDead

event_inherited()


snd_hurt = sndSniperHit

//behavior
walk = 0
gunangle = random_angle
alarm[1] = 60 + random(90)
gonnafire = 0
wkick = 0