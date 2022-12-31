if sprite_index = sprShielderShieldDisappear {
    instance_destroy()
    with Shielder alarm[1] += 20
} else {
    image_index = 4
    image_speed = 0
}