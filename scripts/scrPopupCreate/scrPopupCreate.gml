/// @function scrPopupCreate
/// @param x
/// @param y
/// @param text
function scrPopupCreate(_x, _y, _text) {
	with instance_create(_x, _y, PopupText) {
		mytext = _text
		return id
	}
	
	return noone
}