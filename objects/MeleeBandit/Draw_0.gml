if lockstep_stop
	exit

if gunangle <= 180 draw_sprite_ext(sprPipe, - 1, x, y, 1, wepflip, gunangle + wepangle, c_white, 1) draw_sprite_ext(sprite_index, - 1, x, y, right, 1, 0, c_white, 1)
if gunangle > 180 draw_sprite_ext(sprPipe, - 1, x, y, 1, wepflip, gunangle + wepangle, c_white, 1)