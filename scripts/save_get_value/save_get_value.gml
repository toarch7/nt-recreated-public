/// @function save_get_value
/// @param section
/// @param key
/// @param default=undefined
function save_get_value(_section, _key, _default = undefined) {
	return UberCont.saveData[? string(_section) + "_" + string(_key)] ?? _default
}