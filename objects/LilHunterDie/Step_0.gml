instance_create(x, y, Smoke)
image_angle = (direction - 90)
if (bounces <= 3) {
    if (speed < 6) speed += 2
    speed += 0.05
    direction += trn
    trn += (random(1) - 0.5)
} else direction += 59