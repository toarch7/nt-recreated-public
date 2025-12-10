if lockstep_stop
	exit

image_angle = direction


if speed < 6 && sprite_index != sprSlugDisappear && sprite_index != sprSlugHit {
	spr_fade = sprSlugDisappear
    sprite_index = spr_fade
    image_index = 0
    image_speed = 0.4
}