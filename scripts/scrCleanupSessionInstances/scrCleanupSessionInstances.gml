function scrCleanupSessionInstances() {
	with all {
	    if (object_index == UberCont
			|| object_index == CoopController
			|| object_index == Console
		) {
			continue
		}
		
		instance_destroy(id, false)
	}
}