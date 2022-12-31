if instance_exists(creator) {
    with creator {
        x = other.x
        y = other.y
    }
} else if sprite_index != sprShielderShieldDisappear {
    sprite_index = sprShielderShieldDisappear
    image_speed = 0.4
    image_index = 0
}