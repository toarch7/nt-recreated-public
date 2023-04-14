function net_add_data() {
	if instance_exists(CoopController) {
		var arr = []
		
		for(var i = 0; i < argument_count; i ++) {
			arr[i] = argument[i]
		}
		
		ds_stack_push(CoopController.event_stack, arr)
		
		return 1
	}
	
	return 0
}