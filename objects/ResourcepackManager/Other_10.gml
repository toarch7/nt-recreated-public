/// @description Browse & sort

browsing = true

if items == undefined {
	list_request = http_get_file(resourcepack_url, "resourcepacks.json")
	
	loaded = false
	
	exit
}

var _items = items

print("Sorting", sort, sort_mode)
array_sort(_items, sorting[sort, sort_mode])

ypos = 0
speed = 0

loaded = true