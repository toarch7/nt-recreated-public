name = "SCREWDRIVER"
wep = Wep.Revolver
type = Ammo.None
ammo = false
creator = noone
curse = false
team = 2

dropseed = rng_next_int(RNGStates.Drops)
rotspeed = (random(1) + 1) * choose(1, - 1)

image_angle = random_angle
image_speed = 0
friction = 0.4

motion_add(random_angle, 0.5 + random(1))