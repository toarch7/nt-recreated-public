if net_event(ev_mouse, ev_left_press)
	exit

if selected {
    event_user(0)
}
else {
    LevCont.splat = 1
    snd_play(sndMenuSelect)
    
	with SkillIcon {
		selected = (id == other.id)
	}
}