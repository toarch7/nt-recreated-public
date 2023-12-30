/// https://gist.github.com/ellraiser/308eff835695e39c10e2d13eed9b9490
function scr_check_steamdeck() {
	// get device info
	var info = os_get_info();
	
	if is_undefined(info[? "gl_vendor_string"])
	or is_undefined(info[? "gl_version_string"]) {
		ds_map_destroy(info)
		return false
	}
	
	var vendor = info[? "gl_vendor_string"] + " " + info[? "gl_version_string"]; 
	var renderer = info[? "gl_renderer_string"];
	var gamepad_index = -1;
	var is_steamdeck = false;
  
	// find the device for the deck
	var devices = gamepad_get_device_count();
	for (var i = 0; i < devices; i++;) {
		if (gamepad_is_connected(i)) {
			var desc = gamepad_get_description(i);
			// on steamdeck the gamepad is called "Valve Streaming Gamepad"
			// use this index as normal for your gamepad controls
			// there can be other "blank" devices picked up as well 
			if (desc != "" && string_pos("Valve", desc) != 0) {
				gamepad_index = i;
			}
		}
	}
    
	// on steamdeck the vendor + version should be like "AMD 4.6 Mesa 22.0.0"
	// on steamdeck the renderer should be like "AMD Custom GPU 0405 (LLVM 13.0.0, DRM 3.45, 5.13.0-valve)"
	if (string_pos("AMD", vendor) != 0 && string_pos("Mesa", vendor) != 0 &&
	string_pos("AMD", renderer) != 0 && string_pos("valve", renderer) != 0 &&
	gamepad_index >= 0) {
		is_steamdeck = true;
	}
	
	ds_map_destroy(info)
    
	// return vals
	return is_steamdeck
	/*
	return {
		is_steamdeck,
		gamepad_index
	}*/
}