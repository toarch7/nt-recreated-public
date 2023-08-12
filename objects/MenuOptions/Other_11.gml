/// @description Draw wrapper

with ResourcepackManager
	depth = other.depth - 1

// Draw
event_user(0)

if editing_mode && !UberCont.opt_gamepad
    scrDrawMobileControls()

