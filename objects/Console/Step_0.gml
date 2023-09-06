if lockstep_stop
	exit

if !UberCont.opt_console exit

if UberCont.daily_run or UberCont.weekly_run or UberCont.continued_run exit

if bound_command != "" {
    if keyboard_check_pressed(ord("P")) {
        handle_console_command(bound_command)
    }

    if mouse_check_button_pressed(mb_right) {
        bound_command = ""
        print("Bind removed.")
    }
}

if key_check("console", keystate_press) or open {
    global.console_active = !global.console_active

    event_user(0)

    keyboard_string = ""

    open = 0
}

if keyboard_check_pressed(vk_escape) or (os_type == os_android && keyboard_check_pressed(vk_backspace)) or (keyboard_string == "" && keyboard_check_pressed(vk_enter)) {
    global.console_active = 0

    event_user(0)
}

if (flags & 2) == 2 && instance_exists(GenCont) {
    var iter = 0

    do {
        with FloorMaker
			event_perform(ev_step, 0)

        iter ++

        if iter >= 100
			break
    } until instance_number(Floor) >= GenCont.goal
}

if !global.console_active exit

if array_length(history) {
    if keyboard_check_pressed(vk_up) {
        historypos--

        if historypos < 0 {
            historypos = array_length(history) - 1
        }

        keyboard_string = history[historypos]
    }
	else if keyboard_check_pressed(vk_down) {
        historypos++

        if historypos >= array_length(history) {
            historypos = 0
        }

        keyboard_string = history[historypos]
    }
}

if keyboard_check(vk_control) && keyboard_check_pressed(ord("V")) {
    keyboard_string += clipboard_get_text()
}

if keyboard_check_pressed(vk_enter) && string_length(keyboard_string) {
    if laststr != keyboard_string {
        array_push(history, keyboard_string)
        laststr = keyboard_string
    }

    if handle_console_command(keyboard_string) {
        printc(keyboard_string, c_gray)
    }
	else printc(keyboard_string, c_white - 1)

    keyboard_string = ""

    historypos = -1
}