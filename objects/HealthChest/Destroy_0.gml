if spr_dead != -1 {
	with instance_create(x, y, ChestOpen) {
		sprite_index = other.spr_dead
		image_index = sprite_get_number(sprite_index) - 1
	}
}

