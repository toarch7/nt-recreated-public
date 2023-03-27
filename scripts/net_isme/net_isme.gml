function net_isme() {
	if instance_exists(CoopController)
		return global.index == CoopController.index
	
	return 1
}