if hover > 4 exit

draw_sprite(sprMenuButtonSplat, splat, x - 16, y - 6)

var col = (available ? (light ? c_white : c_ltgray) : c_gray),
	name = scrMenuButtonName()

if !loc_exists(name) {
	draw_sprite_ext(sprite_index, image_index, x, y + 1 - hover, 1, 1, 0, c_black, 1)
	draw_sprite_ext(sprite_index, image_index, x + 1, y + 1 - hover, 1, 1, 0, c_black, 1)
	draw_sprite_ext(sprite_index, image_index, x, y - hover, 1, 1, 0, col, 1)
}
else {
	draw_set_halign(fa_center)
	draw_set_valign(fa_center)
	
	draw_bigname(x, y - hover, string_upper(loc(name)), col)
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}