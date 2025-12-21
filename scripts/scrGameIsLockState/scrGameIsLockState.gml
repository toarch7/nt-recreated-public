function scrGameIsLockState() {
	return instance_exists(Cinematic) || scrGameIsGenerationScreen() || (instance_exists(SitDown) && (SitDown.sit || SitDown.force_sit))
}