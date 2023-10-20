raddrop = 8
max_hp = 7
meleedamage = 0
size = 1

spr_idle = sprMeleeIdle
spr_walk = sprMeleeWalk
spr_hurt = sprMeleeHurt
spr_dead = sprMeleeDead

event_inherited()

snd_hurt = sndAssassinHit
snd_dead = sndAssassinDie

//behavior
walk = 0
gunangle = random_angle
alarm[1] = 90 + random(90)
wepangle = choose(-140, 140)
wepflip = 1