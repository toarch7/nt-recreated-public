raddrop = 10
max_hp = 40
meleedamage = 5
size = 1

spr_idle = sprFlyIdle
spr_walk = sprFlyWalk
spr_hurt = sprFlyHurt
spr_dead = sprFlyDead

event_inherited()

snd_hurt = sndFlyHurt
snd_dead = sndFlyDead

//behavior
walk = 0
gunangle = random(360)
ammo = 3
fire = 10
alarm[1] = 50 + random(10)
rage = 0