raddrop = 12
max_hp = 25
meleedamage = 1
size = 2

spr_idle = sprSalamanderIdle
spr_walk = sprSalamanderWalk
spr_hurt = sprSalamanderHurt
spr_dead = sprSalamanderDead
spr_fire = sprSalamanderFire

event_inherited()


snd_hurt = sndScorpionHit
snd_dead = sndScorpionDie
snd_mele = sndScorpionMelee

//behavior
ammo = 10
walk = 0
gunangle = random_angle
alarm[1] = 30 + random(90)

spr_shadow = shd32