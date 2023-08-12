items = undefined
list_request = -1

listing = false
browsing = false

loaded = true

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
			return b.stars - a.stars
		},
		// descending
		function(a, b) {
			return a.stars - b.stars
		}
	],
	
	// date
	[
		// ascending
		function(a, b) {
			return b.updated - a.updated
		},
		// descending
		function(a, b) {
			return a.updated - b.updated
		}
	]
]

resourcepack_url = "https://raw.githubusercontent.com/toarch7/ntm-browser/main/resourcepacks.json"

anim = 0
time = 0

error = ""

wheel_value = 0

ypos = 0
max_height = 0

friction = 0.4

depth = 1000