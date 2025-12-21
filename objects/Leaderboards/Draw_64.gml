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

draw_set_valign(fa_middle)

for(var i = start; i < count; i ++) {
	var item = items[i],
		yy = start * size - ypos + pos
	
	draw_set_color(c_uigray)
	
	if item == my_entry {
		var splat_num = sprite_get_number(sprDailySplat)
		splat = lerp(splat, splat_num, 0.4)
		
		draw_sprite(sprDailySplat, splat, 24 + xoff, yy)
		
		draw_set_color(c_white)
	}
	
	draw_set_halign(fa_right)
	draw_text_shadow(20 + xoff, yy, string(i + 1) + ".")
	
	var _name = item.name
	
	if _gap_size < 260 {
		_name = string_copy(_name, 1, 12)
	}
	
	var _image = scr_race_get_skin_subimage(item.char, item.skin)
	_name = $"@(sprMapIcon:{_image})  " + _name
	
	draw_set_halign(fa_left)
	
	draw_text_nt(32 + xoff, yy, _name)
	
	draw_sprite(sprKillsIcon, 0, 160 + (full * 30) + xoff, yy)
	draw_text_nt(172 + (full * 30) + xoff, yy, item.kills)
	
	draw_text_nt(_gap_size + xoff, yy, scrAreaGetMapName(item.area, item.subarea, item.loops))
	
	pos += size
}

draw_set_valign(fa_top)

event_user(0)

scrDrawAlignCenter()
draw_text_bigname(view_width / 2, 18, loc("LEADERBOARDS"), c_uigray)
scrDrawAlignDefault()