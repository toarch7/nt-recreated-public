if lockstep_stop
	exit

image_angle = direction


if speed < 6 and sprite_index != sprPopoSlugDisappear {
    sprite_index = sprPopoSlugDisappear
    image_index = 0
    image_speed = 0.4
}