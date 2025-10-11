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