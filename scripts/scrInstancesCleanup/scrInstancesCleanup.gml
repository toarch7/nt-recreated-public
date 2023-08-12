function scrInstancesCleanup() {
	with all {
	    if object_index != UberCont && object_index != Console && object_index != CoopController
			instance_destroy(id, 0)
	}
}