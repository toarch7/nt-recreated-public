/// @function load_custom_generic_area_colors
/// @param colors_file_path
/// @param area_color_struct
/// @param color_kind_name
function load_custom_generic_area_colors(_colors_file_path, _colors_struct, _kind) {
    var _ctx = {
		_load_errors: 0, _colors_struct, _kind
	}

    try {
		var _struct = json_parse(file_read(_colors_file_path))
		
		with (_ctx) struct_foreach(_struct, function(_key, _value) {
			if (is_string(_value)
				&& string_char_at(_value, 1) == "#"
				&& string_length(_value) == 7
			) {
				_value = [
					scrReal("0x" + string_copy(_value, 2, 2)) & 0xff,
					scrReal("0x" + string_copy(_value, 4, 2)) & 0xff,
					scrReal("0x" + string_copy(_value, 6, 2)) & 0xff
				]
			}
			
			if (is_array(_value)) {
				if (!variable_struct_exists(_colors_struct, _key)) {
					_colors_struct[$ _key] = _value
				}
				else {
					print($"Custom {_kind} color for area", _key, "is already defined")
				}
			}
			else {
				var _str = string(_value)
				
				if (string_length(_str) > 30) {
					_str = string_copy(_str, 1, 27) + "..."
				}
				
				scr_log_push($"[!!!] Invalid {_kind} color value \"{_str}\"", c_red)
				_load_errors ++
			}
		})
    }
	catch (e) {
		scr_log_push($"[!!!] Failed to load custom {_ctx._kind} colors: {e.message}", c_red)
		_ctx._load_errors ++
    }

    return _ctx._load_errors
}