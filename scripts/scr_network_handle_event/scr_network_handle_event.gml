function scr_network_handle_event(_event_type, _event_number) {
	// returns `true` if event was queued to netevents and
	// `false` if the event is currently being ran by the network controller
	
	with CoopController {
		if (started) {
			if (event_run) return false
			
			ds_stack_push(event_stack, [
				other.netid, other.object_index, _event_type, _event_number
			])
			
			return true
		}
	}
	
	return false
}