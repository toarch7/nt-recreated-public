event_inherited()
image_speed = 0.2 + random(0.1)
image_angle = random(360)
hit_id = -1
typ = 2 //0 = nothing, 1 = deflectable, 2 = destructable
team = 1

if GameCont.area == 101 instance_destroy()