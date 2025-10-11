/// @function instance_is
/// @param instance_id
/// @param object_index
function instance_is(_instance, _object_index) {
	return instance_exists(_instance) && (_instance.object_index == _object_index || object_is_ancestor(_instance.object_index, _object_index))
}