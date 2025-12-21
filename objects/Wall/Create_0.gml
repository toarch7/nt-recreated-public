var _area = area_campfire
if (!instance_exists(MenuGen) && !instance_exists(Menu)) {
    _area = GameCont.area
}

topspr = asset_get_index("sprWall" + string(_area) + "Top")
outspr = asset_get_index("sprWall" + string(_area) + "Out")
sprite_index = asset_get_index("sprWall" + string(_area) + "Bot")
image_speed = 0

l = 0
r = 0
w = 24
h = 24

if (random(150) < 1) {
	image_index = 3
}
else {
	image_index = choose(0, 0, 0, 0, 0, 0, 0, 1, 2)
}

image_index += choose(0, 4)

if (random(200) < 1) {
	topindex = 3
}
else {
	topindex = choose(0, 0, 0, 0, 0, 0, 0, 1, 2) + choose(0, 4, 8)
}

outindex = choose(0, 0, 0, 0, 1, 2, 3, 4) + choose(0, 4)

if (!place_meeting(x, y + 16, Floor)) visible = false