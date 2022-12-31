image_angle = random(360)
alarm[0] = 150 + random(30)
motion_add(random(360), 1.8 + random(1.2))
vspeed -= 1.2 - random(0.3)
fall = 40 + random(30)
rot = random(6) - 3
image_speed = 0.4

move_contact_solid(direction, random(speed + 1))

hp = 0
max_hp = 0
spr_shadow_y = 0