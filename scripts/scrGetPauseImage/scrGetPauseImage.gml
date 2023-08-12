function scrGetPauseImage() {
	instance_destroy(PauseImage)
	return instance_create(0, 0, PauseImage)
}