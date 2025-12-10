if lockstep_stop exit

if current_frame_active && random(3) < 1 {
    with (instance_create(x, y, Smoke)) speed ++
}

if speed == 0 instance_destroy()

image_speed = speed / 12

if (image_index + image_speed) >= 2 {
	image_index = 0
}