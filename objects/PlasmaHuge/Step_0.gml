image_yscale = image_xscale

if image_xscale <= 0.4 instance_destroy()

instance_create(
	random_range(bbox_left, bbox_right),
	random_range(bbox_top, bbox_bottom),
	PlasmaTrail)