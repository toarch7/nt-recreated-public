if lockstep_stop exit

sprite_index = spr_idle
draw_sprite(sprite_index, drawimg, x, y)

if deadanim < sprite_get_number(sprThroneCorpseDead) {
	draw_sprite(sprThroneCorpseDead, deadanim, x, y - 22)
	deadanim += 0.4
}