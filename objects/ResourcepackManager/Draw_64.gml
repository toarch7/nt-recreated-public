/// @description hell

time += 0.4

if error != "" {
	DrawAlignCenter;
	
	var str = loc(error)
	
	if time < 2
		str = "@r" + str
	
	draw_text_nt(gui_w / 2, gui_h / 2, str)
	
	DrawAlignDefault;
	
	exit
}

if browsing {
	if !loaded {
		if time > 4 {
			DrawAlignCenter;
			
			draw_text_nt(gui_w / 2, gui_h / 2 - 24, loc("LOADING THE LIST"))
			
			DrawAlignDefault;
			
			draw_sprite(sprSaving, time, gui_w / 2, gui_h / 2 + 8)
			
			draw_sprite(sprSaving, time, gui_w / 2 + 1, gui_h / 2 + 9)
			draw_sprite(sprSaving, time, gui_w / 2    , gui_h / 2 + 9)
		}
		
		exit
	}
	
	event_user(2)
}

