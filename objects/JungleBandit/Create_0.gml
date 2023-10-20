raddrop = 2
max_hp = 4
meleedamage = 0
size = 1

spr_idle = sprJungleBanditIdle
spr_walk = sprJungleBanditWalk
spr_hurt = sprJungleBanditHurt
spr_dead = sprJungleBanditDead

event_inherited()

snd_hurt = sndBanditHit
snd_dead = sndBanditDie

//behavior
walk = 0
gunangle = random_angle
alarm[1] = 30 + random(90)
wkick = 0
ammo = 0