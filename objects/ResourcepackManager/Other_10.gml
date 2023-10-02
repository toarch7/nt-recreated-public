/// @description Load & sort

ypos = 0
speed = 0

if browsing {
	if items == undefined {
		list_request = http_get_file(resourcepack_url, "resourcepacks.json"); exit
	}
	
	array_sort(items, sorting[sort, sort_mode])
	
	exit
}

items = Resourcepacks

if !array_length(items) {
	error_active = true
	error = "YOU DON'T HAVE ANY PACKS INSTALLED."
	time = 2
}

loaded = true

max_height = max(0, array_length(items) * 40 - 160)

array_sort(items, function(a, b) {
	if a.priority == b.priority
		return sign(b.installtime - a.installtime)
	
	if b.priority > a.priority
		return 1
	
	return -1
})