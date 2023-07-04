function scrGetPauseImage() {
	instance_destroy(GetPauseImage)
	return instance_create(0, 0, GetPauseImage)
}