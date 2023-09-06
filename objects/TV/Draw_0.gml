if lockstep_stop
	exit

draw_sprite(sprite_index, - 1, x, y)
anim += 0.4
draw_sprite(myscreen, anim, x - 5, y - 5)
if Menu.race = 9 draw_sprite(sprTVPause, anim, x - 5, y - 5)