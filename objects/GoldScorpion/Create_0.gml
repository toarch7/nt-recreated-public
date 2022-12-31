raddrop = 30
max_hp = 40
meleedamage = 5
size = 2

spr_idle = sprGoldScorpionIdle
spr_walk = sprGoldScorpionWalk
spr_hurt = sprGoldScorpionHurt
spr_dead = sprGoldScorpionDead
spr_fire = sprGoldScorpionFire

event_inherited()

snd_hurt = sndGoldScorpionHurt
snd_dead = sndGoldScorpionDead
snd_mele = sndGoldScorpionMelee

//behavior
ammo = 10
walk = 0
gunangle = random(360)
alarm[1] = 30 + random(90)

spr_shadow = shd32
spr_shadow_y = 4