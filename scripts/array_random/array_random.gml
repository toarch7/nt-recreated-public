/// @function array_random
/// @param array
function array_random(_array) {
	var _length = array_length(_array)
	return _length ? _array[irandom(_length - 1)] : undefined
}