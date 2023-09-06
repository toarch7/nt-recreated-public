if lockstep_stop
	exit

if !instance_exists(Cinematic) {
    if x < view_xview + view_width - 20 && y < view_yview + view_height - 20 && x > view_xview + 20 && y > view_yview + 20 {
        if transtime > 30 && spr_idle == sprDeskIdle {
            alarm[2] = 12
            alarm[3] = 8
            spr_idle = sprDeskIdleTrans
            image_index = 0
            sprite_index = spr_idle
        }

        transtime++
    }
} else {
    if sprite_index == sprDeskIdleTurn && image_index + image_speed >= sprite_get_number(sprite_index) - 1 {
        image_speed = 0
        image_index = 5

        sprite_index = sprDeskIdleTurn
    }
}