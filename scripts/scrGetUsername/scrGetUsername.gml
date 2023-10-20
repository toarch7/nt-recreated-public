function scrGetUsername() {
	return save_get_value("etc", "name", "unknown")
}

function scrGetUid() {
	return save_get_value("general", "uid", "-1")
}