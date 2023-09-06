function scrGetUsername() {
	return save_get_val("etc", "name", "unknown")
}

function scrGetUid() {
	return save_get_val("general", "uid", "-1")
}