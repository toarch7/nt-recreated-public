if async_load[? "id"] == req {
	if async_load[? "status"] != 0
		exit
	
	try {
		var res = json_parse(async_load[? "result"]),
			entries = res.entries,
			keys = struct_keys(entries),
			uid = scrGetUid()
		
		items = []
		
		for(var i = 0; i < array_length(keys); i ++) {
			var key = keys[i],
				item = entries[$ key]
			
			if key == uid
				my_entry = item
			
			item.appear = 0
			
			array_push(items, item)
		}
		
		if keyboard_check(ord(1))
			my_entry.kills *= 10
		
		if keyboard_check(ord(2))
			my_entry.kills *= 0
		
		if keyboard_check(ord(3))
			my_entry.kills *= 1000
		
		array_sort(items, function(a, b) {
			return sign(b.kills - a.kills)
		})
		
		loaded = true
		
		var p = array_indexof(items, my_entry) + 1
		
		if p > 0
			ypos = p * draw_step_size - 45
		
		max_height = max(0, (array_length(items) * draw_step_size) - 160)
	}
	catch(e) {
		print(e.longMessage)
	}
}