raddrop = 20
max_hp = 35
meleedamage = 0
size = 2

spr_idle = sprRatkingIdle
spr_walk = sprRatkingWalk
spr_hurt = sprRatkingHurt
spr_dead = sprRatkingDead
spr_fire = sprRatkingFire

event_inherited()


snd_hurt = sndRatKingHit
snd_dead = sndRatKingDie

//behavior
ammo = choose(3, 4, 5)
walk = 0
gunangle = random_angle
alarm[1] = 1 + random(90)

spawns = 0
mydir = 0

spr_shadow = shd32
spr_shadow_y = 4