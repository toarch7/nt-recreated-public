event_inherited()
typ = 2

image_speed = 0.3 + random(0.2)
image_angle = random_angle
friction = 0.15

projectile_direction_changes_angle = false

if GameCont.underwater {
	instance_create(x, y, Bubble)
	instance_destroy()
}

damage = 2