/// @description scrAreaGetMapName
/// @param area
/// @param subarea
/// @param loop
/// @param is_hardmode
function scrAreaGetMapName(_area, _subarea, _loop, _is_hardmode=undefined) {
    var _area_string = "?",
		_subarea_string = "?",
		_loop_string = ""
	
	if (is_undefined(_is_hardmode)) _is_hardmode = scrGameIsHardmode()
	
    if _area == area_hq {
        _area_string = "HQ"
        _subarea_string = string(_subarea)
    }
	else if _area == area_crib {
        _area_string = "$$$"
        _subarea_string = ""
    }
	// secret areas
	else if _area > 100 {
        _area_string = string(_area - 100)
        _subarea_string = "-?"
    }
	else if _area == area_vault {
        _area_string = "???"
        _subarea_string = ""
    }
	else {
        _area_string = string(_area)
        _subarea_string = "-" + string(_subarea)
    }

    if (instance_exists(GameCont) && GameCont.win) {
        _area_string = "END"
		
		// END1 - Throne
        if instance_exists(Cinematic) {
            _subarea_string = "1"
        }
		// END2 - HQ
		else if (GameCont.area == area_hq && GameCont.subarea == 3) {
            _subarea_string = "2"
        }

        _loop = 0
    }

    if _loop && _area_string != area_crib {
        _loop_string = (_is_hardmode ? " H" : " L") + string(_loop)
    }

    return _area_string + _subarea_string + _loop_string
}