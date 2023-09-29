if lockstep_stop
	exit

var mx = device_mouse_x_to_gui(0),
	my = device_mouse_y_to_gui(0)

time += 0.4

if error != "" {
	scrDrawAlignCenter()
	
	var str = loc(error)
	
	if time < 2
		str = "@r" + str
	
	draw_text_nt(gui_w / 2, gui_h / 2, str)
	
	scrDrawAlignDefault()
	
	exit
}

if !loaded {
	if time > 4 {
		scrDrawAlignCenter()
		
		draw_text_nt(gui_w / 2, gui_h / 2 - 24, loc("LOADING THE LIST"))
		
		scrDrawAlignDefault()
		
		draw_sprite(sprSaving, time, gui_w / 2, gui_h / 2 + 8)
		
		draw_sprite(sprSaving, time, gui_w / 2 + 1, gui_h / 2 + 9)
		draw_sprite(sprSaving, time, gui_w / 2    , gui_h / 2 + 9)
	}
		
	exit
}
else event_user(1)

if max_height > view_height - 64 {
	draw_sprite_ext(sprOptionSlider, 0, view_width - 16, 48, 1.6, 1, 270, c_white, 1)
	draw_sprite_ext(sprSliderEnd, 0, view_width - 18 + (dragging > 0), 48 + (view_height - 96) * (ypos / max_height), 1, 1, 90, dragging ? c_uigray : c_white, 1)
	
	if dragging != -1 && mouse_check_button(mb_left) {
		for(var i = 0; i < 4; i ++) {
			if !device_mouse_check_button(i, mb_left)
				continue
			
			var mx = device_mouse_x_to_gui(i),
				my = device_mouse_y_to_gui(i)
			
			if (mx >= view_width - 32 && mx <= view_width) or dragging {
				var pos = my - 48,
					pos_max = view_height - 96
				
				var _ypos = ypos
				
				ypos = max_height * clamp(pos / pos_max, 0, 1)
				
				if ypos != _ypos
					sound_play_pitchvol(sndHover, 1.1 + random(0.1), 0.3)
				
				if !dragging {
					snd_play(sndSlider)
					dragging = true
				}
				
				speed = 0
			}
			
			break
		}
	}
}

if dragging && !mouse_check_button(mb_left) {
	snd_play(sndSliderLetGo)
	dragging = false
}

draw_set_color(c_black)
draw_rectangle(0, -4, view_width, 36, 0)
draw_rectangle(0, view_height - 36, view_width, view_height + 4, 0)
draw_set_color(c_white)

scrDrawAlignCenter()
draw_bigname(view_width / 2 - 48, 24, loc("RESOURCEPACKS"), c_uigray)

var dx = pack_width * 0.75 + 18

if browsing && loaded {
	draw_set_color(c_uigray)
	draw_text_shadow_scale(dx - 6, 24, loc("RATING"), 0.67)
	draw_text_shadow_scale(dx + 52, 24, loc("UPDATED"), 0.67)
	
	draw_set_color(c_white)
}

scrDrawAlignDefault()

if browsing {
	var str = loc("SORT") + ": ",
		img = sort + sort_mode * 2
	
	var xx = 8,
		yy = view_height - 18
	
	if loaded && point_in_rectangle(mx, my, xx, yy - 10, xx + 120, yy + 10) {
		if mouse_ui_clicked() {
			sort ++
			
			if sort > 1 {
				sort = 0
				sort_mode ++
				
				if sort_mode > 1
					sort_mode = 0
			}
			
			snd_play(sndClick)
			
			event_user(0)
		}
		
		if !sort_pointed {
			sort_pointed = true
			snd_play(sndHover)
		}
	}
	else if sort_pointed
		sort_pointed = false
	
	str += "#" + loc(sort ? "BY UPDATES" : "BY RATING") + " (" + (sort_mode ? "V" : "^") + ")"
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_middle)
	
	draw_set_color(sort_pointed ? c_white : c_uigray)
	
	draw_sprite_ext(
		sprResourcepackBrowserSort, img,
		
		xx + 12, yy - sort_pointed,
		1, 1, 0,
		draw_get_color(), 1
	)
	
	draw_text_nt(xx + 16, yy - sort_pointed, str)
	
	draw_set_color(c_white)
	
	draw_set_valign(fa_top)
}

with BackButton
	event_perform(ev_draw, ev_gui)