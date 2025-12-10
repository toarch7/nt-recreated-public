if lockstep_stop
	exit

if scr_network_handle_event(ev_mouse, ev_left_press)
	exit

if selected {
    event_user(0)
}
else {
    with (LevCont) splat = true

    with UltraIcon {
        selected = (id == other.id)
    }
}