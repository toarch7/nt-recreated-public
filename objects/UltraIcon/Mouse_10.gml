if lockstep_stop
	exit

if scr_network_handle_event(ev_mouse, ev_mouse_enter)
	exit

if is_keyboard() {
    with (LevCont) splat = true
    snd_play(sndHover)
    selected = 1
}