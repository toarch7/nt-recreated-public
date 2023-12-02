raddrop = 10
max_hp = 40
meleedamage = 5
size = 1

spr_idle = sprJungleFlyIdle
spr_walk = sprJungleFlyWalk
spr_hurt = sprJungleFlyHurt
spr_dead = sprJungleFlyDead

event_inherited()

snd_hurt = sndFlyHurt
snd_dead = sndFlyDead

//behavior
walk = 0
gunangle = random_angle
ammo = 3
fire = 10
alarm[1] = 50 + random(10)
rage = 0