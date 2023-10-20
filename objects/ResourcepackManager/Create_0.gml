items = undefined
list_request = -1

listing = false
browsing = false
loaded = false

sort = 0 // sort kind (stars, update)
sort_mode = 0

sprites = []
icon_map = {}
icon_requests = {}

sorting = [
	// stars
	[
		// ascending
		function(a, b) {
			return sign(b.stars - a.stars)
		},
		// descending
		function(a, b) {
			return sign(a.stars - b.stars)
		}
	],
	
	// date
	[
		// ascending
		function(a, b) {
			return sign(b.updated - a.updated)
		},
		// descending
		function(a, b) {
			return sign(a.updated - b.updated)
		}
	]
]

resourcepack_url = "https://raw.githubusercontent.com/toarch7/ntm-browser/main/resourcepacks.json"

anim = 0
time = 0

error = ""
error_shake = 0
error_active = false

reload_needed = false

wheel_value = 0

ypos = 0
max_height = 0
scroll = 0

friction = 0.4

if global.desktop
	friction = 1

depth = 1000

dragging = false

last_min = 0
last_max = 0

sort_pointed = false
url_pointed = false
download_pointed = false

opt_resolution_last = UberCont.opt_resolution

print("Resolution current", opt_resolution_last)

if !opt_resolution_last {
	UberCont.opt_resolution = true

	with UberCont
		scrSetViewSize(false)
}

pack_width = (view_width - 40)

touch_duration = 0
clicked_item = undefined
open_time = 0
show_details = false
splat = 0
wait = 0

mx_last = 0
my_last = 0

screenshots_cleanup = function() {
	for(var i = 0; i < array_length(screenshots); i ++)
		sprite_delete(screenshots[i])
	
	screenshots = []
	screenshot_index = 1
	screenshot_type = 0
	
	screenshot_image = -1
}

load_screenshots = function() {
	var item = clicked_item,
		cdn = -1
	
	if !show_details or !is_struct(item)
		return -1
	
	var filename = string_replace(screenshot_formats[screenshot_type], "%", string(screenshot_index))
	
	if browsing {
		cdn = "https://raw.githubusercontent.com/" + item.full_name + "/" + item.branch + "/" + filename
	}
	else if is_string(item[$ "path"])
		cdn = item.path + filename
	
	if cdn == -1
		return -1
	
	var spr = sprite_add(cdn, 1, 0, 0, 0, 0)
	
	if !browsing { // todo: remove after engine upgrade
		
		var map = ds_map_create()
		
		map[? "id"] = spr
		map[? "http_status"] = 200
		
		event_perform_async(ev_async_web_image_load, map)
		
	}
	
	return spr
}

sprites_cleanup = function() {
	var m = 20
	
	if array_length(sprites) < m
		exit
	
	while true {
		var len = array_length(sprites)
		
		if len <= m
			break
		
		for(var i = m; i < array_length(sprites); i ++) {
			var spr = sprites[i]
			
			array_delete(sprites, i, 1)
			sprite_delete(spr)
		}
		
	}
}

direct_download = function(repo, branch = -1) {
	download_repo_req = -1
	pack_download = -1
	
	if branch == -1 {
		download_repo_req = http_get("https://api.github.com/repos/" + repo)
	}
	else pack_download = http_get_file("https://github.com/" + repo + "/archive/refs/heads/" + branch + ".zip", "pack.zip")
	
	downloading = true
	download_size = 0
	download_length = -1
	downloaded = 0
}

screenshot_image = -1
screenshot_index = 1
screenshot_type = 0
screenshots = []

screenshot_formats = [
	"screenshot%.png", "Screenshot%.png",
	"screenshot%.jpg", "Screenshot%.jpg",
	"screenshot%.jpeg", "Screenshot%.jpeg",
]

screenshot_view = false

pack_download = -1
downloading = false
downloaded = false
download_size = 0
download_length = 0
download_destroy = false
download_repo_req = -1

description_width = view_width / 1.75
description_height = 48
text_surface = surface_create(description_width, description_height)
text_scroll = 0

directory_destroy_recursive(game_directory + "install")