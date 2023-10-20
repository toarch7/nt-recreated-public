raddrop = 8
meleedamage = 0
size = 1
image_speed = 0.4

spr_idle = sprGatorIdle
spr_walk = sprGatorWalk
spr_hurt = sprGatorHurt
spr_dead = sprGatorDead

//behavior
walk = 0
gunangle = random_angle
alarm[1] = 90 + random(90)
wepangle = choose(-140, 140)
wepflip = 1
instance_change(Gator, false)