function is_mobile(index = global.index) {
	return !KeyCont.gamepad[index] && !KeyCont.keyboard[index]
}