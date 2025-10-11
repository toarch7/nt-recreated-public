/// @description save_delete_value(section,key,value)
/// @param section
/// @param key
function save_delete_value(_section, _key) {
	var _savedata_key = $"{_section}_{_key}"
	
	if ds_map_exists(UberCont.saveData, _savedata_key) {
		ds_map_delete(UberCont.saveData, _savedata_key)
	}
}