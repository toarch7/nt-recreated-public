/// @description save_set_val(section,key,value)
/// @param section
/// @param key
/// @param value
function save_set_val(section, key, value) {
	UberCont.saveData[? section + "_" + key] = value
}