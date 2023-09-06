if lockstep_stop
	exit

if sprite_index = sprCrownPedIdle and !place_meeting(x, y, CrownPickup) {
    sprite_index = sprCrownPedClose
    image_speed = 0.4
    image_index = 0
}

if instance_exists(CrownPickup) {
    x = CrownPickup.x
    y = CrownPickup.y
}