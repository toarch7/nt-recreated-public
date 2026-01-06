/// @description Teleport away

var _floor = instance_nearest(x, y, Floor)

with (_floor) {
	other.x = bbox_center_x
	other.y = bbox_center_y
}

if (place_meeting(x, y, Wall)) {
	with (instance_create(x, y, PortalClear)) image_rescale(0.5)
}
