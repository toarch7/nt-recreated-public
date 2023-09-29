/// @description Downloading
if async_load[? "id"] == list_request {
	if async_load[? "status"] != 0
		exit
	
	var file = async_load[? "result"]
	
	if !file_exists(file) {
		error = "FAILED TO LOAD THE LIST"
		
		exit
	}
	
	var valid = []
	
	items = json_parse(file_read(file))
	
	var _time = unix_timestamp()
	
	// filter & validate
	for(var i = 0; i < array_length(items); i ++) {
		var item = items[i]
		
		if item[$ "hidden"] or item[$ "malformed"]
			continue
		
		var meta = item.meta,
			
			name = meta.name,
			short = meta.descriptionShort,
			description = meta.description	
			
		if string_length(name) >= 27
			name = string_copy(name, 1, 24) + "..."
		
		if string_length(short) >= 100
			short = string_copy(short, 1, 97) + "..."
			
		if string_count("#", short)
			short = string_replace_all(short, "#", "\#")
			
		if string_count("#", description)
			description = string_replace_all(description, "#", "\#")
		
		meta.name = name
		meta.descriptionShort = short
		meta.description = description
		
		if item.full_name == "toarch7/risk-of-rain-resourcepack"
		or item.full_name == "kcd-shichen/Hyper-Horizon"
			item.created = _time * 1000
		
		if !item[$ "promoted"] {
			var diff = _time - (item.created div 1000)
			
			print("diff", _time, item.created, item.name, ">", diff)
			
			item.promoted = (diff) < 604800
		}
		else item.promoted = false
		
		array_push(valid, item)
	}
	
	items = valid
	
	max_height = array_length(valid) * 40
	
	event_user(0)
	
	var check = {}
	
	for(var i = 0; i < array_length(items); i ++) {
		var item = items[i]
		
		if check[$ item.full_name]
			continue
		
		if item.promoted {
			array_delete(items, i, 1)
			array_insert(items, 0, item)
		}
		
		check[$ item.full_name] = true
	}
}