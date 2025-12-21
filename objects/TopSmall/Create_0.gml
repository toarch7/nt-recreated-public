if (position_meeting(x, y, Wall) || position_meeting(x, y, Floor)) {
    instance_destroy()
    exit
}

var _area;

if (!instance_exists(MenuGen) && !instance_exists(Menu)) {
    _area = GameCont.area
}
else {
	_area = area_campfire
}

sprite_index = asset_get_index("sprWall" + string(_area) + "Trans")

image_index = irandom(image_number)
image_speed = 0