/// @description Browse & sort

browsing = true

if items == undefined {
	list_request = http_get_file(resourcepack_url, "resourcepacks.json")
	
	loaded = false
	
	exit
}

var _items = items

array_sort(_items, sorting[sort, sort_mode])

print(_items)

loaded = true