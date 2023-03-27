if net_event(ev_mouse, ev_left_press)
	exit

if isset("appeary") && appeary exit

if selected {
    event_user(0)
}
else {
    with CrownIcon {
		selected = (id == other.id)
	}
	
	LevCont.splat = 1
}