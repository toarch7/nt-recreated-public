if lockstep_stop
	exit

#region Camera focus on selected characters:
	
	var _pinst = scr_playerinstance_find()
	
	race = _pinst.race
	
	var _char = char[0]
	
	if array_length(char) > race {
	    _char = char[race]
	}
	
	if instance_exists(_char) {
		with _char {
		    view_xview = t_lerp(view_xview, x - view_width / 2, 0.1)
		    view_yview = t_lerp(view_yview, y - view_height / 2, 0.1)
		}
	}
	
	scr_camera_set_position(view_xview, view_yview)
	
#endregion

depth = UberCont.depth + 1