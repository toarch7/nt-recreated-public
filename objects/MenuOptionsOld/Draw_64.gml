if lockstep_stop
	exit

with ResourcepackManager
depth = other.depth - 1

// Draw menu itself
event_user(0)

if editing_mode && !UberCont.opt_gamepad {
    scrDrawMobileControls()
}

with BackButton
draw_self()