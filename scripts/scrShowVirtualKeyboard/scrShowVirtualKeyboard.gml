/// @function scrShowVirtualKeyboard
/// @param kbv_type=kbv_type_default
function scrShowVirtualKeyboard(_kbv_type = kbv_type_default) {
	keyboard_virtual_show(
		kbv_type_default,
		kbv_returnkey_default,
		kbv_autocapitalize_none,
		kbv_returnkey_google
	)
}