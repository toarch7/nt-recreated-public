if lockstep_stop
	exit

if scr_network_handle_event(ev_mouse, ev_mouse_enter)
	exit

if is_keyboard() && appeary == 0 {
    with (LevCont) splat = true
    snd_play(sndHover)
	
	if (!instance_exists(CoopController)) {
		var _nearest = instance_nearest(mouse_x, mouse_y, SkillIcon)
		with (SkillIcon) {
			selected = (_nearest == id)
		}
	}
	else {
		with (SkillIcon) {
			selected = false
		}
		selected = true
	}
}