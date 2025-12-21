if lockstep_stop
	exit

if alarm[0] > 0 {
    if instance_exists(creator) {
        creator.x = x
        creator.y = y
    }
}
else if sprite_index != sprEliteShielderShieldDisappear {
    sprite_index = sprEliteShielderShieldDisappear
    image_speed = 0.4
    image_index = 0
}