function scrCanDrawCursor() {
	return UberCont.show_crosshair
		&& (is_desktop || UberCont.opt_keyboard)
		&& !(instance_exists(DebugObjectSpawner))
}