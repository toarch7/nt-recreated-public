with UberCont {
	if (is_numeric(pausespr) && sprite_exists(pausespr)) sprite_delete(pausespr)
	
	var _app_width = surface_get_width(application_surface),
		_app_height = surface_get_height(application_surface),
		_surface = surface_create(view_width, view_height)
	
	surface_set_target(_surface)
	draw_clear(c_black)
	
	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha)
	draw_surface_ext(application_surface,
		0, 0, view_width / _app_width, view_height / _app_height, 0, c_white, 1)
	gpu_set_blendmode(bm_normal)
	
	surface_reset_target()
	
	pausespr = sprite_create_from_surface(_surface, 0, 0,
		surface_get_width(_surface), surface_get_height(_surface), 0, 0, 0, 0)
	
	getpauseimg = false
}

instance_destroy()