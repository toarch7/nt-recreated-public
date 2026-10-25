function sprite_strip_save(_sprite_index, _path) {
    var _frames = sprite_get_number(_sprite_index)
    var _width = sprite_get_width(_sprite_index)
    var _height = sprite_get_height(_sprite_index)

    if (!(_width || _height || _frames)) {
		print("unable to write", _sprite_index, "(invalid sprite)")
		exit
	}
	
	if ((_width * _frames) > 5_000 || _height > 5_000) {
		print("unable to write", sprite_get_name(_sprite_index), "(strip width or sprite height exceed 5000)")
		exit
	}

    var _surface = surface_create(_width * _frames, _height)
	
    surface_set_target(_surface)
	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha)
	draw_clear_alpha(c_black, 0)
	
	var _xoffset = sprite_get_xoffset(_sprite_index),
		_yoffset = sprite_get_yoffset(_sprite_index)
	
    for (var _subimage = 0; _subimage < _frames; _subimage++) {
        draw_sprite(_sprite_index, _subimage, _subimage * _width + _xoffset, _yoffset)
    }

    surface_reset_target()
    surface_save(_surface, _path)
	gpu_set_blendmode(bm_normal)
    surface_free(_surface)
}