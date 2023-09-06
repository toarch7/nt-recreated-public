if lockstep_stop
	exit

image_angle = direction


if speed < 6 and sprite_index != sprHyperSlugDisappear and sprite_index != sprSlugHit {
    sprite_index = sprHyperSlugDisappear
    image_index = 0
    image_speed = 0.4
}