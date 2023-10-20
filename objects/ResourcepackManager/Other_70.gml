/// @description Resourcepack installed

if async_load[? "type"] != "unzip"
	exit

var packdir = string_replace_all(async_load[? "entry"], "\\/", "/") + "/"

if clicked_item != undefined {
	var item = json_parse(json_stringify(clicked_item))
	
	item.installtime = unix_timestamp() * 1000
	item.priority = 0
	
	file_write(packdir + "githubdata.json", json_stringify(item))
	
	if item[$ "meta"]
		file_write(packdir + "meta.json", json_stringify(item.meta))
}

downloaded = 2

reload_needed = true