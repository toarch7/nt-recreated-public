if (other.typ != 0 && team != other.team) {
	instance_destroy(other.id)
	
	if (sprite_index != spr_fade) {
		sprite_index = spr_fade
		image_speed = 0.4
		image_index = 0
		speed = 0
	}
}