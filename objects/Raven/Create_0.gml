raddrop = 4
max_hp = 10
meleedamage = 0
size = 1

spr_idle = sprRavenIdle
spr_walk = sprRavenWalk
spr_hurt = sprRavenHurt
spr_dead = sprRavenDead

event_inherited()


snd_hurt = sndRavenHit
snd_dead = sndRavenDie

//behavior
walk = 0
gunangle = random_angle
alarm[1] = 30 + random(90)
wkick = 0
ammo = 3
z = 0
nofly = 30