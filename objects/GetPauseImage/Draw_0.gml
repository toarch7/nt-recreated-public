
with UberCont {
	if pausespr && sprite_exists(pausespr)
	    sprite_delete(pausespr)
	
	var srf = surface_create(view_width, view_height)
	surface_set_target(srf)
	
	draw_surface_ext(application_surface, 0, 0, 1 / opt_scaling, 1 / opt_scaling, 0, c_white, 1)
	
	draw_set_blend_mode(bm_add)
	draw_set_color(c_black)
	draw_rectangle(0, 0, view_width, view_height, 0)
	draw_set_color(c_white)
	draw_set_blend_mode(bm_normal)
	
	surface_save(srf, "paus.png")
	
	surface_reset_target()
	
	pausespr = sprite_create_from_surface(srf, 0, 0, view_width, view_height, 0, 0, 0, 0)
	
	getpauseimg = 0
}

instance_destroy()