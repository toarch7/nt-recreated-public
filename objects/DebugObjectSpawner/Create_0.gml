if instance_number(object_index) > 1 {
	instance_destroy(instance_find(object_index, 0))
}

if !variable_global_exists("__spawner_object_names") {
	global.__spawner_object_names = {}
	
	array_foreach(asset_get_ids(asset_object), function(_object) {
		var _name = string_lower(object_get_name(_object))
		global.__spawner_object_names[$ _name] = _object
	})
	
	global.__spawner_object_names[$ "wep"] = WepPickup
}

object_names = global.__spawner_object_names

__get_object = function(_string) {
	var _object = object_names[$ string_lower(_string)]
	
	if (is_numeric(_object) && object_exists(_object)) return _object
	
	return -1
}

splatindex = 0
last_input = current_time
keyboard_string = ""
cursor = ""
press = false
shake = 0
