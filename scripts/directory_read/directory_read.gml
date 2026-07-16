/// @function directory_read
/// @param file_mask
/// @param attributes=fa_none
function directory_read(_mask, _attr = fa_none) {
	var _find = file_find_first(_mask, _attr), _result = [];
	
	while (_find != "") {
		array_push(_result, _find)
		_find = file_find_next()
	}
	
	file_find_close()
	
	return _result
}