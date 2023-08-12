if ingame {
    draw_set_color(c_black)
    draw_set_alpha(0.9)
	
    draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + view_height, 0)
	
    draw_set_color(c_white)
    draw_set_alpha(1)
}

if instance_exists(debris) {
	if category != OptionCategory.Video {
		debris = noone; exit
	}
	
	with debris {
		image_angle = (get_timer() / 16666) % 360
		
		image_xscale = 1.5
		image_yscale = 1.5
		
		draw_self()
	}
}