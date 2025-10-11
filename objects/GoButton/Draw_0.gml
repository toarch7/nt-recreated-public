if lockstep_stop
	exit

if loc_exists("button_GO") {
	draw_set_halign(fa_right)
	draw_set_valign(fa_middle)
	
	draw_text_bigname(x + 10, y, loc("button_GO"), c_ultra)
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}
else draw_self()

if instance_exists(Menu) {
	depth = Menu.depth - 1
}