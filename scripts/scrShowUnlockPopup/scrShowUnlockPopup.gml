/// @function scrShowUnlockPopup
/// @param message
function scrShowUnlockPopup(_message) {
    with UberCont {
        unlock_text = loc(_message)
        draw_unlock = true
        alarm[1] = 90
    }
}