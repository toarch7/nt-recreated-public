image_angle = direction

if speed < 6 && sprite_index != spr_fade {
    sprite_index = spr_fade
    image_speed = 0.4
    image_index = 0
}