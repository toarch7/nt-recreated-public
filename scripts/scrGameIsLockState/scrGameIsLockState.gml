function scrGameIsLockState() {
	if instance_exists(Cinematic) || scrGameIsGenerationScreen() || (instance_exists(SitDown) && SitDown.sit)
		return true
	
	return false
}