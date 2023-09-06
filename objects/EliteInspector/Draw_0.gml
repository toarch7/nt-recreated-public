if lockstep_stop
	exit

if gunangle <= 180 draw_sprite_ext(sprEnergyBaton, - 1, x, y, 1, wepflip, gunangle + wepangle, c_white, 1)

if control draw_sprite_ext(sprInspectorControl, - 1, x, y, right, 1, angle, c_white, 1)

if sprite_exists(sprite_index) draw_sprite_ext(sprite_index, - 1, x, y, right, 1, angle, c_white, 1)

if GameCont.area == 101 draw_sprite(sprPlayerBubble, - 1, x, y)

if gunangle > 180 draw_sprite_ext(sprEnergyBaton, - 1, x, y, 1, wepflip, gunangle + wepangle, c_white, 1)