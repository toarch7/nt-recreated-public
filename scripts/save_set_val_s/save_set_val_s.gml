/// @description save_get_val_s(section,key,def)
/// @param section
/// @param key
/// @param val
function save_get_val_s(section, key, val) {
	// save_get_val_s - save_get_val_s[et]
	
	var k = section + "_" + key,
		r = UberCont.saveData[? k]
	
	if r == undefined {
		UberCont.saveData[? k] = val
		
		return val
	}
	
	return r
}