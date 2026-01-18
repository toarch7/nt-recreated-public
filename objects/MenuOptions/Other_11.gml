/// @description Draw wrapper
var _current_category = category

with (ResourcepackManager) {
	depth = other.depth - 1
}

// Draw
event_user(0)

if (!editing_mode) {
	with (UberCont) if (letterbox_frame != 0) {
		scrDrawLetterbox(letterbox_frame, true)
	}
}

#region Header

draw_align(fa_center, fa_middle)
var _name = loc("MainMenu:Settings", "SETTINGS")

if _current_category != OptionCategory.Main {
	var _main_options = options[OptionCategory.Main],
		_category = _current_category - 1
	
	if _category < array_length(_main_options) {
		var _opt = _main_options[_category]
		
		if (is_method(_opt.get_name)) {
			_name = method_execute(_opt.get_name, _opt)
		}
		else {
			_name = _opt.name
		}
	}
}

draw_text_bigname(gui_w div 2, 20, _name, c_uigray)
draw_align()

#endregion

if editing_mode && !UberCont.opt_gamepad {
	scrDrawMobileControls()
}