/// @function scrAreaGetName
/// @param area
/// @param macrolike_format
function scrAreaGetName(_area, _macrolike_format=false) {
	var _name;
	
	switch (_area) {
		case area_campfire: _name = "Campfire"; break
		case area_desert: _name = "Desert"; break
		case area_sewers: _name = "Sewers"; break
		case area_scrapyards: _name = "Scrapyards"; break
		case area_caves: _name = "Caves"; break
		case area_city: _name = "City"; break
		case area_labs: _name = "Labs"; break
		case area_palace: _name = "Palace"; break
		case area_vault: _name = "Vault"; break
		case area_oasis: _name = "Oasis"; break
		case area_pizza_sewers: _name = "Pizza Sewers"; break
		case area_mansion: _name = "Mansion"; break
		case area_cursed_caves: _name = "Cursed Caves"; break
		case area_jungle: _name = "Jungle"; break
		case area_hq: _name = "HQ"; break
		case area_crib: _name = "Crib"; break
		default: _name = "AREA" + string(_area)
	}
	
	if (_macrolike_format) {
		return string_replace_all(string_lower(_name), " ", "_")
	}
	
	return _name
}

/// @function scrAreaGetMaxSubarea
/// @param area
function scrAreaGetMaxSubarea(_area) {
	if (scrGameIsCustomMode() && _area < 100) {
		if (_area == area_hq) {
			return scrCustomParam("area_size")
		}
		
		return ((_area % 2 == 0) ? scrCustomParam("area_size_alt") : scrCustomParam("area_size"))
	}
	
	switch (_area) {
		case area_desert:
		case area_scrapyards:
		case area_city:
		case area_palace:
		case area_hq:
			return 3
	}
	
	return 1
}

/// @function scrAreaGetBackroundColor
/// @param area
/// @param check_custom=true
function scrAreaGetBackroundColor(_area, _check_custom=true) {
	if (_check_custom && is_struct(global.custom_area_colors)) {
		var _components = global.custom_area_colors[$ string(_area)]
		
		if (is_array(_components) && array_length(_components) >= 3) {
			return make_color_rgb(_components[0], _components[1], _components[2])
		}
	}
	
	switch (_area) {
		case area_campfire:     return #6a7aaf
		case area_desert:       return #af8f6a
		case area_sewers:       return #4c5946
		case area_scrapyards:   return #8a969e
		case area_caves:        return #8152bc
		case area_city:         return #b4bdc5
		case area_labs:         return #091c20
		case area_palace:       return #611d24
		case area_vault:        return #433523
		case area_oasis:        return #51d1c8
		case area_pizza_sewers: return #a04b63
		case area_mansion:      return #eef0f2
		case area_cursed_caves: return #ff9c23
		case area_jungle:       return #2a900c
		case area_hq:           return #f5fafb
		case area_crib:         return #eef0f2
	}
	
	return #6a7aaf
}

/// @function scrAreaGetShadowColor
/// @param area
/// @param check_custom=true
function scrAreaGetShadowColor(_area, _check_custom=true) {
	if (_check_custom && is_struct(global.custom_shadow_colors)) {
		var _components = global.custom_shadow_colors[$ string(_area)]
		
		if (is_array(_components) && array_length(_components) >= 3) {
			return make_color_rgb(_components[0], _components[1], _components[2])
		}
	}
	
	switch (_area) {
		case area_campfire:     return c_black
		case area_desert:       return c_black
		case area_sewers:       return #080d01
		case area_scrapyards:   return c_black
		case area_caves:        return #06020c
		case area_city:         return #0e1344
		case area_labs:         return c_black
		case area_palace:       return #0d0101
		case area_vault:        return #00030e
		case area_oasis:        return #012b43
		case area_pizza_sewers: return #090012
		case area_mansion:      return #120014
		case area_cursed_caves: return #420000
		case area_jungle:       return #140001
		case area_hq:           return #00248c
		case area_crib:         return #120014
	}
	
	return c_black
}

function scrAreaGetGenerationGoal() {
	with (GameCont) {
		if (area == area_vault) return 40
		if (area == area_campfire) return 60
		if (area == area_crib) return 20
		if (area == area_pizza_sewers) return 70
		if (area == area_palace) return (subarea == maxsubarea ? 420 : 130)
		if (area == area_mansion || area == area_oasis) return 130
		if (area == area_hq && subarea == maxsubarea) return 48
	}
	
	return 110
}

function scrAreaHasSafespawn() {
	with (GameCont) {
		if (area == area_campfire
			|| area == area_crib || area == area_vault
			|| (area == area_palace && subarea == maxsubarea)
			|| (area == area_hq && subarea == maxsubarea)
		) {
			return false
		}
	}
	
	return true
}

function scrAreaCanHavePopo() {
	with GameCont {
		if (area == area_vault || area == area_crib
			|| (area == area_hq && subarea == maxsubarea)
			|| (area == area_palace && subarea == maxsubarea)
		) {
			return false
		}
	}
	
	return true
}

/// @function scrAreaGetDifficulty
/// @param area
/// @param subarea
/// @param loops
function scrAreaGetDifficulty(_area, _subarea, _loops) {
	var _result = _subarea + _loops * 16
	
	_area = floor(_area % 100)
	
	for(var n = 1; n < _area; ++n) _result += scrAreaGetMaxSubarea(n)
	
	return _result
}