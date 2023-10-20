/// @description Die

if net_event(ev_other, ev_user0)
	exit

if instance_exists(BackButton) {
	with BackButton
		event_user(0)
}
else instance_destroy()

