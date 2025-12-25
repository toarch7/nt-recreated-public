if lockstep_stop
	exit

draw_sprite(sprMainMenuSplat, splat, x, y)

var col = (available ? (hover ? c_white : c_uigray) : c_uidark),
	
	name = scrMenuButtonName(),
	offset = appear + hover

if image_blend != c_white
	col = image_blend

y -= offset

if is_string(name) {
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	
	draw_text_bigname(x, y, name, col)
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}
else {
	draw_sprite_ext(sprite_index, image_index, x + 1, y + 1, 1, 1, 0, c_black, 1)
	draw_sprite_ext(sprite_index, image_index, x, y + 1, 1, 1, 0, c_black, 1)
	
	draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, col, 1)
}

y += offset