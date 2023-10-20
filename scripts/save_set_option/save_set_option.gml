/// @description save_get_option(section,key,def)
/// @param section
/// @param key
/// @param val
function save_get_option(section, key, val) {
	// save_get_option - save_get_option[et]
	
	var k = section + "_" + key,
		r = UberCont.saveData[? k]
	
	if r == undefined {
		UberCont.saveData[? k] = val
		
		return val
	}
	
	return r
}