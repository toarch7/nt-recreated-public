/// @param angleSrc
/// @param angleDest
/// @param progress
function angle_lerp(a, b, c) {
	var r = a + angle_difference(b, a) * c
	
	if r < 0
		r += 360
	else if r >= 360
		r -= 360
	
	return r
}