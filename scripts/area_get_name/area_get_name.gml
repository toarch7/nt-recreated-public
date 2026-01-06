/// @description scrAreaGetMapName
/// @param area
/// @param subarea
/// @param loop
/// @param is_hardmode
function scrAreaGetMapName(_area, _subarea, _loop, _is_hardmode=undefined) {
    var _area_string = "",
		_subarea_string = undefined,
		_result = ""
	
	if (is_undefined(_is_hardmode)) _is_hardmode = scrGameIsHardmode()
	
    if _area == area_hq {
        _area_string = loc_fmt("Area:HQ", "HQ%", _subarea)
    }
	else if _area == area_crib {
        _area_string = loc("Area:Crib", "$$$")
    }
	// secret areas
	else if _area > 100 {
        _area_string = string(_area - 100)
		_subarea_string = ""
    }
	else if _area == area_vault {
        _area_string = loc("Area:Vault", "???")
    }
	else {
        _area_string = string(_area)
        _subarea_string = string(_subarea)
    }

    if (instance_exists(GameCont) && GameCont.win) {
        _area_string = "END"
		_subarea_string = undefined
		
		// END1 - Throne
        if instance_exists(Cinematic) {
            _area_string = loc("Area:End1", "END1")
        }
		// END2 - HQ
		else if (GameCont.area == area_hq && GameCont.subarea == GameCont.maxsubarea) {
			_area_string = loc("Area:End2", "END2")
        }
		
        _loop = 0
    }
	
	if (_area_string != "") {
		if (_subarea_string == undefined) {
			_result = _area_string
		}
		else if (_subarea_string != "") {
			_result = loc_fmt("Area:Base", "%1-%2", _area_string, _subarea_string)
		}
		else {
			_result = loc_fmt("Area:Secret", "%1-?", _area_string)
		}
	}
	
    if (_loop != 0) {
		return loc_fmt(_is_hardmode ? "Area:Hardmode" : "Area:Loop",
			$"%1 {(_is_hardmode ? "H" : "L")}%2", _result, _loop)
	}
	
    return _result
}