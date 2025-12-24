function scrGameIsLockState() {
	return scrGameIsGenerationScreen() || room == romInit || instance_exists(Cinematic) || (instance_exists(SitDown) && (SitDown.sit || SitDown.force_sit))
}