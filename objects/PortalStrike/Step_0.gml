if instance_exists(creator) {
    if visible {
        if UberCont.opt_keyboard {
            if mouse_check_button(mb_right) {
                direction = point_direction(x, y, mouse_x, mouse_y)
            } else if visible {
                visible = 0
                alarm[0] = 3
                snd_play(snd)
                snd_stop(sndPortalStrikeLoop)
            }
        } else if UberCont.opt_gamepad {
            direction = point_direction(0, 0, gamepad_axis_value(0, gp_axisrh), gamepad_axis_value(0, gp_axisrv))
        } else if ButtonActive.rogue_bombing {
            if device_mouse_check_button(touch, mb_left) {
                direction = point_direction(x, y, device_mouse_x(touch), device_mouse_y(touch))
            } else {
                touch = -1
            }
        }
    }

    if instance_exists(ButtonActive) && !UberCont.opt_keyboard && !UberCont.opt_gamepad && ButtonActive.rogue_bombing {
        if touch == -1 {
            if visible {
                visible = 0
                alarm[0] = 3
                snd_play(snd)
                snd_stop(sndPortalStrikeLoop)
            }

            ButtonActive.rogue_bombing = 0
        }
    } else if (UberCont.opt_keyboard or UberCont.opt_gamepad) && KeyCont.release_spec[creator.index] {
        if visible {
            visible = 0
            alarm[0] = 3
            snd_play(snd)
            snd_stop(sndPortalStrikeLoop)
        }
    }
} else instance_destroy()

image_angle = direction