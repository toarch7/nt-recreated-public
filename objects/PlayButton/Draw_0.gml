if lockstep_stop
	exit

draw_sprite(sprMenuButtonSplat, splat, x, y)

var col = (available ? (hover ? c_white : c_uigray) : c_uidark),
	
	name = scrMenuButtonName(),
	offset = appear + hover

y -= offset

if !loc_exists(name) {
	draw_sprite_ext(sprite_index, image_index, x + 1, y + 1, 1, 1, 0, c_black, 1)
	draw_sprite_ext(sprite_index, image_index, x, y + 1, 1, 1, 0, c_black, 1)
	
	draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, col, 1)
}
else {
	draw_set_halign(fa_center)
	draw_set_valign(fa_center)
	
	draw_bigname(x, y, string_upper(loc(name)), col)
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}

y += offset