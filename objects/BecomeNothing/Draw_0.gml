if lockstep_stop
	exit

sprite_index = spr_idle

draw_sprite(sprite_index, drawimg, x, y)
draw_sprite(sprNothingSkeleton, deadanim, x, y - 22)

if deadanim < 5
	deadanim += 0.4