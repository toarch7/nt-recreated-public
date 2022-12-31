raddrop = 12
max_hp = 30
meleedamage = 0
size = 1

spr_idle = sprBuffGatorIdle
spr_walk = sprBuffGatorWalk
spr_hurt = sprBuffGatorHurt
spr_dead = sprBuffGatorDead

event_inherited()


snd_hurt = sndGatorHit
snd_dead = sndGatorDie

//behavior
walk = 0
gunangle = random(360)
alarm[1] = 30 + random(90)
wkick = 0