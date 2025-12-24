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

/// @function scrAreaGetMaxSubareas
/// @param area
function scrAreaGetMaxSubareas(_area) {
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
function scrAreaGetBackroundColor(_area) {
	switch (_area) {
		case area_campfire: return #6a7aaf
		case area_desert: return #af8f6a
		case area_sewers: return #4c5946
		case area_scrapyards: return #8a969e
		case area_caves: return #8152bc
		case area_city: return #b4bdc5
		case area_labs: return #091c20
		case area_palace: return #611d24
		case area_vault: return #433523
		case area_oasis: return #51d1c8
		case area_pizza_sewers: return #a04b63
		case area_mansion: return #eef0f2
		case area_cursed_caves: return #ff9c23
		case area_jungle: return #2a900c
		case area_hq: return #f5fafb
		case area_crib: return #eef0f2
	}
	
	return #6a7aaf
}

function scrAreaGetGenerationGoal() {
	with (GameCont) {
		if (area == area_vault) return 40
		if (area == area_campfire) return 60
		if (area == area_crib) return 20
		if (area == area_pizza_sewers) return 70
		if (area == area_palace) return (subarea == 3 ? 420 : 130)
		if (area == area_mansion || area == area_oasis) return 130
		if (area == area_hq && subarea == 3) return 48
	}
	
	return 110
}

function scrAreaHasSafespawn() {
	with (GameCont) {
		if (area == area_campfire || area == area_crib || area == area_vault
			|| (area == area_palace && subarea == 3) || (area == area_hq && subarea == 3)
		) {
			return false
		}
	}
	
	return true
}

function scrAreaCanHavePopo() {
	with GameCont {
		if area == area_vault || area == area_crib || (area == area_hq && subarea == 3) || (area == 7 && subarea == 3)
			return false
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
	
	for(var n = 1; n < _area; ++n) _result += scrAreaGetMaxSubareas(n)
	
	return _result
}