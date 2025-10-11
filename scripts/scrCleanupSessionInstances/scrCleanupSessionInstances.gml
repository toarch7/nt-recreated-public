function scrCleanupSessionInstances() {
	with all {
	    if object_index == UberCont || object_index == Console || object_index == CoopController
			continue
		
		instance_destroy(id, 0)
	}
}