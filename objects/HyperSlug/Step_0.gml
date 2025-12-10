image_angle = direction

if speed < 6 && sprite_index != spr_fade {
	spr_fade = sprSlugDisappear
    sprite_index = spr_fade
    image_index = 0
    image_speed = 0.4
}