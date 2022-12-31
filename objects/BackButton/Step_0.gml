x = view_xview + 2
y = view_yview + 2

if gamepad_button_check_pressed(0, gpad.face2) {
    event_perform(ev_mouse, ev_left_press)
}

depth = -1000