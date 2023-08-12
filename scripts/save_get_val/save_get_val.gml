function save_get_val(section, key, def = undefined) {
	return UberCont.saveData[? section + "_" + key] ?? def
}