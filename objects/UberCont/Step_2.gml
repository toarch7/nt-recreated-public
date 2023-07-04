if opt_keyboard {
    var me = noone

    if instance_exists(Player) {
        with Player
			if is_me me = id

        if instance_exists(me) {
            KeyCont.dir_fire[global.index] = point_direction(me.x, me.y, mouse_x, mouse_y)
        }
    }
}

if opt_keyboard {
    if instance_exists(ParButton) {
        for (var i = 0; i < instance_number(ParButton); i++) {
            if i > 9
            break

            if keyboard_check_pressed(ord(string(i + 1))) {
                with instance_find(ParButton, i) {
                    selected = 1
                    event_perform(ev_mouse, ev_left_press)
                }

                break
            }
        }
    }
} else if opt_gamepad {
    scrGamepadUIControl()

    if gamepad_button_check(0, gp_start) {
        opt_gamepad = 1
    }
}

if os_type == os_android {
    var p = self[$ "_pause_old"] ?? 0

    if !opt_gamepad && save_get_val("controls", "volumecontrol", 1) {
        if p != paused {
            SetVolumeControl(!paused)
        }
    }

    self[$ "_pause_old"] = paused
}

KeyCont.crosshair[global.index] = opt_crosshair
