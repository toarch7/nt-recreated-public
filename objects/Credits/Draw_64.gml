if lockstep_stop
	exit

if (!instance_exists(Logo) && text != "") {
    draw_set_color(c_white)
	
	var _px = gui_w div 2,
		_py = gui_h div 2
	
	draw_align(fa_center, fa_middle)
	
	if (largetext) {
		draw_set_valign(fa_top)
		_py += scroll - height + (gui_h * 0.6)
	}
	
    draw_text_nt(_px, _py, text)
	
	draw_align()
}