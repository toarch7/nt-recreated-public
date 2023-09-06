if lockstep_stop
	exit

if global.time % 5 == 0 && surface_exists(shad) &&
(surface_get_width(shad) != view_width or surface_get_height(shad) != view_height) {
	surface_resize(shad, view_width, view_height)
}

scrShadows()