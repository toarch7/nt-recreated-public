if lockstep_stop
	exit

if (!instance_exists(Logo) && show < array_length(credittext)) {
    draw_set_color(c_white)
	draw_align(fa_center, fa_middle)
    draw_text_nt(view_width / 2, view_height / 2, string(credittext[show]))
	draw_align()
}