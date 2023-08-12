if net_event(ev_mouse, ev_mouse_enter)
	exit

if is_keyboard() {
    LevCont.splat = 1
    snd_play(sndHover)
    selected = 1
}