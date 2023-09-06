if lockstep_stop
	exit

draw_set_alpha(0.6)
draw_set_color(c_black)
draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + view_height, 0)
draw_set_alpha(1)
draw_set_color(c_black)

draw_text(view_xview + 160, view_yview + 81, string_hash_to_newline(string(name)))
draw_text(view_xview + 161, view_yview + 81, string_hash_to_newline(string(name)))
draw_text(view_xview + 161, view_yview + 80, string_hash_to_newline(string(name)))
draw_set_color(c_white)
draw_text(view_xview + 160, view_yview + 80, string_hash_to_newline(string(name)))

/*
draw_set_color(c_black)
draw_rectangle(view_xview,view_yview,view_xview+view_width,view_yview+64,0)
draw_rectangle(view_xview,view_yview+view_height,view_xview+view_width,view_yview+view_height - 64,0)
*/

/* */
/*  */