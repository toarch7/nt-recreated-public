/// @function scrFirstFrameAnim
/// @param anim_speed
function scrFirstFrameAnim(_image_speed) {
	gml_pragma("forceinline")
	
	if image_index < 1 {
	    image_index += random(_image_speed * 0.05)
	}
	else image_index += _image_speed
}