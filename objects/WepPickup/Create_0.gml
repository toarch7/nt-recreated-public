image_angle = random_angle
image_speed = 0
friction = 0.4
motion_add(random_angle, 0.5 + random(1))

rotspeed = (random(1) + 1) * choose(1, - 1)

name = "REVOLVER"
wep = 1
type = 1
ammo = 0

creator = noone

curse = 0

team = 2

dropseed = rng_next_int(RNGSlot.Drops)