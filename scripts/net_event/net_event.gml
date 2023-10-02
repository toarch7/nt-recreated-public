function net_event(type, num) {
	// return true  if event was queued to netevents
	// return false if is running net event
	
	if instance_exists(CoopController) {
		if !CoopController.event_run {
			ds_stack_push(CoopController.event_stack, [ net_index, object_index, type, num ])
			
			return true
		}
		
		return false
	}
	
	return false
}