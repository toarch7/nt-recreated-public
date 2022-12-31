if want_pause && instance_exists(Player) && !instance_exists(GenCont) {
    want_pause = 0

    if !bossintro {
        scrMakePauseButtons()
    }

    with MobileUI
    index = -1

    instance_deactivate_all(1)
    instance_activate_object(BackCont)
    instance_activate_object(GameCont)
    instance_activate_object(TopCont)
    instance_activate_object(PauseButton)
    instance_activate_object(CoopController)
    instance_activate_object(MusCont)
    instance_activate_object(Console)

    with PauseButton {
        hover = 5
        visible = 1
        depth--
    }
}


KeyCont.press_horn[global.index] = 0

//if scrCanInput() {
if opt_gamepad {
    scrSetGamepadInputs(global.index)
} else if opt_keyboard {
    scrSetKeyboardInputs(global.index)

    if localcoop {
        scrSetGamepadInputs(1)
    }
} else { // mobil
    for (var i = 0; i < array_length(touch_duration); i++) {
        if device_mouse_check_button(i, mb_left) {
            touch_duration[i]++
        } else touch_duration[i] = 0
    }
}
//}

if volqueue != -1 && !ds_queue_empty(volqueue) {
    var a = ds_queue_dequeue(volqueue)
    scrHandleVolumeControl(a[0], a[1])
}

KeyCont.gamepad[global.index] = opt_gamepad
KeyCont.aimassist[global.index] = opt_assist