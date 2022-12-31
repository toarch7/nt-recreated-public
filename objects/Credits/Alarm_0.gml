if !visible && !instance_exists(Logo) exit

if !instance_exists(Logo) {
    alarm[0] = 180
    show++

    if show >= 3 && show <= 8 {
        with instance_create(view_xview + view_width / 2, view_yview + view_height / 2, SpiralDebris) {
            depth = -100000
            sprite_index = sprCreditsTeam
            image_speed = 0
            visible = 1
            image_index = other.show - 3
        }
    }

    if show == 11 {
        with instance_create(view_xview + view_width / 2, view_yview + view_height / 2, SpiralDebris) {
            depth = -100000
            sprite_index = sprMutant11Hurt
            image_speed = 0
            image_index = 1
            visible = 1
        }
    }

    if show >= array_length(credittext) {
        with instance_create(0, 0, Logo) {
            image_index = 7
            alarm[0] = -1
            alarm[1] = -1
        }

        alarm[0] = -1
    } else if credittext[show] == "" {
        alarm[0] = 30
    }
} else visible = 0