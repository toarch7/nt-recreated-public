
with UberCont {
	if pausespr && sprite_exists(pausespr)
	    sprite_delete(pausespr)
	
	var srf = surface_create(view_width, view_height)
	surface_set_target(srf)
	
	draw_surface_ext(application_surface, 0, 0, 1 / opt_scaling, 1 / opt_scaling, 0, c_white, 1)
	
	with TopCont {
		if !darkness
			continue
		
		gpu_set_blendmode(bm_subtract)
		
	    if surface_exists(dark)
			draw_surface_ext(dark, 0, 0, 1, 1, 0, c_white, 1)
		
	    gpu_set_blendmode(bm_normal)
	}
	
	gpu_set_blendmode(bm_add)
	draw_set_color(c_black)
	
	draw_rectangle(0, 0, view_width, view_height, 0)
	
	draw_set_color(c_white)
	gpu_set_blendmode(bm_normal)
	
	surface_reset_target()
	
	surface_save(srf, "paus.png")
	
	pausespr = sprite_create_from_surface(srf, 0, 0, view_width, view_height, 0, 0, 0, 0)
	
	getpauseimg = 0
}

instance_destroy()