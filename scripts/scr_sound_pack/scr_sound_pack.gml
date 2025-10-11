/// @function scr_sound_pack
/// @param sound_suffix
/// @param variants
/// @return {Array<Asset.GMSound>}
function scr_sound_pack(_name, _count) {
	static __cache = {}
	
	if variable_struct_exists(__cache, _name) return __cache[$ _name]
	
	var _list = array_create(_count, -1)
	
	for(var i = 0; i < _count; i ++) {
		var _asset = $"snd{_name}{i + 1}"
		_list[i] = asset_get_index(_asset)
	}
	
	__cache[$ _name] = _list
	
	return _list
}