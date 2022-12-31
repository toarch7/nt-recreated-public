image_angle = random(360)
motion_add(random(360), random(1.5) + 0.2)
friction = 0.01
image_speed = 0
image_index = random(5)

image_xscale = 0.6
image_yscale = 0.6
rot = (1 + random(3)) * choose(1, - 1)
growspeed = 0.003 + random(0.002)

team = 0
typ = 2

instance_change(ToxicGas, false)
instance_create(x, y, SuperFrog)