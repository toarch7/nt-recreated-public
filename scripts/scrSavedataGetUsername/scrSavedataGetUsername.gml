function scrSavedataGetUsername() {
	return string(save_get_value("etc", "name", "unknown"))
}

function scrSavedatascrGetUID() {
	return string(save_get_value("general", "uid", "-1"))
}