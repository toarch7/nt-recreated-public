/// @function print_error
/// @param error_message
/// @param can_repeat=false
function print_error(_text, _can_repeat = false) {
	if self[$ "__print_error_shown"] == undefined || _can_repeat {
        KeyCont.press_paus[global.index] = true
		
        show_message_async("Exception handled:\n\n" + _text)
        show_debug_message(_text)
		
        if !_can_repeat {
            self[$ "__print_error_shown"] = true
        }
    }
}

function print_exception(_title, _exception) {
	var _stacktrace = string_join_ext("\n", _exception.stacktrace),
		_message = $"{_title}\n\n{_exception.longMessage}\n\n{_stacktrace}"
	
	print(_message)
	
	show_message_async(_message)
	
	if (instance_exists(Player)) {
		with (UberCont) {
			if (!scrGameCanPause()) {
				want_pause = 2
			}
			else scrGamePause()
		}
	}
}