if lockstep_stop
	exit

image_angle = direction
if ((speed < 6) && (sprite_index != sprHeavySlugDisappear)) {
    spr_fade = sprHeavySlugDisappear
    sprite_index = spr_fade
	image_index = 0
    image_speed = 0.4
}