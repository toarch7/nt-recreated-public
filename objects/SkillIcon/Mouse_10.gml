if lockstep_stop
	exit

if scr_network_handle_event(ev_mouse, ev_mouse_enter)
	exit

if is_keyboard() && appeary == 0 {
    LevCont.splat = 1
    snd_play(sndHover)
	
	with SkillIcon
		selected = false
	
    selected = true
}