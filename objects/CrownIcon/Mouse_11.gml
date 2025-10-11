if lockstep_stop
	exit

if scr_network_handle_event(ev_mouse, ev_mouse_leave)
	exit

if is_keyboard() {
    selected = 0
}