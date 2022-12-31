raddrop = 2
max_hp = 8
meleedamage = 2
size = 1

spr_idle = sprBoneFishIdle
spr_walk = sprBoneFishWalk
spr_hurt = sprBoneFishHurt
spr_dead = sprBoneFishDead

event_inherited()


snd_hurt = sndOasisHurt
snd_dead = sndOasisDeath
snd_mele = sndOasisMelee

//behavior
walk = 0
alarm[1] = 30 + random(90)