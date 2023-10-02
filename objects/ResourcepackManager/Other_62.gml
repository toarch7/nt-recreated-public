/// @description Downloading
if async_load[? "id"] == list_request {
	if async_load[? "status"] != 0
		exit
	
	var file = async_load[? "result"]
	
	try {
		items = json_parse(file_read(file))
	}
	catch(e) {
		error = "@sUNABLE TO FETCH THE LIST.#PLEASE TRY CHECK YOUR NETWORK#OR TRY AGAIN LATER"
		snd_play(sndClickBack)
		
		print(e.message); exit
	}
	
	var valid = []
	
	var _time = unix_timestamp()
	
	// filter & validate
	for(var i = 0; i < array_length(items); i ++) {
		var item = items[i]
		
		if item[$ "hidden"] or item[$ "malformed"]
			continue
		
		var meta = browsing ? item.meta : item,
			
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
		
		if !item[$ "promoted"] {
			var diff = _time - (item.created div 1000)
			item.promoted = (diff) < 604800
		}
		else item.promoted = false
		
		item.external = true
		
		array_push(valid, item)
	}
	
	//test
	/*
	repeat (irandom(100) + 100) {
		var dupe = json_parse(json_stringify(valid[irandom(array_length(valid) - 1)]))
		array_push(valid, dupe)
	}*/
	
	items = valid
	
	max_height = max(0, array_length(valid) * 40 - 160)
	
	loaded = true
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

if async_load[? "id"] == download_repo_req {
	if async_load[? "status"] != 0
		exit
	
	var result = async_load[? "result"]
	
	try {
		var data = json_parse(result)
		
		if data && is_string(data[$ "default_branch"]) {
			if is_undefined(clicked_item)
				clicked_item = {}
			
			var item = clicked_item
			
			item.owner = data.owner.login
			item.created = data.created_at
			item.updated = data.updated_at
			item.stars = data.stargazers_count
			item.full_name = data.full_name
			
			self.direct_download(data.full_name, data.default_branch)
		}
	}
	catch(e) {
		error = "@sUNABLE TO FETCH INFO.#PERHAPS WRONG REPO WAS GIVEN OR IT DOESN'T EXIST"
		snd_play(sndClickBack)
		
		print(e.message); exit
	}
}

if async_load[? "id"] == pack_download {
	var status = async_load[? "status"]
	
	print(json_encode(async_load))
	
	if status == 1 {
		download_size = async_load[? "sizeDownloaded"]
		download_length = async_load[? "contentLength"]
	}
	else if status == 0 {
		downloaded = 1
		snd_play(sndHover)
		
		install_resourcepack(async_load[? "result"])
	}
	else {
		error = "UNEXPECTED DOWNLOAD STATUS " + string(status)
		snd_play(sndClickBack)
	}
}