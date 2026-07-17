global.safemode = false

function scrGameSafemodeValidate() {
	var _has_resourcepacks = file_exists(".active_resourcepacks"),
		
		_has_savegame = file_exists(savegame_file),
		
		_is_this_thing_even_required = (_has_resourcepacks || _has_savegame),
		
		_safemode_file_name = ".safemode_check",
		_file_is_present = file_exists(_safemode_file_name)
	
	if (!_is_this_thing_even_required) {
		if (_file_is_present) {
			file_delete(_safemode_file_name)
		}
		global.safemode = false
		exit
	}
	
	if (_file_is_present) {
		var _footnote = "";
		
		if (_has_resourcepacks) {
			_footnote = "\n\nThe following resourcepacks were enabled:\n" + file_read(".active_resourcepacks")
		}
		
		show_message_async("It seems that the couldn't initialize properly on previous startup.\n"
			            + "Resourcepacks and Run Continuation screen will be disabled until the next restart."
						+ _footnote)
		
		global.safemode = true
	}
	else {
		file_write(".safemode_check", "")
	}
	
	call_after(
		2 * game_get_speed(gamespeed_fps),
		
		method({ file: _safemode_file_name }, function() {
			file_delete(file)
		}))
	
}