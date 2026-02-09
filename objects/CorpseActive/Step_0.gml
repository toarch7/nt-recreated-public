if lockstep_stop
	exit

if (object_index == CorpseActive && speed == 0) {
    var _sprite_index = sprite_index,
		_image_index = image_index,
		_image_speed = image_speed
	
	instance_change(Corpse, false)
	
    sprite_index = _sprite_index
    image_index = _image_index
    image_speed = _image_speed
}