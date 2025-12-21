if sprite_index == sprShielderShieldDisappear {
    with (Shielder) {
		alarm[1] += 20
	}
	instance_destroy()
    exit
}

image_index = image_number - 1
image_speed = 0