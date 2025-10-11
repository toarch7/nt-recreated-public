function scrGameIsGenerationScreen() {
	return instance_exists(GenCont) || instance_exists(MenuGen) || instance_exists(LevCont)
}