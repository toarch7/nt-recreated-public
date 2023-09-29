for(var i = 0; i < array_length(sprites); i ++)
	sprite_delete(sprites[i])

if !opt_resolution_last {
	UberCont.opt_resolution = opt_resolution_last
	
	with UberCont
		scrSetViewSize(false)
}