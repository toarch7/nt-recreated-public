if lockstep_stop
	exit

if random(3) < 1 {
    with instance_create(x, y, Smoke)
    motion_add(random_angle, random(2))
}

if speed = 0 instance_destroy()

image_speed = speed / 12