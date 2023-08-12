/// @description Downloading
if async_load[? "id"] == list_request {
	if async_load[? "status"] != 0
		exit
	
	var file = async_load[? "result"]
	
	if !file_exists(file) {
		error = "FAILED TO LOAD THE LIST"
		
		exit
	}
	
	print("File exists!??", file)
	
	items = json_parse(file_read(file))
	
	// filter & validate
	for(var i = 0; i < array_length(items); i ++) {
		var item = items[i]
		
		if item[$ "hidden"] or item[$ "malformed"]
			array_delete(items, i, 1)
	}
	
	
	
	event_user(0)
}