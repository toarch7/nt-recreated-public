raddrop = 8
max_hp = 25
meleedamage = 2
size = 2

spr_idle = sprJockIdle
spr_walk = sprJockWalk
spr_hurt = sprJockHurt
spr_dead = sprJockDead
spr_fire = sprJockFire

event_inherited()

snd_hurt = sndBanditHit
snd_dead = sndBanditDie

spr_shadow = shd32

//behavior
walk = 0
gunangle = random(360)
alarm[1] = 30 + random(90)
wkick = 0
ammo = 5