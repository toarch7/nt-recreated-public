if lockstep_stop
	exit

var mx = device_mouse_x_to_gui(0),
	my = device_mouse_y_to_gui(0)

time += 0.4

if error != "" {
	scrDrawAlignCenter()
	
	var str = loc(error)
	
	if !error_active {
		sound_play_pitch(sndCrownRandom, 0.6 + random(0.3))
		
		error_active = true
		time = 0
		
		error_shake = 4
	}
	
	if time < 2
		str = "@r" + str
	
	draw_text_nt(gui_w / 2 + orandom(error_shake), gui_h / 2, str)
	
	error_shake = lerp(error_shake, 0, 0.4)
	
	scrDrawAlignDefault()
	
	exit
}

if !loaded {
	if time > 4 {
		scrDrawAlignCenter()
		
		draw_text_nt(gui_w / 2, gui_h / 2 - 24, loc("LIST IS LOADING..."))
		
		scrDrawAlignDefault()
		
		gpu_set_fog(true, c_black, 0, 0)
		draw_sprite(sprDailyLoad, time, gui_w / 2 + 1, gui_h / 2 + 9)
		draw_sprite(sprDailyLoad, time, gui_w / 2    , gui_h / 2 + 9)
		gpu_set_fog(false, 0, 0, 0)
		
		draw_sprite(sprDailyLoad, time, gui_w / 2, gui_h / 2 + 8)
	}
		
	exit
}
else if !downloading {
	event_user(1)
	scrDrawSidearts()
}

if max_height > 0 && !show_details && !downloading {
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

if loaded {
	if show_details && !downloading {
		var num = sprite_get_number(sprLoadout) - 1
		
		if splat < num {
			splat += 0.67
			
			if splat > num
				splat = num
		}
		
		speed = 0
		dragging = -1
	}
	else if splat > 0 {
		splat -= 0.67
		
		if splat < 0
			splat = 0
	}
	
	if splat >= 1 {
		draw_set_color(c_black)
		
		draw_set_alpha(1)
		draw_rectangle(0, 0, view_width / 3, gui_h, 0)
		
		draw_set_color(c_white)
		
		draw_sprite_ext(sprLoadout, splat, view_width / 3, view_height - 36, -1, 1, 0, c_white, 1)
		
		event_user(2)
	}
}

with BackButton
	event_perform(ev_draw, ev_gui)

scrDrawAlignCenter()

if downloading {
	var side = " ~ "
	
	if global.time % 60 > 30
		side = "   "
	
	if downloaded {
		if downloaded == 2 {
			draw_text_nt(view_width / 2, view_height / 2, "@g" + string_replace(loc("%#INSTALLED SUCCESSFULLY!##CLICK ANYWHERE TO CONTINUE"), "%", clicked_item.full_name))
			
			if mouse_ui_clicked() {
				if !download_destroy {
					downloading = false
					downloaded = 0
				}
				else instance_destroy()
			}
		}
		else {
			draw_text_nt(view_width / 2, view_height / 2, side + loc("INSTALLING") + side)
		}
	}
	else if download_repo_req != -1 && pack_download == -1 {
		draw_text_nt(view_width / 2, view_height / 2 - 10, "@d" + side + loc("QUERYING REPO INFO") + side)
	}
	else {
		draw_text_nt(view_width / 2, view_height / 2 - 10, side + loc("DOWNLOADING") + side)
		
		if download_length > 0 {
			var sw = sprite_get_width(sprOptionSlider),
				sh = sprite_get_height(sprOptionSlider)
			
			var p = download_size / download_length
			
			draw_sprite(sprOptionSlider, 0, view_width / 2 - sw / 2 + 10, view_height / 2 + 12)
			draw_sprite_part(sprOptionSlider, 1, 0, 0, sw * p, sh, view_width / 2 - sw / 2, view_height / 2 + 3)
			
			scrDrawAlignCenter()
			draw_text_shadow(view_width / 2, view_height / 2 + 12, string(p * 100) + "%")
			scrDrawAlignDefault()
		}
		else {
			draw_text_nt(view_width / 2, view_height / 2, string(download_size / 1024) + " KB.")
		}
	}
}
else draw_bigname(view_width / 2 - (48 * browsing), 24, loc("RESOURCEPACKS"), c_uigray)

if show_details {
	if screenshot_view {
		var spr = screenshot_image
		
		sprite_set_offset(spr, sprite_get_width(spr) / 2, sprite_get_height(spr) / 2)
		
		var w = gui_w,
			h = gui_h
		
		display_set_gui_size(sprite_get_width(spr), sprite_get_height(spr))
		
		
		draw_set_color(c_uigray)
		draw_set_alpha(0.8)
		draw_rectangle(0, 0, gui_w, gui_h, false)
		draw_set_color(c_white)
		draw_set_alpha(1)
		
		draw_sprite_ext(spr, 0, gui_w / 2, gui_h / 2, 0.9, 0.9, 0, c_white, 1)
		
		display_set_gui_size(w, h)
		
		sprite_set_offset(spr, 0, 0)
		
		with BackButton
			event_perform(ev_draw, ev_gui)
	}
	
	exit
}

var dx = pack_width * 0.75 + 18

if loaded && !downloading {
	if browsing {
		draw_set_color(c_uigray)
		draw_text_shadow_scale(dx - 6, 24, loc("RATING"), 0.67)
		draw_text_shadow_scale(dx + 52, 24, loc("UPDATED"), 0.67)
		draw_set_color(c_white)
	}
	else if !browsing {
		scrDrawAlignCenter()
		draw_text_shadow_scale(dx - 32, 36, loc("LOAD PRIORITY"), 0.5)
		scrDrawAlignDefault()
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
}