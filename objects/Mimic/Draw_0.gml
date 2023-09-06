if lockstep_stop
	exit

draw_sprite_ext(sprite_index, - 1, x, y, right, 1, 0, c_white, 1)

if instance_exists(GameCont) && GameCont.area == 101 {
    draw_sprite(sprPlayerBubble, - 1, x, y)
}