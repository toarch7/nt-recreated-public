// killswitch
if !UberCont.leaderboards_allowed {
	with instance_create(0, 0, DailyList)
		viewtype = other.type
	
	exit
}

var url_base = "https://raw.githubusercontent.com/toarch7/ntm-browser/main/leaderboards/"
req = scrHttpGet(url_base + type + "list.json")

var file = "local_" + type + "_entry.dat"

if file_exists(file) {
	local_entry = struct_secure_load(file)
	
	if is_struct(local_entry) {
		var _seed = UberCont.daily_seed
		
		if UberCont.weekly_run
			_seed = scrReal(UberCont.weekly_data[? "seed"])
		
		local_entry.name = scrGetUsername()
		
		if local_entry.runId != base_convert(_seed, 10, 16)
			local_entry = undefined
	}
	else local_entry = undefined
}