/// @description Teleport away

if (current_frame < crownpedtime) {
	var _floor = instance_nearest(
		x + choose(-96, -64, -32, 0, 32, 64, 96),
		y + choose(-96, -64, -32, 0, 32, 64, 96), Floor)
	
	with (_floor) {
		other.x = bbox_center_x
		other.y = bbox_center_y
	}
	
	if (place_meeting(x, y, Wall)) {
		with (instance_create(x, y, PortalClear)) image_rescale(0.5)
	}
}