if (instance_exists(Logo) || !visible) {
	visible = false
	exit
}

alarm[0] = 180
show ++

if show >= 3 && show <= 8 {
    with instance_create(
		view_xview_center,
		view_yview_center,
		SpiralDebris
	) {
        depth = -10000
        image_index = other.show - 3
        sprite_index = sprCreditsTeam
        image_speed = 0
        visible = true
    }
}
	
if (show >= array_length(credittext)) {
    with instance_create(0, 0, Logo) {
        image_index = 7
        alarm[0] = -1
        alarm[1] = -1
    }

    alarm[0] = -1
}
else if (credittext[show] == "") {
    alarm[0] = 30
}