/// @function scrFirstFrameAnim
/// @param image_speed
function scrFirstFrameAnim(_image_speed) {
	gml_pragma("forceinline")
	image_index += (image_index < 1) ? random(_image_speed * 0.05) : _image_speed
}