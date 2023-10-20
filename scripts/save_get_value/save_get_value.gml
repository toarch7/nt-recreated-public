function save_get_value(section, key, def = undefined) {
	return UberCont.saveData[? section + "_" + key] ?? def
}