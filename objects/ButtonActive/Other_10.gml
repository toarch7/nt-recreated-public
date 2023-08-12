event_inherited()

index = get_nearest_touch(rad)

var player = noone

with Player
if index == global.index player = id

var forever = KeyCont.activeforever[global.index]

KeyCont.hold_spec[global.index] = 0
KeyCont.press_spec[global.index] = 0
KeyCont.release_spec[global.index] = 0

if !player exit

if index != -1 or (do_thing == 1) {
    if device_mouse_check_button_pressed(index, mb_left) or (do_thing == 1) {
        if player.race == 3 or player.race == 4 or player.race == 6 or player.race == 7 or player.race == 11 {
            forever = !forever
            KeyCont.activeforever[global.index] = forever
        }
    }
}

if forever {
    if player.race == 3 {
        KeyCont.hold_spec[global.index] = 1
    }

    if player.race == 4 {
        KeyCont.press_spec[global.index] = 1
    }

    if player.race == 7 {
        KeyCont.hold_spec[global.index] = KeyCont.hold_fire[global.index]
    }

    if player.race == 11 && KeyCont.hold_fire[global.index] {
        KeyCont.hold_spec[global.index] = 1
    }
} else if ((UberCont.opt_keyboard or UberCont.opt_gamepad) or player.race != 7) {
    KeyCont.hold_spec[global.index] = (do_thing == 2) or (index != -1 && device_mouse_check_button(index, mb_left))
    KeyCont.press_spec[global.index] = (do_thing == 1) or (index != -1 && device_mouse_check_button_pressed(index, mb_left))
    KeyCont.release_spec[global.index] = (do_thing == -1) or (index != -1 && device_mouse_check_button_released(index, mb_left))
}

if do_thing {
    do_thing = 2
} else do_thing = 0