array_foreach(sprites, function(_sprite) {
	if (sprite_exists(_sprite)) {
		sprite_flush(_sprite)
		sprite_delete(_sprite)
	}
})

if (!opt_resolution_last) {
	UberCont.opt_resolution = opt_resolution_last
	with (UberCont) scrSetViewSize(false)
}

self.screenshots_cleanup()

if (surface_exists(text_surface)) {
	surface_free(text_surface)
}

directory_destroy_recursive(game_directory + "install")

if (global.safemode) {
	show_message_async("The game is running in safe mode. Resourcepacks won't be applied until the game is restarted.")
}
else if (reload_needed) {
	instance_create(0, 0, ResourcepackRestartMessage)
}