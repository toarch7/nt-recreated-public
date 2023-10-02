for(var i = 0; i < array_length(sprites); i ++)
	sprite_delete(sprites[i])

if !opt_resolution_last {
	UberCont.opt_resolution = opt_resolution_last
	
	with UberCont
		scrSetViewSize(false)
}

self.screenshots_cleanup()

if surface_exists(text_surface)
	surface_free(text_surface)

directory_destroy_recursive(game_directory + "install")

if reload_needed {
	if reload_needed == 2 {
		game_restart()
	}
	else load_resourcepacks()
}