raddrop = 20
max_hp = 160
meleedamage = 6
size = 5
maxspeed = 2

z = 0
zspeed = 0
leap = 0
jumpdir = 0
jumpdist = 0
bounced = 0

spr_idle = sprDogGuardianWalk
spr_walk = sprDogGuardianWalk
spr_hurt = sprDogGuardianHurt
spr_dead = sprDogGuardianDead

event_inherited()

snd_hurt = sndDogGuardianHurt
snd_dead = sndDogGuardianDead
snd_mele = sndDogGuardianMelee

direction = random_angle

//behavior
gunangle = random_angle
alarm[1] = 120 + random(10)
walk = 0

spr_shadow = shd64
//spr_shadow_y = 7

image_speed = 0.4