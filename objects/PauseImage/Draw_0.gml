if lockstep_stop
	exit


with UberCont {
	if is_numeric(pausespr) && sprite_exists(pausespr) {
	    sprite_delete(pausespr)
	}
	
	var _surface = surface_create(view_width, view_height)
	surface_set_target(_surface)
	
	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha)
	draw_surface_stretched(application_surface, 0, 0, view_width + 1, view_height)
	gpu_set_blendmode(bm_normal)
	
	with TopCont {
		if darkness && surface_exists(dark) {
			gpu_set_blendmode(bm_subtract)
			draw_surface_ext(dark, 0, 0, 1, 1, 0, c_white, 1)
		    gpu_set_blendmode(bm_normal)
		}
	}
	
	surface_reset_target()
	
	//surface_save(_surface, "pause.png")
	
	pausespr = sprite_create_from_surface(_surface, 0, 0, view_width, view_height, 0, 0, 0, 0)
	
	getpauseimg = false
}

instance_destroy()