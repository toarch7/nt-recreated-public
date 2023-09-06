if lockstep_stop
	exit

draw_sprite(sprite_index, - 1, x, y)
draw_sprite(sprNothingSkeleton, deadanim, x, y - 22)
if deadanim < 5 deadanim += 0.4