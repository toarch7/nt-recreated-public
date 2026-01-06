/// @function scr_string_try_parse_const
/// @param {String} string_value
function scr_string_try_parse_const(_input) {
	if (is_undefined(_input))
		return undefined
	
	if (is_string(_input)) {
		switch (_input) {
			case "true":
				return true
			case "false":
				return false
			case "undefined":
				return undefined
			case "infinity":
				return infinity
		}
		
		var _asset = asset_get_index(_input)
		
		if (asset_get_type(_asset) == asset_unknown) {
			try {
				return real(_input)
			}
			catch(e) {
				return _input
			}
		}
		
		return _asset
	}
	
	return _input
}
