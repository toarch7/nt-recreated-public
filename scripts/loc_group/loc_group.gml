// inspired by YellowAfterlife's cmnloc: https://yal.cc/cmn-loc/
#macro LF loc_group

function loc_group(_prefix) {
	static __cache = {}
	
	if (variable_struct_exists(__cache, _prefix)) return __cache[$ _prefix]
	
	var _m = method({
			prefix: string(_prefix) + ":"
		},
		function(_key, _default) {
			_key = prefix + string(_key)
			
			var _str = global.language_current[$ _key]
			
			if (!is_string(_str)) _str = (_default ?? _key)
			
			if (argument_count <= 2 || string_pos("%", _str) == 0) return _str
			
			var _format_argument_index = 2,
				_format_count = argument_count - _format_argument_index,
				_format_index = 0
			
			repeat _format_count {
				var _indexed = "%" + string(++_format_index)
				
				if (string_pos(_indexed, _str) != 0) {
					_str = string_replace_all(_str,
						_indexed, string(argument[_format_argument_index]))
				}
				else {
					_str = string_replace(_str,
						"%", string(argument[_format_argument_index]))
				}
				
				_format_argument_index ++
			}
			
			return _str
		})
	
	__cache[$ _prefix] = _m
	return _m
}

