/// @function scrShowUnlockPopup
/// @param line
/// @param line2
function scrShowUnlockPopup(_message, _bottom_text=undefined) {
    with UberCont {
        unlock_text = _message
		if (is_string(_bottom_text)) {
			unlock_text += "\n" + _bottom_text
		}
        draw_unlock = true
        alarm[1] = 90
    }
}