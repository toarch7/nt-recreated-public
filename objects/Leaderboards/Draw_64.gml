if instance_exists(DailyList)
	exit

if loaded {
	if max_height > 0
		event_user(1)
}
else {
	event_user(0)
	
	draw_sprite(sprDailyLoad, current_frame * 0.4, view_width / 2, 18)
	
	exit
}

var start = ypos div 20,
	count = min(array_length(items), start + display),
	press = mouse_ui_clicked(),
	size = draw_step_size,
	pos = 48, xoff = 32, _gap_size = 260,
	full = UberCont.opt_resolution

if !full {
	xoff = 16
	_gap_size = 220
}

if last_min != start or last_max != count {
	if !dragging {
		snd_play(sndHover, 1.1 + random(0.1), 0.3)
	}
	
	for(var i = last_min; i < last_max; i ++) {
		if i < start or i > count {
			var item = items[i]
			
			if item == my_entry
				splat = 0
			
			item.appear = 0
		}
	}
	
	last_min = start
	last_max = count
}

var display_max = view_height div size

if display < display_max {
	snd_play_pitch(sndAppear, 0.2)
	display ++
	
	if display > display_max
		display = display_max
	
	anim[display] = 2
}

draw_set_font(fntM1)
draw_set_valign(fa_middle)

for(var i = start; i < count; i ++) {
	var item = items[i],
		yy = start * size - ypos + pos
	
	draw_set_color(c_uigray)
	
	if item == my_entry {
		var splat_num = sprite_get_number(sprDailySplat)
		splat = approach(splat, splat_num - 1, 0.4)
		
		draw_sprite(sprDailySplat, splat, 24 + xoff, yy)
		
		draw_set_color(c_white)
	}
	
	draw_set_halign(fa_right)
	draw_text_nt(16 + xoff, yy, string(i + 1) + ".")
	
	var _name = item.name,
		_special_characters = false
	
	if _gap_size < 260 {
		_name = string_copy(_name, 1, 12)
	}
	
	var _image = scr_race_get_skin_subimage(item.char, item.skin),
		_use_cjk_font = string_supported_info[$ _name]
	
	if (_use_cjk_font == undefined) {
		_use_cjk_font = font_string_check_unsupported_chars(fntM1, string_upper(_name))
		string_supported_info[$ _name] = _use_cjk_font
	}
	
	draw_sprite(sprMapIcon, _image, 42, yy)
	
	draw_set_halign(fa_left)
	
	if (_use_cjk_font) draw_set_font(global.language_font_cjk)
	draw_text_nt(40 + xoff, yy, _name)
	
	draw_set_font(fntM1)
	
	draw_sprite(sprKillsIcon, 0, 160 + (full * 30) + xoff, yy)
	draw_text_nt(172 + (full * 30) + xoff, yy, item.kills)
	
	draw_text_nt(_gap_size + xoff, yy, scrAreaGetMapName(item.area, item.subarea, item.loops))
	
	pos += size
}

draw_set_valign(fa_top)
draw_reset_font()

event_user(0)

draw_align(fa_center, fa_middle)
/// @loc:token [R:MainMenu] Leaderboards "LEADERBOARDS"
draw_text_bigname(view_width / 2, 18, loc("R:MainMenu:Leaderboards", "LEADERBOARDS"), c_uigray)
draw_align()