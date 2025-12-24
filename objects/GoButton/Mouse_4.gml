if lockstep_stop
	exit

if scr_network_handle_event(ev_mouse, ev_left_press)
	exit

if (visible) with CharSelect {
	if (selected) scrRunStart()
}