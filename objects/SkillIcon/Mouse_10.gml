if lockstep_stop
	exit

if net_event(ev_mouse, ev_mouse_enter)
	exit

if is_keyboard() && appeary == 0 {
    LevCont.splat = 1
    snd_play(sndHover)
	
	with SkillIcon
		selected = false
	
    selected = true
}