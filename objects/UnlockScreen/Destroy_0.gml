with (instance_find(UnlockScreen, 1)) {
	if (!visible) event_perform(ev_alarm, 0)
}