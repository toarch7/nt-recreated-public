/// @function assert
/// @param value
/// @param [template]
/// @param ...
function assert(_value, _template = undefined) {
	if (_value) exit
	
	if (is_undefined(_template)) {
		show_error("Assertion error", true)
		exit
	}
	
	_template = string_replace_all(_template, "\\{", "&cvbr;")
	
	for(var i = 2; i < argument_count; i ++) {
		_template = string_replace(_template, "{" + string(i - 2) + "}", argument[i])
	}
	
	_template = string_replace_all(_template, "&cvbr;", "{")
	
	show_error("Assertion error: " + _template, true)
}