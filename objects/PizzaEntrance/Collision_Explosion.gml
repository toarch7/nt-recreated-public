if image_index == 0 && !instance_exists(FrogQueen) {
	image_index = 1
	
	with (enemy) {
		hp = 0
		instance_destroy()
	}
	
	with GameCont {
		area = area_pizza_sewers
		subarea = 0
	}
	
	instance_create(bbox_center_x, bbox_center_y, Portal)
}