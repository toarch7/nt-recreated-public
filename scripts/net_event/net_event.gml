function net_event(type, num) {
	if instance_exists(CoopController) {
		if !CoopController.event_run {
			ds_stack_push(CoopController.event_stack, [ net_index, object_index, type, num ])
			
			return 1
		}
		
		return 0
	}
	
	return 0
}