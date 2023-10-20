function scrGetUsername() {
	return string(save_get_value("etc", "name", "unknown"))
}

function scrGetUid() {
	return string(save_get_value("general", "uid", "-1"))
}