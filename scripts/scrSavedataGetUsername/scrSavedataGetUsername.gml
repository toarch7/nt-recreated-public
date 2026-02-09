function scrSavedataGetUsername() {
	return string(save_get_value("etc", "name", "null"))
}

function scrSavedataGetUID() {
	return string(save_get_value("general", "uid", "-1"))
}