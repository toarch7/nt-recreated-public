image_angle = direction


if speed < 6 and sprite_index != sprSlugDisappear and sprite_index != sprSlugHit {
    sprite_index = sprSlugDisappear
    image_index = 0
    image_speed = 0.4
}