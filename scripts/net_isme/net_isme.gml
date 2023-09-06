function net_isme() {
	// global.index may vary in certain situations
	
	if instance_exists(CoopController)
		return global.index == CoopController.index
	
	return 1
}