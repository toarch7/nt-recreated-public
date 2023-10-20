raddrop = 3
max_hp = 12
meleedamage = 3
size = 2

spr_idle = sprCrabIdle
spr_walk = sprCrabWalk
spr_hurt = sprCrabHurt
spr_dead = sprCrabDead
spr_fire = sprCrabFire

event_inherited()

snd_hurt = sndOasisHurt
snd_dead = sndOasisDeath
snd_mele = sndOasisMelee

//behavior
ammo = 8
walk = 0
gunangle = random_angle
alarm[1] = 50 + random(90)

spr_shadow = shd48