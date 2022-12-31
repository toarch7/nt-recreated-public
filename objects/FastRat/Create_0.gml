raddrop = 0
max_hp = 4
meleedamage = 2
size = 1

spr_idle = sprFastRatIdle
spr_walk = sprFastRatWalk
spr_hurt = sprFastRatHurt
spr_dead = sprFastRatDead

event_inherited()


snd_hurt = sndFastRatHit
snd_dead = sndFastRatDie
snd_mele = sndFastRatMelee

//behavior
walk = 0
alarm[1] = 1 + random(90)

alarm[3] = 900
givekill = 0

snd_play(sndFastRatSpawn)