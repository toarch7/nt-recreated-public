if (async_load[? "id"] != req || async_load[? "status"] != 0) exit

items = []

try {
	var _leaderboard_data = json_parse(async_load[? "result"]),
		_leaderboard_entries = _leaderboard_data.entries,
		_entry_keys = struct_keys(_leaderboard_entries),
		_entry_count = array_length(_entry_keys),
		_my_id = scrSavedataGetUID()
	
	for(var i = _entry_count - 1; i >= 0; i --) {
		var _key = _entry_keys[i],
			_run_entry = _leaderboard_entries[$ _key]
		
		if (is_struct(_run_entry)) {
			if (is_undefined(my_entry) && _key == _my_id) {
				_run_entry.name = scrSavedataGetUsername()
				my_entry = _run_entry
			}
			
			array_push(items, _run_entry)
			_run_entry.appear = 0
		}
	}
	
	print("my entry (for " + _my_id + "):", my_entry)
	
	if my_entry == undefined && local_entry != undefined {
		array_push(items, local_entry)
		my_entry = local_entry
	}
	
	array_sort(items, function(a, b) {
		return sign(b.kills - a.kills)
	})
		
	loaded = true
	
	var _entry_index = array_get_index(items, my_entry) + 1
	
	if _entry_index >= 0 {
		ypos = _entry_index * draw_step_size - 45
	}
	
	max_height = max(0, (array_length(items) * draw_step_size) - 160)
}
catch(e) {
	print_error(e.longMessage)
}
